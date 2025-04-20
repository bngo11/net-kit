# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.82.5"
VERSION_LONG="1.82.5-tdec88625e"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/dec88625eafdcac4dfae8f592705919184ec4df7 -> tailscale-1.82.5-dec8862.tar.gz
https://direct.funtoo.org/7c/80/2b/7c802b75a1f5005b5cff1365f3d6b38a4f8ad1115e393dea1a4cab3367247e37bc1ff199f32017d596e4b5fb6cfb4f1919f4590198aeca8e4dd33cb7b91567bd -> tailscale-1.82.5-funtoo-go-bundle-05605e1ad180eaa35a7867c50d0c84f636a5e220b5025d523c37df55d15c9fb1660e9e7f2f1c55d3fdb6a2f124a3b288ad777382c207f67b72f9d3dca01599d4.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-dec8862"

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