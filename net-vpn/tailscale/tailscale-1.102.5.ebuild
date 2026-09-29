# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.102.5"
VERSION_LONG="1.102.5-t8908149ca"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/8908149cab706b043db0a3ffb967fbf0bfa9f9eb -> tailscale-1.102.5-8908149.tar.gz
https://direct.funtoo.org/9f/bc/46/9fbc460bec15633d13f187ba1f06e707849e887aa9356beb33f914a727d24c1633f195fe7b95bdc828d38dd8064cfaf4dde9f30506106d901a6940df69a9f8ec -> tailscale-1.102.5-funtoo-go-bundle-b2b2dea0e476fb72010fe646d152da3aa9e5b0a0a4533d14e89206d7b21c0ed3c7c85a7c5528e5a8b8a757e5d93534aee799924f3adbea74f24d27921e098065.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-8908149"

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