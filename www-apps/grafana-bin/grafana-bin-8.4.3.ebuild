# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user systemd

MY_PN=${PN/-bin/}
MY_PV=${PV/_beta/-beta}
S=${WORKDIR}/${MY_PN}-${MY_PV}

DESCRIPTION="Multi-platform analytics and interactive visualization web application"
HOMEPAGE="https://grafana.org"
SRC_URI="https://dl.grafana.com/oss/release/grafana-8.4.3.linux-amd64.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/fontconfig
	systemd? ( sys-apps/systemd:= )"

QA_PREBUILT="usr/bin/grafana-* ${QA_EXECSTACK}"
QA_PRESTRIPPED=${QA_PREBUILT}

pkg_setup() {
	enewgroup grafana
	enewuser grafana -1 -1 /usr/share/grafana grafana
}

src_install() {
	keepdir /etc/grafana
	insinto /etc/grafana
	newins "${S}"/conf/sample.ini grafana.ini
	rm "${S}"/conf/sample.ini || die

	# Frontend assets
	insinto /usr/share/${MY_PN}
	doins -r public conf

	dobin bin/grafana-cli
	dobin bin/grafana-server

	newconfd "${FILESDIR}"/grafana.confd grafana
	newinitd "${FILESDIR}"/grafana.initd.3 grafana
	use systemd && systemd_newunit "${FILESDIR}"/grafana.service grafana.service

	keepdir /var/{lib,log}/grafana
	keepdir /var/lib/grafana/{dashboards,plugins}
	fowners grafana:grafana /var/{lib,log}/grafana
	fowners grafana:grafana /var/lib/grafana/{dashboards,plugins}
	fperms 0750 /var/{lib,log}/grafana
	fperms 0750 /var/lib/grafana/{dashboards,plugins}
}

postinst() {
	elog "${PN} has built-in log rotation. Please see [log.file] section of"
	elog "/etc/grafana/grafana.ini for related settings."
	elog
	elog "You may add your own custom configuration for app-admin/logrotate if you"
	elog "wish to use external rotation of logs. In this case, you also need to make"
	elog "sure the built-in rotation is turned off."
	elog
	elog "As of version 7.0.0, ${MY_PN} uses a separate plugin to render panels and dashboards to PNGs"
	elog
	elog "If you want this functionality simply run:"
	elog "grafana-cli plugins install grafana-image-renderer"
}