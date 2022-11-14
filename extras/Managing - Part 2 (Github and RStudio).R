### Managing - Part 2 (Github and RStudio)
## by Garrett Grolemund
# https://www.rstudio.com/resources/webinars/managing-part-2-github-and-rstudio/

## ADDING VERSION CONTROL
# remember to create a git repository when creating a new project.
# For exisiting project
# 1. Tools
# 2. Project Options
# 3. Git/SVN
# 4. Version control system: Git

# To create Commit
# 1. press commit
# 2. Choose the folder you want to view. 
#    New ones are green, deleted red, grey font is old, bolded black is new.
# 3. Staged the ones you want to add to GitHub
# 4. Write a commit message, what you did."DATE. Adding/changing)
#    You dont need to add everything to your final version to GitHub
#    Press staged and then Ignore - those are files that Git should ignore 
#    - M = modified file
# 5. Press Commit = this saves so you can see what you have done.
# 6. Press Push = this sends everything to GitHub online.

# Check the history > Git > History
# Check changes > Git > Diff


######################################################################
# To link your RStudio with GitHub.com
# Collab can save, work and share the same data

# 1 Real life version - working directory
# 2 "Official version - commit history
# 3 GitHub public version to share with collabs - pull GitHub version to your
#   PUSH
#   PULL

# To do so:
# 1. Create repository to GitHub.com
# 2. Synch up project to GitHub
#    Some wierd stuff.

# COMMITS ALONE DONT SAVE TO GITHUB.com
# To send to GitHub.com you press "PUSH"

# ReadMWe file has all changes in GitHub. You can see them pressing PULL.

#####################################################################
# You can bring some old version by searching their code (SHA)
# 1. Git > History > e.g., a0ce951d0f22b1c7fb71c045b6b7bc36c713c6b1
# 2. Tools > Shell
# 3. add $git checkout "SHA-number" storms.png, so it changes it back

# Terminal window is hard. You can use packages, like SourceTree and GitUp to
# help navigate through it.
# - sourcetreeapp.com
# - gitup.co

# Also check out: rstudio.com/resources/cheatsheets/












