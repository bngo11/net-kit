# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.90.8"
VERSION_LONG="1.90.8-tedc9d2245"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/edc9d22455eb839bd411d1b0555da979d1fb4d75 -> tailscale-1.90.8-edc9d22.tar.gz
https://direct.funtoo.org/02/2f/ab/022fab37a053199551342dc954fcbd26303bdcad855b06a1f19bf8fc71b1b93167b14306f245e1ca081724394af00624fbe9fc0e9aa8afbe31e638d1a4d2ef04 -> tailscale-1.90.8-funtoo-go-bundle-b0b324b83a075972a9671d94b4ad1c1d738ac70b9a3ef5201b35b5e5edc77da90d98c97d76e950c007d4e3e13c1a028e4ea71c11e40e7dd82a922cb1905c3b20.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-edc9d22"

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