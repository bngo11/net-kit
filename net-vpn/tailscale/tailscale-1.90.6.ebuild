# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.90.6"
VERSION_LONG="1.90.6-t0238943bb"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/0238943bbbe5f6e7d4a384e309801c1b43d056b7 -> tailscale-1.90.6-0238943.tar.gz
https://direct.funtoo.org/ef/b4/02/efb4028d1a30c6bfeaa675c2d4f60ecd970ed29b04082726c95bff69c5ac29ff762fe8526aff62d29053bf628282f1ed9fda31d5cc2795b9949800210c5a8645 -> tailscale-1.90.6-funtoo-go-bundle-b0b324b83a075972a9671d94b4ad1c1d738ac70b9a3ef5201b35b5e5edc77da90d98c97d76e950c007d4e3e13c1a028e4ea71c11e40e7dd82a922cb1905c3b20.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-0238943"

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