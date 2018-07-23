
on run argv
	set currentpath to get_pwd()
	set scenarioname to (item 1 of argv)
	-- set outfile to (currentpath & scenarioname & ".mov")
	set fc to read POSIX file (currentpath & scenarioname & ".txt") as «class utf8»
	set the text item delimiters to ("\n")
	set mylines to text items in fc
	
	-- tell application "QuickTime Player"
	-- 	activate
	-- 	close every document saving no
	-- 	set sr to new screen recording
	-- 	start sr

	-- end tell
	tell application "iTerm" to activate
	tell application "System Events" to key code 102
	set isbr to true
	set mode to 102
	repeat with currentline in mylines
		if currentline contains "%%KANA%%" then
		 	tell application "System Events" to key code 104
			 set mode to 104
		else if currentline contains "%%ALPHA%%" then
			tell application "System Events" to key code 36
			tell application "System Events" to key code 102
			set mode to 102
		else if currentline contains "%%NOBR%%" then
			set isbr to false
		else if currentline contains "%%WITHBR%%" then
			set isbr to true
		else 
			exec_script(currentline, isbr, mode)
		end if
		log(currentline)
	end repeat
	
	tell application "System Events" to keystroke "¥" using control down
	delay 1
	tell application "System Events" to key code 53 using {command down, control down}
	-- tell application "QuickTime Player" 
	-- 	activate
		
	-- 	with timeout of 10 seconds
	-- 		log "Before stop"
	-- 		stop sr
	-- 		-- tell application "System Events" to key code 53 using {command down, control down}
	-- 		log "After stop"
	-- 		log "Before close"
	-- 		close sr
	-- 		log "After close"
	-- 	end timeout
	-- end tell
end run

on get_pwd()
	
	tell application "Finder"
		set current to get (container of (path to me)) as text
		set x to POSIX path of current
	end tell
	return x
end get_pwd

on exec_script(the_string, isbr, mode)
	tell application "System Events"
		-- tell application "iTerm" to activate
		repeat with the_character in the_string
			
			-- log(the_character)
			if (the_character contains " ") = false then
				keystroke the_character
				delay 0.1
				key code mode
				delay 0.05
			else
				key code 49
			end if
		end repeat
		delay 1.0
		if isbr = true then
			keystroke return
			delay 1.0
		end if
	end tell
end exec_script

