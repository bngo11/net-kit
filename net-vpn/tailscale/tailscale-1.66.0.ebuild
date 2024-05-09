# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.66.0"
VERSION_LONG="1.66.0-t2b2f4268a"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/2b2f4268ad16fb3330ef3dea8e4df92443ade52e -> tailscale-1.66.0-2b2f426.tar.gz
https://direct.funtoo.org/dd/a7/b1/dda7b1252f4eb5d681aa0531addcf1adb4f309a88f00467dca24cdca6408ccb091358f3960eabefb839947f6301ef8e53aee356887b300ad1f6e5766ef105105 -> tailscale-1.66.0-funtoo-go-bundle-54cca0a29d0abbe77282fa7e0be858e17f805ddc7883eeef0c9a3dd4b7b146098dc63ff33afb7c1870aaf6e3ea1d233d73b3bf3af55394abd71154ea0a2aa386.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-2b2f426"

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