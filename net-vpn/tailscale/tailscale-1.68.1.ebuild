# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.68.1"
VERSION_LONG="1.68.1-tf02ad8397"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/f02ad839770b7d1453e88d64b02162ce81cdd7a8 -> tailscale-1.68.1-f02ad83.tar.gz
https://direct.funtoo.org/6f/a6/af/6fa6af19db30c3ceeecdc9081aa942364e190eac2c75186fd91b306fefaeeb161dcc6fe17d6be3d326704ddc49bf49b1e5da955895e52e7c552244133dbf4193 -> tailscale-1.68.1-funtoo-go-bundle-b05ccfaaa7d325490259cdf7caa0fb0dd96fe9610c6346a5b2b00bfee34ec8681c7f64659ece64416a5b39b9bde2cad3ebd75e031f2fefff275f1ffc377edc91.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-f02ad83"

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