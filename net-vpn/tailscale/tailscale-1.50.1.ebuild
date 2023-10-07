# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.50.1"
VERSION_LONG="1.50.1-tf45c02bfc"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/f45c02bfcf5ee5790c3af278c9e974c9b9b0e771 -> tailscale-1.50.1-f45c02b.tar.gz
https://direct.funtoo.org/61/1f/95/611f95ed7342969a5ac9ea4d3c1231e2945c207211a4aad99cb1378039cbf9eb62afb2ff0abe59ccb5eee33d702db83e6e0b2a6bbdbd881493f8efa3e65183e7 -> tailscale-1.50.1-funtoo-go-bundle-942e165b4beb3b5b72b5f10eb0814e33fb09e6af5adf8df816a244e120e5c44800c346de7d5a82430cc66c4d5615a9b26e885f47b30318d2aa5159088c2154b0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-f45c02b"

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