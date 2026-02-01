# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.94.1"
VERSION_LONG="1.94.1-t62c6f1cd7"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/62c6f1cd7560763edcc552251abadf7dd4659f82 -> tailscale-1.94.1-62c6f1c.tar.gz
https://direct.funtoo.org/25/61/18/25611863d95dad19cf75e7a673add319e07f01377a2243996a3774ad71badfe62192c88ff4140d0e60810d65970fbb325b07f9b1ac6457ef88d41244821cbc25 -> tailscale-1.94.1-funtoo-go-bundle-4f0dac41cabc241d42e62ef4238e1e61e9fa80aeb49a95e5515b5fccf70e22f68c5c6f6b16c09023b3968bda0bf499fa51587b63f2742e7d724addbfb1f75a21.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-62c6f1c"

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