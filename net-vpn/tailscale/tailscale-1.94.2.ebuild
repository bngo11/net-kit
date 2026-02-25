# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.94.2"
VERSION_LONG="1.94.2-t0a29cf18b"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/0a29cf18b56e478b9cd33af07755fcae90d5171a -> tailscale-1.94.2-0a29cf1.tar.gz
https://direct.funtoo.org/fb/56/7a/fb567a7284568321c3b0179d6191289a0ea8b4e28c1996b883932c89c996b5319af75327b9858d54dcbfdb269b93e621573c8b84a3a9daa844586e8d88c93b7c -> tailscale-1.94.2-funtoo-go-bundle-4f0dac41cabc241d42e62ef4238e1e61e9fa80aeb49a95e5515b5fccf70e22f68c5c6f6b16c09023b3968bda0bf499fa51587b63f2742e7d724addbfb1f75a21.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-0a29cf1"

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