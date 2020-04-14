New-Item -ItemType HardLink -Path "$env:USERPROFILE\_vimrc" -Target ".\vimrc"
New-Item -ItemType HardLink -Path "$PROFILE" -Target ".\profile.ps1"

