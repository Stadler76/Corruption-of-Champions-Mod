from __future__ import print_function
import io
import sys
import re
import os


def getImageIDList():
	imgTagRe        = re.compile(r"images\.showImage\([\"']([\w\d-]+)[\"'](?:,.*?)?\)")
	monsterNameRe   = re.compile(r"this\.imageName\s?=\s?[\"'](\w+)[\"'];?")
	ret = set()

	scanPath = "../"
	excludeDirs = {"build-dep", "test", "bit101"}
	for root, dirs, files in os.walk(scanPath, topdown=True):
		dirs[:] = [d for d in dirs if d not in excludeDirs]
		files[:] = [f for f in files if f.endswith(".as")]
		for fileN in files:
			wholePath = os.path.join(root, fileN)
			print("Scanning file: ", wholePath)
			with io.open(wholePath, "r", encoding="utf8") as fp:
				cont = fp.read()
				ret.update(set(imgTagRe.findall(cont)))
				for name in monsterNameRe.findall(cont):
					ret.add("monster-%s" % name)

	print("Found %s image IDs" % len(ret))
	return ret


def genFile():
	imageIDs = list(getImageIDList())
	imageIDs.sort()

	ret = '<?xml version="1.0" encoding="utf-8"?>\n'
	ret += '	<Images>\n'
	ret += '		<ImageList>\n'
	for imId in imageIDs:
		ret += '			<ImageSet id="%s">\n' % imId
		ret += '				<ImageFile>./img/%s</ImageFile>\n' % imId
		ret += '				<ImageFile>./img/%s_1</ImageFile>\n' % imId
		ret += '			</ImageSet>\n'
	ret += '		</ImageList>\n'
	ret += '		<ExtensionList>\n'
	for extension in ["png", "jpg", "jpeg", "gif"]:
		ret += '			<ExtensionType>%s</ExtensionType>\n' % extension
	ret += '		</ExtensionList>\n'
	ret += '	</Images>\n'

	with io.open("images.xml", "w", encoding="utf8") as fp:
		fp.write(ret)


if __name__ == "__main__":
	genFile()
