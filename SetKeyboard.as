set theMenuName to "text input menu extra"

tell application "System Events"
	tell application process "SystemUIServer"
		set menuBar to menu bar 1
		set menuBarItemsList to value of attribute "AXDescription" of menu bar items of menuBar
		set theMenuNum to my positionOfAinListB(theMenuName, value of attribute "AXDescription" of menuBar's menu bar items)
		set theMenu to menuBar's menu bar item 3
		tell theMenu
			if not selected then click
			set namesOfMenuItems to name of menu items of menu 1
			tell (first menu item of menu 1 whose name is "@LAYOUT@") to click
		end tell
	end tell
end tell

to positionOfAinListB(itemA, listB)
	if (itemA is in listB) then
		repeat with i from (count listB) to 1 by -1
			if itemA = listB's item i then return i
		end repeat
	else
		return -1
	end if
end positionOfAinListB