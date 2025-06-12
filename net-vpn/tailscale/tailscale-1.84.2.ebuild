# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.84.2"
VERSION_LONG="1.84.2-t5d271bebf"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/5d271bebfc0d7f08e236290549d9a476550681b4 -> tailscale-1.84.2-5d271be.tar.gz
https://direct.funtoo.org/9d/ed/e0/9dede01d008fcd56bff0d4bd79e37adb61ba052f055276a0da18658733f8005afbb895f7b3805b5eac06c092c51437687623d2925f641173c71e6aa985d9ebb4 -> tailscale-1.84.2-funtoo-go-bundle-19631a433f69bcf534bdeb4ed371c6899a3217a7987ae6b1845181f30ef02f6d71d0496cfc816bc6516a32435453c395563091e34488057a5210bc3134314243.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-5d271be"

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