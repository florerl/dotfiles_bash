#!/bin/sh

# Show the ~/Library folder.
chflags nohidden ~/Library



dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Mail.app"
dockutil --no-restart --add "/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Contacts.app"
dockutil --no-restart --add "/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/Reminders.app"
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Safari Technology Preview.app"
dockutil --no-restart --add "/Applications/Oni.app"
dockutil --no-restart --add "/Applications/Xcode.app"
dockutil --no-restart --add "/Applications/Utilities/Terminal.app"
dockutil --no-restart --add "/Applications/Microsoft Word.app"
dockutil --no-restart --add "/Applications/Microsoft Excel.app"
dockutil --no-restart --add "/Applications/Microsoft PowerPoint.app"
dockutil --no-restart --add "/Applications/Visual Paradigm.app"
dockutil --no-restart --add "/Applications/Maps.app"
dockutil --no-restart --add "/Applications/News.app"
dockutil --no-restart --add "/Applications/iTunes.app"

killall Dock
