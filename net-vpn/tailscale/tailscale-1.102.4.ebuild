# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.102.4"
VERSION_LONG="1.102.4-t3caf7d9e7"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/3caf7d9e7dcaba589cfc58beda596929733e4fea -> tailscale-1.102.4-3caf7d9.tar.gz
https://direct.funtoo.org/8b/55/af/8b55af4b6cf81bad52c0368ed6e579280349a41f8b289e2cca4e6cb1902a71f178a89b4a43815fc748df71cf68923011e57ca7a22523c4cb7236765e3e8c6732 -> tailscale-1.102.4-funtoo-go-bundle-b2b2dea0e476fb72010fe646d152da3aa9e5b0a0a4533d14e89206d7b21c0ed3c7c85a7c5528e5a8b8a757e5d93534aee799924f3adbea74f24d27921e098065.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-3caf7d9"

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