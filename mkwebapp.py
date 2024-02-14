#!/usr/bin/python3
import os
import re
import requests

ROOT = "https://api.iconify.design"
HOME = str(os.getenv("HOME"))
ICON_DIR = HOME + "/.local/icons"

def check_input(regex, input_message):
    result = input(input_message)
    while(re.search(regex, result)):
        result = input(input_message)
    return result

# response = requests.get( "https://api.iconify.design/search?query=gmail&prefix=logos&limit=1")

def generate_icon(name):
    response = requests.Response()
    while(True):
        response = requests.get(f"{ROOT}/search?query={name}&prefix=logos&limit=1").json()

        if response["total"] == 0:
            print("search failed! cancel (Ctrl-C) or try another word: ")
            name = input()
        else:
            break

    for i, icon in enumerate(response["icons"]):
        print(f"{i}. {icon}")

    idx = int(input("chose icon: "))

    icon = str(response["icons"][idx])

    prefix, name = icon.split(":")
    svg_code = requests.get(f"{ROOT}/{prefix}/{name}.svg").content.decode()

    if not os.path.isdir(ICON_DIR):
        os.makedirs(ICON_DIR)

    with open(f"{ICON_DIR}/{name}.svg", "w") as f:
        f.write(svg_code)
        f.close()

    return f"{ICON_DIR}/{name}.svg"


name = check_input(" ", "Application Name (in lowercase): ")
version = check_input("[^0-9.]", "Application Version: ")
description = input("Set an optional description: ")
command = input("Which command do you want to run: ")
icon = generate_icon(name)



template = f"""
[Desktop Entry]
Version={version}
Type=Application
Name={name.capitalize()}
Comment={description}
Exec={command}
Icon={icon}
"""

with open(f"{HOME}/Desktop/{name}.desktop", "w") as f:
    f.write(template)
    f.close

