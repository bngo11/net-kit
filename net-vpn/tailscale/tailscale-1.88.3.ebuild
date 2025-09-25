# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.88.3"
VERSION_LONG="1.88.3-tf453b350e"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/f453b350e4ac2b690498137e3a07894437831730 -> tailscale-1.88.3-f453b35.tar.gz
https://direct.funtoo.org/f1/0b/5c/f10b5cf53aede2d23e450a04c0adbf8bfbc06c2fe33b57643e887d935c92ea8a7dc6d06c800120fec433e846b3722d96dd9f135cf43a6f18b4f24146a9d77c86 -> tailscale-1.88.3-funtoo-go-bundle-2a48bf911192069affefe6475ce2c385603489d6fa9b3cfb923bb39cf925ae77f7072cc8daa9298c0b923064ec0fec31d3b409c8cba73325c5b698bd1c0ee8d4.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-f453b35"

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