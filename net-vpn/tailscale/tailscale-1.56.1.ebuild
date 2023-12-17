# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.56.1"
VERSION_LONG="1.56.1-t906f85d10"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/906f85d10c0b7b653116db19913ebeab85ee01ec -> tailscale-1.56.1-906f85d.tar.gz
https://direct.funtoo.org/37/de/87/37de8716edd054d9f107c3dd5567c880c100282a10795654b91425731315705a4ac7d1c791d646b5d9e582900bcec55045a08ebd072c8474e1bbf30cf41ab95a -> tailscale-1.56.1-funtoo-go-bundle-d502fa13f0dbe9d2599b8c9966a018510cc210bfd392976b07e902acb18c300e7b29e965c842925a6ac9dac45ed9fe4f86be59d09c571d2094328e739edb26db.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-906f85d"

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