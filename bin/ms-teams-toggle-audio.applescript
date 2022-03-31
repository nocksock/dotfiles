#
# A small script to goggle MS Teams mute so I can map this to a global hotkey or
# onto stream deck 
#
set old to (path to frontmost application as text)
activate application "Microsoft Teams"

tell application "System Events"
	set teamsAppProcess to first application process whose frontmost is true
end tell

tell teamsAppProcess
	# since there's no way to tell what the meeting window is, cycle through each
	# of them and send cmd+shift+m and show the next via cmd+`
	repeat with theWindow in (every window)
		tell application "System Events" to keystroke "M" using {command down, shift down}
		tell application "System Events" to keystroke "`" using {command down}
	end repeat
end tell

activate application old
