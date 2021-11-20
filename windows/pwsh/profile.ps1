# the following is a sample profile that loads every time you start up an interactive powershell session

Import-Module DockerCompletion

# Trigger menu completion with tab key (override default tab complete)
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete

# Change up/down behavior so it doesn't scroll through all lines
# and instead matches on what you already typed in the current line
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward