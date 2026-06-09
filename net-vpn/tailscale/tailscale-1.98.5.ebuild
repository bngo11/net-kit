# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.98.5"
VERSION_LONG="1.98.5-t8f8fe6a2e"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/8f8fe6a2e167459ed0f62616287b61b0b0a54eb5 -> tailscale-1.98.5-8f8fe6a.tar.gz
https://direct.funtoo.org/ce/5d/f1/ce5df1b42ba9d9ceed3fbd4912f523d6a76428c32d56fad310d96e2fa8024d5c873b49550ed3118de939fde74044aaddf366f593ab35f54e4739ef40e097020f -> tailscale-1.98.5-funtoo-go-bundle-5e587834714881c8e3220dac283319822bfb61b24ee7826c6cba94c83965ff3a3cd55f206a3b57a4d29bd7b841d2cda6c8542bef0bd6cec2544dda016cd2f183.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-8f8fe6a"

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