#!/bin/sh

osascript -e '
runWithProfile("ssh kws@ruby.teampenta.com", "Penta")

on runSimple(command)
  tell application "Terminal"
    activate
    set newTab to do script(command)
  end tell
  return newTab
end runSimple

on runWithProfile(command, profile)
  set newTab to runSimple(command)
  tell application "Terminal" to set current settings of newTab to (first settings set whose name is profile)
end runWithProfile
' > /dev/null
