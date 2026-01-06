# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.92.5"
VERSION_LONG="1.92.5-t1c215f6e5"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/1c215f6e5acba0b11f9c62a999aac23ecb76f3a8 -> tailscale-1.92.5-1c215f6.tar.gz
https://direct.funtoo.org/2f/10/ae/2f10aeb21b23619e413efa893a4a03d035f8afe8902f931c621c987b5250dbe7fa882b4041725ec4420418ecfa98f8cd272e28d375d208874bd3f2964d42ea66 -> tailscale-1.92.5-funtoo-go-bundle-7576760e851ac8841d9c6713729879005059463672f0eb88a825e5b99631abb69701f3e2327792ec0b8a2efc76e28aecf1aa713fbae8fddfe9265bbbf7abbcc6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-1c215f6"

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