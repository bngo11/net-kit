# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.40.0"
VERSION_LONG="1.40.0-t9bdaece3d"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/9bdaece3d7c3c83aae01e0736ba54e833f4aea51 -> tailscale-1.40.0-9bdaece.tar.gz
https://direct.funtoo.org/fd/a0/d2/fda0d23f5713e3a1daf70d85acaaecc7f8b00a43d7709ff3d9e225762cfef5a3ef9717e148c49bcef3edf7ba5c0a8b881769faedbf20e330b701e52ffbacf531 -> tailscale-1.40.0-funtoo-go-bundle-268ca18b963064565c82e8c4591b335f3a19b6c8f997cce3cc733036a07f18f7e99c884137af609749ce561d0715e263db32f07c6fbcab160ce67ab059c0f012.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-9bdaece"

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