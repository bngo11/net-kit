# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.48.1"
VERSION_LONG="1.48.1-t0e9f04c83"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/0e9f04c83c38eefac6bf55657184f22d11d777b9 -> tailscale-1.48.1-0e9f04c.tar.gz
https://direct.funtoo.org/1f/ab/ce/1fabce583ca07544e9dc1d10f430fc84faf345db6f37e058e0f0c9b183f118f60c53d4e9cba846c0a244d55c1b484c1459b72a0a17330082baba6924415921b9 -> tailscale-1.48.1-funtoo-go-bundle-77b07373144ba54b2d274ef6deab24a0c4e9b2e4b6a3b7b0dacf7fdb7bef6430892218675605c7ab0ff9caabb4e66eca9b5b91d09ccc97654a5259eab8cb8f93.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-0e9f04c"

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