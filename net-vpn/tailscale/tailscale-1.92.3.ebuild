# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.92.3"
VERSION_LONG="1.92.3-ta17f36b9b"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/a17f36b9ba505fa624a2e69034741dbd212c1141 -> tailscale-1.92.3-a17f36b.tar.gz
https://direct.funtoo.org/fe/cb/d1/fecbd14a053fd1caa7d50c9524245e7a0825ad4eccea1ad5dbf3311cbdf39240511ccb5afdd156690f0ec972c991c2fa640aef360b755874c36a76992e45afc1 -> tailscale-1.92.3-funtoo-go-bundle-7576760e851ac8841d9c6713729879005059463672f0eb88a825e5b99631abb69701f3e2327792ec0b8a2efc76e28aecf1aa713fbae8fddfe9265bbbf7abbcc6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-a17f36b"

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