#!/usr/bin/env python3

from metatools.version import generic
from pathlib import Path
import re


def get_release(release_data):
	for rel in release_data:
		try:
			version = rel.get("name").split("/")[-1]
			list(map(int, version.split(".")))
			url = rel.get("tarball_url")
			return version, url
		except:
			continue

async def generate(hub, **pkginfo):
	user = "ArcticaProject"
	repo = "nx-libs"
	name = pkginfo["name"]
	tags_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{user}/{repo}/tags", is_json=True
	)
	version, url = get_release(tags_data)
	final_name = f"{name}-{version}.tar.gz"
	src_artifact = hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)
	await src_artifact.fetch()
	src_artifact.extract()
	libx11_pattern = re.compile(r"\$\(LN\)\s*libNX_X11\.so(\.?.*)\s*\$\(BUILDLIBDIR\)\/libX11.so\1\s*@@\\")
	imake_rules_path = next(Path(src_artifact.extract_path).glob("*/nx-X11/config/cf/Imake.rules"))
	with open(imake_rules_path, "r") as imake_rules_file:
		imake_rules_data = imake_rules_file.read()
	libx11_symlinks = libx11_pattern.findall(imake_rules_data)
	libx11_expansion = "{" + ",".join(libx11_symlinks) + "}"
	src_artifact.cleanup()
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		libx11_expansion=libx11_expansion,
		artifacts=[src_artifact],
	)
	ebuild.push()
