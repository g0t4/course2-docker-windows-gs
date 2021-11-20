# create a file $PROFILE
# ie use vscode:
code $PROFILE 


## remainder is example of powershell profile:
# put the remainder of this file into the $PROFILE file
# these are just things discussed in the course

# Add docker tab completion to PowerShell
# make sure to install package (module) first: (one time install)
# - Install-Package DockerCompletions
Import-Module DockerCompletion

# Trigger menu completion with tab key (override default tab complete)
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete

# Change up/down behavior so it doesn't scroll through all lines
# and instead matches on what you already typed in the current line 
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward