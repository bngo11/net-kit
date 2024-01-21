# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.58.0"
VERSION_LONG="1.58.0-te5d341d96"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/e5d341d9620ea8e975d278834c8fe2a24cbc43c9 -> tailscale-1.58.0-e5d341d.tar.gz
https://direct.funtoo.org/c6/0d/60/c60d60cf9484bc96b5e017a0fc94a7eae585efc3f494047f45c19ea192192fcc4498d6aca05bb752c41b28d073605288fa1d0f9d35bcb1f609abcd6981dace2e -> tailscale-1.58.0-funtoo-go-bundle-c08cfbd633dea69bb8198adc08ed42758ac792a0aa0dfc9c56fa2dac28f9e862f44a747966704302c383bcc73c5a08186c5d4af33de280f6ca146afa89e561f0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-e5d341d"

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