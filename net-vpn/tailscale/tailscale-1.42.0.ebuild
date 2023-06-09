# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.42.0"
VERSION_LONG="1.42.0-tab797f0ab"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/ab797f0abd067750d474668ed615d7dc9d258cec -> tailscale-1.42.0-ab797f0.tar.gz
https://direct.funtoo.org/d9/9c/20/d99c2033f151b49741e399cb92e8f064d2c539991d1b14124362327ea76ce2ff5768eedb320e7d586fa335ffbc88340e0d34e2d6a40ae9d6e642da49b94e0fef -> tailscale-1.42.0-funtoo-go-bundle-c5fb9f7a0c59823de258181f898be59dc18c28de8afdf5ae9c7af278e6434f4149f02067f2af60e54298eb8bf1e3f0e0bd19c55331fdf516a6588d565b52c35d.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-ab797f0"

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