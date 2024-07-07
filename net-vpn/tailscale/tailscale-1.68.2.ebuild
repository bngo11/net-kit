# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.68.2"
VERSION_LONG="1.68.2-tc3ed2ce8b"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/c3ed2ce8b57390b589914b9713cc64c2d3625412 -> tailscale-1.68.2-c3ed2ce.tar.gz
https://direct.funtoo.org/85/14/05/851405f0b7f61297b5f1080bc4097598382bc5b8835b2f1cd32012ffd6dc7b05f7b022fb833fd3ed6a12a5498075f0ccc846ff3b013a551556408bf6c5fe13f2 -> tailscale-1.68.2-funtoo-go-bundle-b05ccfaaa7d325490259cdf7caa0fb0dd96fe9610c6346a5b2b00bfee34ec8681c7f64659ece64416a5b39b9bde2cad3ebd75e031f2fefff275f1ffc377edc91.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-c3ed2ce"

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