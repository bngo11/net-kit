# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.72.0"
VERSION_LONG="1.72.0-t9a0f00ea8"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/9a0f00ea8ed08d1a94b357fb232ac9d44a512664 -> tailscale-1.72.0-9a0f00e.tar.gz
https://direct.funtoo.org/cd/a4/a7/cda4a753601516e963adcbbf092ce82ba2a6aca18ccbef402262b64a51a68704677946eee27857e8bad7ea23323629dcc30dc248784d385b5d2cc366fdb94015 -> tailscale-1.72.0-funtoo-go-bundle-4b235c449dd28501d8123343febd2703e1a3160323d496c7cabc0e2d500e32008ee1512b34acf2499c0192c09db02821581e40c558036e3a6653beb177d676bf.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-9a0f00e"

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