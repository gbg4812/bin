# Personal Scripts
## Contents
- **src/sd.sh** 🌩️ : is the flag ship of my scripts (inspired by the Primagen script tmux-sessionizer). It exposes two main functions/commands `sd` and `st` that open a fzf interactive search
to select and go to a directory quickly. The `st` version creates a new tmux session with the selected directory as root directory.
  - There are three complementary functions/commands:
      - `sd-add` to add new locations to de search
      - `sd-remove` to remove from the search list
      - `sd-list` to list the targeted locations
      - `sd-edit` to open the list of locations with an editor
  - The search locations list is stored in the `$HOME` directory as a file named `.sd-locations`
  - When a location is listed the sd function will search inside the directory with a depth of 1 level to find other directories where to go.
    Example:
    ```
    --- Directory Structure ---
    ~/Documents/
        |- School/
        |- Poems/
        |- hello_world.txt
        ...

    --- Terminal ---
    > sd

    ...
    ~/Documents/School/
    ~/Documents/Poems/
    --------------------------------------
    DocPoe|
    --------------------------------------
    ```
- **tmux-cht.sh** 📑 : A bash script from the Primagen Youtuber to acces the cht.sh from the terminal with the help of
tmux and fzf
- **mkwebapp.py** 🕸️ : a python script to automaticaly generate .desktop files that open firefox with a particular link. It generate icons too!!!
