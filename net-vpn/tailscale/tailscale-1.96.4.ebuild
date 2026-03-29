# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.96.4"
VERSION_LONG="1.96.4-t8cf541dfd"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/8cf541dfd1e0a97096c01cb775d5e26336f3bc6c -> tailscale-1.96.4-8cf541d.tar.gz
https://direct.funtoo.org/44/9e/0c/449e0ce5af5a9f7d518c4b368b580dc9661d843100f4ea486e13a7c3bbf89a87997668c5d172e193f1dece29f40db2f1b5718412db907f926b3de1e5892e7b41 -> tailscale-1.96.4-funtoo-go-bundle-4dac31e08fd4b6927ad66ce33faafb9627f47ea77b2ae28a15abb059527b367994b102d51ca57ce32637e74fb17145c9ab49b0aa64ec58ee54c17786c9717480.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-8cf541d"

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