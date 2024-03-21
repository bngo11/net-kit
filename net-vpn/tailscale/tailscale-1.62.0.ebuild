# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.62.0"
VERSION_LONG="1.62.0-tdf4d4ebd4"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/df4d4ebd41b6670c8ca371e5e32ea29e00e69708 -> tailscale-1.62.0-df4d4eb.tar.gz
https://direct.funtoo.org/b3/6a/e2/b36ae206d7fc3688319dbee9e2a0569ab9da73a2d8fed9d0340f180b15512f55c1e1ce3354ab896781991e249bbc63600671da3095f2ad7bb6b48c825d2c37f1 -> tailscale-1.62.0-funtoo-go-bundle-4bd980c4729c692e8f8a1a8e5b4ccf1518b010fe904e1b27e856c166eab8e95e36aa8451bca9456e618fb936aada8b1537dbe6550cd3b80b1d43cee285053fff.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-df4d4eb"

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