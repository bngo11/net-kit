# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.98.3"
VERSION_LONG="1.98.3-ta16e0f20c"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/a16e0f20cff0acd5617fd1b315df32cdad17a8fa -> tailscale-1.98.3-a16e0f2.tar.gz
https://direct.funtoo.org/a2/83/28/a283285758728007463090cd9061129128ec91744c07783201c0fe0bf9d2f6f51ae34bbcfbc93bc34d52bbc695c6548a493034f8508449ca64ee2bcfe47c5b88 -> tailscale-1.98.3-funtoo-go-bundle-5e587834714881c8e3220dac283319822bfb61b24ee7826c6cba94c83965ff3a3cd55f206a3b57a4d29bd7b841d2cda6c8542bef0bd6cec2544dda016cd2f183.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-a16e0f2"

# This translates the build command from upstream's build_dist.sh to an
# ebuild equivalent.
build_dist() {
	go build -tags xversion -ldflags "
		-X tailscale.com/version.longStamp=${VERSION_LONG}
		-X tailscale.com/version.shortStamp=${VERSION_SHORT}" "$@"
}

src_compile() {
	build_dist ./cmd/tailscale
	build_dist ./cmd/tailscaled
}

src_install() {
	dosbin tailscaled
	dobin tailscale

	insinto /etc/default
	newins cmd/tailscaled/tailscaled.defaults tailscaled
	keepdir /var/lib/${PN}
	fperms 0750 /var/lib/${PN}

	newtmpfiles "${FILESDIR}/${PN}.tmpfiles" ${PN}.conf

	newinitd "${FILESDIR}/${PN}d.initd" ${PN}
	newconfd "${FILESDIR}/${PN}d.confd" ${PN}
}

pkg_postinst() {
	tmpfiles_process ${PN}.conf
}