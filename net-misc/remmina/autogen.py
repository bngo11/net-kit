#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	json_data = await hub.pkgtools.fetch.get_page("https://gitlab.com/api/v4/projects/7153509/releases", is_json=True)
	version = None
	url = None

	for item in json_data:
		try:
			version = item["name"].strip("v")
			list(map(int, version.split(".")))

			for path in item["assets"]["sources"]:
				if path["format"] == "tar.gz":
					url = path["url"]
					break

			if url:
				break

		except (IndexError, ValueError, KeyError):
			continue
	else:
		version = None
		url = None

	if version and url:
		final_name = f"remmina-{version}.tar.gz"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
		)

		ebuild.push()

# vim: ts=4 sw=4 noet
