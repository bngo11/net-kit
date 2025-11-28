# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.90.9"
VERSION_LONG="1.90.9-t6e8a4f2de"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/6e8a4f2de795ae6801f4b599e3f64ca6b5465c01 -> tailscale-1.90.9-6e8a4f2.tar.gz
https://direct.funtoo.org/3d/a4/38/3da4389e5e47f019d491547b22fb7431b0d740b8cb13d598f11047005c19f49e01531b7eaef94523e17dfc411ca35eb07bd1e0fb2fee1403f6ea9818e53179c9 -> tailscale-1.90.9-funtoo-go-bundle-b0b324b83a075972a9671d94b4ad1c1d738ac70b9a3ef5201b35b5e5edc77da90d98c97d76e950c007d4e3e13c1a028e4ea71c11e40e7dd82a922cb1905c3b20.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-6e8a4f2"

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