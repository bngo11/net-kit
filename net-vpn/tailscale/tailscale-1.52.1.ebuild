# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.52.1"
VERSION_LONG="1.52.1-t75d3c9385"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/75d3c93858d7c9f80495fdae9e88967382ea333e -> tailscale-1.52.1-75d3c93.tar.gz
https://direct.funtoo.org/69/e6/c0/69e6c038e5bb80032691c8c01ece2a4d0e259d760e43910adc84ba9237a8a1c6e5e72ed0b04ae117753a58329ad19bfc2ee04090169e526b1ba193aa7574184b -> tailscale-1.52.1-funtoo-go-bundle-5ab38d2b36d636d6dfb4f3cdb0ba7359c7eded8e4fb4fbd5e13d219697754669550526dda14854394a9965a2204a3b024585f979cf2409dcc7d8330977b3af3b.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-75d3c93"

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