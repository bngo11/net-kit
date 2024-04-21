# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.64.2"
VERSION_LONG="1.64.2-t67a648908"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/67a6489088355cf14883e407f1767c35e1ca7b4e -> tailscale-1.64.2-67a6489.tar.gz
https://direct.funtoo.org/6b/e3/c6/6be3c6d94e01195742da7b770a24624a0d92dee2369a278fa8826e40bc6736a9f187af0affff31fb3e97363710385bbd877a49c7a7a7224dce3fdc205c04fd48 -> tailscale-1.64.2-funtoo-go-bundle-06caa5b47c38915a6df220d3eb12a800fd9a0a0015ff33486e98649baf99e5cadd543a401fb643772a406d51b337e9b632a3eec8147215026de1cf784fbd49d0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-67a6489"

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