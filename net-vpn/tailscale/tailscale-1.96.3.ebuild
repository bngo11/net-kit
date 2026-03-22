# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.96.3"
VERSION_LONG="1.96.3-t3ffddb134"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/3ffddb1344a2ca023f3f6998b915351eae3d5d67 -> tailscale-1.96.3-3ffddb1.tar.gz
https://direct.funtoo.org/27/4d/49/274d49aa083d5a7aeb25b40ed5f0113d34b00b29f9d822284d3fb09dd6d51e91c79e30ca24d81c5a20c8f90f9a9833407c91f43fca43b55d37b6fbdfa4590647 -> tailscale-1.96.3-funtoo-go-bundle-4dac31e08fd4b6927ad66ce33faafb9627f47ea77b2ae28a15abb059527b367994b102d51ca57ce32637e74fb17145c9ab49b0aa64ec58ee54c17786c9717480.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-3ffddb1"

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