# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.76.1"
VERSION_LONG="1.76.1-t6ab01557c"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/6ab01557c3a7525045d73f140f8c8a2fcffadb47 -> tailscale-1.76.1-6ab0155.tar.gz
https://direct.funtoo.org/a3/e6/30/a3e630f9b4a65926398f62de7d6ee6dab083cbccaa386f9ed1611b301cddc8e4e71ba66215c3c6681cc0e564fd0ca9a1053e8c99e5037e7182045b13823a6444 -> tailscale-1.76.1-funtoo-go-bundle-9db89d219a3d7150d5bf7fac651c8bb1c1bf27b7bbc3ec87864f4e9114eb98f304e6529b5c0522db728492a571bd647aa4519b7144cfb6f57dea652d8ef05d69.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-6ab0155"

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