# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.86.2"
VERSION_LONG="1.86.2-tc47caa10d"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/c47caa10d6268583103fd4363792f577a584492c -> tailscale-1.86.2-c47caa1.tar.gz
https://direct.funtoo.org/4b/95/20/4b95206417bd0fad2b7b2df5d1f0421ba9711875d9a10f9d2bcf160048c9aa8b1eeea8f090ed5bf760b19467c169befb668947caf1159dff677f715f76872da1 -> tailscale-1.86.2-funtoo-go-bundle-8e01b275dd21df997da7c5d284b0bf3c2d919dbaac7fcffeb396a3a688ac3fba44302e8aeaf94ad0de85e6a1aae54bf8cc20e8371f9f0962dee2731c5fd63169.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-c47caa1"

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