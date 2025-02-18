#!/usr/bin/env python3

from bs4 import BeautifulSoup

async def generate(hub, **pkginfo):
	base_url = f"https://thekelleys.org.uk/dnsmasq/"
	html_data = await hub.pkgtools.fetch.get_page(f"{base_url}")
	soup = BeautifulSoup(html_data, "html.parser")
	links = soup.find_all("a")
	links.reverse()
	version = None

	for link in links:
		final_name = link.get("href")
		if final_name and final_name.endswith(".tar.xz"):
			version = final_name.rsplit("-", 1)[-1].rstrip(".tar.xz")

			try:
				list(map(int, version.split(".")))
				break

			except ValueError:
				continue

	if version:
		url = f"{base_url}{final_name}"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
		)

		ebuild.push()


# vim: ts=4 sw=4 noet
