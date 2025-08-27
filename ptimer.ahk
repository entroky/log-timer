#Requires AutoHotkey v2.0
#SingleInstance Force

global running := false, paused := false
global g := 0, txt := 0, lbl := 0
global total := 0, remaining := 0
global reason := ""
global sessionStartTime := ""
global logFile := A_MyDocuments "\\DailyLog.txt"
global overrunBeepInterval := 0, overrunSince := 0
global showElapsed := false

logEntry(mark:="", extraNote:="") {
    global total, remaining, reason, logFile
    expended := total - remaining
    if (expended > total) {
        overrun := expended - total
        exp_str := total "+" overrun "s"
    } else {
        exp_str := expended "s"
    }
    output := logStamp() " | " exp_str " | " Trim(reason)
    if mark != ""
        output .= " | " mark
    if extraNote != ""
        output .= " | " extraNote
    output .= "`r`n"
    FileAppend output, logFile
    if WinActive("ahk_exe notepad.exe")
        SendInput("{Text}" . output)
}

^Left:: { ; Ctrl+Left: Start Block
    global running, paused, g, txt, lbl, total, remaining, reason, sessionStartTime, overrunBeepInterval, overrunSince
    if running {
        SetTimer Tick, 0
        if g
            g.Destroy()
        running := false
        paused := false
        return
    }
    ib := InputBox("Enter minutes to block:", "Time Setup")
    if ib.Result != "OK"
        return
    mins := ib.Value
    if !IsNumber(mins) || (mins := mins + 0) <= 0
        return
    rb := InputBox("Why are you blocking? (optional)", "Log Reason")
    if rb.Result != "OK"
        return
    reason := rb.Value
    beepBox := InputBox("Seconds between overtime beeps (0 = no beep):", "Overrun Beep")
    if beepBox.Result != "OK"
        return
    beepInterval := beepBox.Value
    if !IsNumber(beepInterval) || (beepInterval := beepInterval + 0) < 0
        beepInterval := 0
    overrunBeepInterval := beepInterval
    overrunSince := 0
    sessionStartTime := A_Now
    total := Floor(mins * 60)
    remaining := total
    running := true
    paused := false
    msg := logStamp(sessionStartTime) " | 0s | " Trim(reason) " | STARTED`r`n"
    FileAppend msg, logFile
    if WinActive("ahk_exe notepad.exe")
        SendInput("{Text}" . msg)
    g := Gui("+AlwaysOnTop +ToolWindow")
    g.BackColor := "FE0000"
    g.SetFont("s14 bold", "Segoe UI")
    lbl := g.Add("Text", "x5 y2 w140 h20 BackgroundTrans cFF00FF +Center", "")
    g.SetFont("s18 bold", "Segoe UI")
    txt := g.Add("Text", "x5 y26 w140 h38 BackgroundTrans cRed +Right", "0000")
    WinSetTransColor("FE0000", g.Hwnd)
    g.Opt("-Caption")
    g.Show("x0 y0 NoActivate")
    lbl.Visible := false
    SetTimer Tick, 1000
    UpdateDisplay()
}

^Right:: { ; Ctrl+Right: End Block and log END
    global running, paused, g
    if !running
        return
    logEntry("END")
    SetTimer Tick, 0
    if g
        g.Destroy()
    running := false
    paused := false
}

^Space:: { ; Ctrl+Space: Pause/Resume
    global paused, running
    if !running
        return
    paused := !paused
    UpdateDisplay()
}

^+Space:: { ; Ctrl+Shift+Space: Reset timer to original value even if overran
    global running, total, remaining, overrunSince
    if !running
        return
    remaining := total
    overrunSince := 0
    UpdateDisplay()
}

^Up:: { ; Ctrl+Up: Normal countdown mode
    global showElapsed
    showElapsed := false
    UpdateDisplay()
}

^Down:: { ; Ctrl+Down: Count up (elapsed) mode
    global showElapsed
    showElapsed := true
    UpdateDisplay()
}

^,:: { ; Ctrl + , : Log a note
    global running
    if !running
        return
    msgBox := InputBox("What would you like to log?", "Log Note")
    if msgBox.Result != "OK"
        return
    extraNote := msgBox.Value
    logEntry("", extraNote)
}

^.:: Run(logFile) ; Ctrl + . : Open log file

^/:: SendInput("DAY : " logStamp() . "`r`n") ; Ctrl + / : Insert day header

Tick() {
    global running, paused, remaining, total, overrunBeepInterval, overrunSince, showElapsed
    if !running
        return
    if !paused
        remaining -= 1
    if (total - remaining > total) && overrunBeepInterval > 0 {
        overrunSince += 1
        if Mod(overrunSince, overrunBeepInterval) = 0
            SoundBeep(1000, 300)
    } else {
        overrunSince := 0
    }
    UpdateDisplay()
}

UpdateDisplay() {
    global txt, lbl, total, remaining, showElapsed
    elapsed := total - remaining
    isOver := ((showElapsed && elapsed > total) || (!showElapsed && remaining < 0))
    if isOver {
        overtime := (showElapsed ? elapsed : total - remaining) - total
        txt.Opt("cFF00FF")
        txt.Value := total " +" overtime
    } else {
        lbl.Visible := false
        txt.Opt(showElapsed ? "cBlue" : "cRed")
        txt.Value := showElapsed ? elapsed : remaining
    }
}

logStamp(ts:="") {
    ts := ts="" ? A_Now : ts
    return SubStr(ts,7,2) . SubStr(ts,5,2) . SubStr(ts,1,4) . "-" . SubStr(ts,9,2) . SubStr(ts,11,2) . SubStr(ts,13,2)
}
