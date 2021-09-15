#  SPDX-License-Identifier: Apache-2.0
#
#  Copyright (c) 2020 onox <denkpadje@gmail.com>
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

import argparse
import json
import pathlib

flags = ["cn", "de", "es", "fr", "gb", "it" , "jp", "kr", "ru", "us", "sa"]


def print_pair(name, points, prefix = " ", suffix = ","):
    points_str = ", ".join(f"16#{p}#" for p in points)
    print(f"     {prefix}(+\"{name}\", {points_str}){suffix}")

parser = argparse.ArgumentParser(description="""
Print Ada code containing Unicode Emoji codepoints using emoji.json.
Download from https://github.com/iamcal/emoji-data/raw/master/emoji.json
""")
parser.add_argument("file", type=pathlib.Path, help="Path to emoji.json")

args = parser.parse_args()


# https://github.com/iamcal/emoji-data/raw/master/emoji.json
with open(args.file) as f:
    name_points = [(d["short_name"], d["unified"].split("-")) for d in json.load(f)]

    points_1 = [np for np in name_points if len(np[1]) == 1]
    points_2 = [np for np in name_points if len(np[1]) == 2]
    points_3 = [np for np in name_points if len(np[1]) == 3]

    print("   Name_Emojis_3 : constant array (Positive range <>) of Text_3_Points_Pair :=")
    print_pair(*points_3[0], prefix="(") 
    for name, points in points_3[1:-1]:
        print_pair(name, points)
    print_pair(*points_3[-1], suffix=");") 

    print()

    print("   Name_Emojis_2 : constant array (Positive range <>) of Text_2_Points_Pair :=")
    print_pair(*points_2[0], prefix="(") 
    for name, points in points_2[1:-1]:
        print_pair(f"flag-{name}" if name in flags else name, points)
    print_pair(*points_2[-1], suffix=");") 

    print()

    print("   Name_Emojis_1 : constant array (Positive range <>) of Text_1_Points_Pair :=")
    print_pair(*points_1[0], prefix="(") 
    for name, points in points_1[1:-1]:
        print_pair(name, points) 
    print_pair(*points_1[-1], suffix=");") 
