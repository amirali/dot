import os
os.system("mv .vim/ .vimrc .pyvimrc .xonsh ~/")
os.system("sudo pip3 install -r requirments.txt")
if not os.path.exists("~/bin/"):
    os.makedirs("~/bin/")
os.system("mv bin/* ~/bin/")
print("--------------------\nInstallation complete!")