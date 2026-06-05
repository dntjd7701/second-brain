on sanitize(valueText)
	if valueText is missing value then return ""
	set valueText to valueText as text
	set valueText to my replaceText(tab, " ", valueText)
	set valueText to my replaceText(linefeed, " ", valueText)
	set valueText to my replaceText(return, " ", valueText)
	return valueText
end sanitize

on replaceText(findText, replaceWith, sourceText)
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to findText
	set textItems to every text item of sourceText
	set AppleScript's text item delimiters to replaceWith
	set joinedText to textItems as text
	set AppleScript's text item delimiters to oldDelimiters
	return joinedText
end replaceText

on formatColor(colorValue)
	try
		set redValue to item 1 of colorValue
		set greenValue to item 2 of colorValue
		set blueValue to item 3 of colorValue
		return (redValue as text) & "," & (greenValue as text) & "," & (blueValue as text)
	on error
		return ""
	end try
end formatColor

set outputText to "name" & tab & "color_rgb" & linefeed

tell application "Calendar"
	repeat with calendarItem in calendars
		set calendarName to my sanitize(name of calendarItem)
		set calendarColor to my formatColor(color of calendarItem)
		set outputText to outputText & calendarName & tab & calendarColor & linefeed
	end repeat
end tell

return outputText
