# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.48.2"
VERSION_LONG="1.48.2-ta6bcfd691"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/a6bcfd69149c491d7542cc758b762bae8882db04 -> tailscale-1.48.2-a6bcfd6.tar.gz
https://direct.funtoo.org/2d/9f/93/2d9f932231606c32cfb054f9c2aa29c34a144bac7914a894fe7e32fdd74d84c2d670794e4972c874e20418b1778905747ead8dc9331e78e9221de821ab26cf59 -> tailscale-1.48.2-funtoo-go-bundle-77b07373144ba54b2d274ef6deab24a0c4e9b2e4b6a3b7b0dacf7fdb7bef6430892218675605c7ab0ff9caabb4e66eca9b5b91d09ccc97654a5259eab8cb8f93.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-a6bcfd6"

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