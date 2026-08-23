# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.102.3"
VERSION_LONG="1.102.3-t9329c3677"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/9329c3677031109ff6d0b80abee0cddc8f35ff6f -> tailscale-1.102.3-9329c36.tar.gz
https://direct.funtoo.org/86/89/0d/86890df3f77f224f5033b19182aeb09b73359d803342bd7ac892d2289488dbe0d461a611f92bf216576d25405b7b612beefc86067169640d712c354599e8d028 -> tailscale-1.102.3-funtoo-go-bundle-b2b2dea0e476fb72010fe646d152da3aa9e5b0a0a4533d14e89206d7b21c0ed3c7c85a7c5528e5a8b8a757e5d93534aee799924f3adbea74f24d27921e098065.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-9329c36"

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