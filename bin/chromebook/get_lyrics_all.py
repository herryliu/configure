#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
#import sys

#sys.setdefaultencoding('utf8')

from mutagen.easyid3 import EasyID3
from opencc import OpenCC
import gecimi


cc_s2t = OpenCC('s2t')
cc_t2s = OpenCC('t2s')

def StoT(simplified):
    traditional = cc_s2t.convert(unicode(simplified,'utf-8'))
    return traditional

def TtoS(traditional):
    simplified = cc_t2s.convert(traditional)
    return simplified

def GetLyric(song, artist):
    lyric = gecimi.Lyric(TtoS(song), TtoS(artist))
    simplified = lyric.get()
    print(simplified)
    traditional = StoT(simplified)
    print(traditional)
    return traditional

def SaveToFile(mp3file, lyric):
    if mp3file and lyric:
        filename = os.path.splitext(mp3file)[0]
        print("filename: {}".format(filename))
        with open(filename, 'w+') as f:
            f.write(lyric.encode('utf8'))

def GetAllFiles(path,ext='mp3'):
    files = []
    # r=root, d=directories, f = files
    for r, d, f in os.walk(path):
        for file in f:
            if '.'+ext in file:
                files.append(os.path.join(r, file))
    return files

def GetSongInfo(filename):
    if not os.path.exists(filename):
        return False

    audio = EasyID3(filename)
    title = audio['title'][0]
    artist = audio['artist'][0]
    return [title, artist]


# --------------------- Main Program -----------------------

#full_list = GetAllFiles("/media/removable/sam128/XMusic")
full_list = GetAllFiles("/home/admin/git/temp/test")

for f in full_list:
    print("Process file: {}".format(f))
    title, artist = GetSongInfo(f)
    print(u"title {} artist {}".format(title, artist))
    lyric = GetLyric(title, artist)
    print(lyric)
    SaveToFile(f, lyric)
