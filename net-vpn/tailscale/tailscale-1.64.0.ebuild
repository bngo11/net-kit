# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.64.0"
VERSION_LONG="1.64.0-t7e9bebdb2"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/7e9bebdb2470dfbb6e08a3f12a289a7d88128dfb -> tailscale-1.64.0-7e9bebd.tar.gz
https://direct.funtoo.org/c3/78/37/c378370289af4bcf30b0f0e6cf91571856115d46ea2026a550d00a56efbb533e572a9c06421859cf93137b112346f3d5c26f29cb4c960998a9e1f0cc025d28ce -> tailscale-1.64.0-funtoo-go-bundle-06caa5b47c38915a6df220d3eb12a800fd9a0a0015ff33486e98649baf99e5cadd543a401fb643772a406d51b337e9b632a3eec8147215026de1cf784fbd49d0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-7e9bebd"

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