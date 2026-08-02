# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.98.10"
VERSION_LONG="1.98.10-t0ee734d30"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/0ee734d3089846b27bc6ebcddd3d6ee5ec13e04d -> tailscale-1.98.10-0ee734d.tar.gz
https://direct.funtoo.org/59/98/c8/5998c84cd3786826ab5cf2ace16e387c79bdecff499c127793a464db9999f1058d86d2359b791dd0fbd2ae8c0812fae03aaabde3d54577a161efefaf81177432 -> tailscale-1.98.10-funtoo-go-bundle-11d468c8488ba13a39a5e4f582f195bc23e10dbb196de36ce0efff3eff691bbacebc7b5b95615f79ac84a64072b3f74989a44bbbfe6ab3241a0c3602c92090fe.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-0ee734d"

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