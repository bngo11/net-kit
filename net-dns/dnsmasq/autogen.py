#!/usr/bin/env python3

from bs4 import BeautifulSoup

async def generate(hub, **pkginfo):
	html_data = await hub.pkgtools.fetch.get_page("https://thekelleys.org.uk/dnsmasq/")
	soup = BeautifulSoup(html_data, "html.parser")
	links = soup.find_all("a")
	links.reverse()
	version = None
	final_name = None

	for link in links:
		href = link.get("href")
		if href.endswith("tar.xz"):
			final_name = href
			break

	if final_name:
		version = final_name.split(".tar")[0].split("-")[-1]
		url = f"https://thekelleys.org.uk/dnsmasq/{final_name}"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
		)
		ebuild.push()


# vim: ts=4 sw=4 noet
