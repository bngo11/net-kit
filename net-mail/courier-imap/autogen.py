#!/usr/bin/env python3

from bs4 import BeautifulSoup

async def generate(hub, **pkginfo):
	html_data = await hub.pkgtools.fetch.get_page(f"https://sourceforge.net/projects/courier/files/imap/")
	soup = BeautifulSoup(html_data, "html.parser")
	links = soup.find_all("span")
	version = None

	for link in links:
		cls = link.get("class")
		if cls and 'name' in cls:
			try:
				version = link.text
				list(map(int, version.split(".")))
				final_name = f"courier-imap-{version}.tar.bz2"
				break

			except ValueError:
				continue

	if version:
		url = f"https://sourceforge.net/projects/courier/files/imap/{version}/{final_name}"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
		)

		ebuild.push()

# vim: ts=4 sw=4 noet
