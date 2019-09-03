#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import os

import argparse

from mutagen.easyid3 import EasyID3
from opencc import OpenCC
import gecimi


cc_s2t = OpenCC('s2t')
cc_t2s = OpenCC('t2s')

def StoT(simplified):
    if not isinstance(simplified, unicode):
        simplified = unicode(simplified, 'utf-8')
    traditional = cc_s2t.convert(simplified)
    return traditional

def TtoS(traditional):
    if not isinstance(traditional, unicode):
        traditional = unicode(traditional, 'utf-8')
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

def MissLyric(mp3file):
    if os.path.exists(os.path.splitext(mp3file)[0]):
        return False
    else:
        return True

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
if __name__ == '__main__':
    print('In the main')
    parser = argparse.ArgumentParser(description='Convert Simplied Chinese To Tradintional')
    parser.add_argument('-i', '--interactive', dest='interact', action="store_true", default=False,
            help='Get into interactive mode')
    parser.add_argument('-t', '--target', dest='target', action="store", default='/home/admin/git/temp/test',
            help='The target directory')

    args = parser.parse_args()
    print("{} {}".format(args.interact, args.target))

    #full_list = GetAllFiles("/media/removable/sam128/XMusic")
    #full_list = GetAllFiles("/home/admin/git/temp/test")
    if not os.path.exists(args.target):
        print("Can't find the directory {}".format(args.target))
        exit()

    full_list = GetAllFiles(args.target)

    for f in full_list:
        if MissLyric(f):
            print("Process file: {}".format(f))
            title, artist = GetSongInfo(f)
            print(title)
            print(artist)
            if args.interact:
                new_title = unicode(raw_input("Override title -->"), 'utf8')
                if new_title:
                    title = new_title
                new_artist = unicode(raw_input("Override artist -->"), 'utf8')
                if new_artist:
                    artist = new_artist

            #print(u"title {} artist {}".format(title, artist))
            print(title)
            print(artist)
            lyric = GetLyric(title, artist)
            print(lyric)
            SaveToFile(f, lyric)
