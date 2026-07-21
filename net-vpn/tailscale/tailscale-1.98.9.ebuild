# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.98.9"
VERSION_LONG="1.98.9-t4fb758c39"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/4fb758c39ae5b208b974af14ba6bc896a250394c -> tailscale-1.98.9-4fb758c.tar.gz
https://direct.funtoo.org/68/43/6e/68436e806a7b3d27398f9d415b5b082dee4bb34705751c22b4ee5d9cd65233c7d92b8670578c2c221abcdd4243b83e7eaa8d65390127d10788eb93d1f2660f3f -> tailscale-1.98.9-funtoo-go-bundle-4d3ea645ddd593214c2fd9bd5f18143f228c7f036bb31fb7a643fc0002888426acc5771ab11279cd1830be385cb55bffc1234fff0d5a9c7805356f1fe0c1d2f7.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-4fb758c"

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