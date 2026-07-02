# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.98.8"
VERSION_LONG="1.98.8-t1241b225b"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/1241b225bc798707d02db3570992625d3a16594f -> tailscale-1.98.8-1241b22.tar.gz
https://direct.funtoo.org/08/68/d4/0868d42451741de57b0110d016f611c208576c47ea2a5fb4a229f2c8886de3dd45256b2b4d46a8c5784a4385024e6ae7eadf0d1480975324092b77fca6b8a9f8 -> tailscale-1.98.8-funtoo-go-bundle-4d3ea645ddd593214c2fd9bd5f18143f228c7f036bb31fb7a643fc0002888426acc5771ab11279cd1830be385cb55bffc1234fff0d5a9c7805356f1fe0c1d2f7.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-1241b22"

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