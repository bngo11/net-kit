# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.102.2"
VERSION_LONG="1.102.2-t6cac91817"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/6cac918179d4d673bfebe2fc74f81183ddd73fea -> tailscale-1.102.2-6cac918.tar.gz
https://direct.funtoo.org/3b/28/84/3b2884f56dec1902d25a0afc290efb27a0e0c928a35f1fedd3727ef7a7b31fba76bdf1e279c3036d0ac9cad07eee9d639256360ddf6476f44f940823205c8fa5 -> tailscale-1.102.2-funtoo-go-bundle-b2b2dea0e476fb72010fe646d152da3aa9e5b0a0a4533d14e89206d7b21c0ed3c7c85a7c5528e5a8b8a757e5d93534aee799924f3adbea74f24d27921e098065.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-6cac918"

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