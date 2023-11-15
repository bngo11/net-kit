# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.54.0"
VERSION_LONG="1.54.0-t42cae6916"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/42cae6916c6b06b6d0a686477f96d48a0b49aeb6 -> tailscale-1.54.0-42cae69.tar.gz
https://direct.funtoo.org/05/2b/d7/052bd793a819c22e83fd9d412f0bae35fc8ece1184de1b628a375c4f51c7ad356bb855f86646aba15d1e470911ef01d0dccbbe6516b3068770ad2d874ff8efb1 -> tailscale-1.54.0-funtoo-go-bundle-d1b49b2f06536e593da387339f02a45b12810da37c6090fb6a53a81943b135705a080c291bec92caba8bd61cca3d5a3546c0554b6c2b464a990a64a2d8eb9ec4.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-42cae69"

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