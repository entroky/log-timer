#Requires AutoHotkey v2.0
#SingleInstance Force

global running := false, paused := false
global g := 0, txt := 0, lbl := 0
global total := 0, remaining := 0
global showElapsed := false
global reason := ""
global sessionStartTime := ""
global logFile := "C:\\Users\\moham\\Desktop\\Biopharmaceuticals\\DailyLog.txt"
global overrunBeepInterval := 0, overrunSince := 0

#!c:: { ; Win+Alt+C: send timestamp wherever cursor is
    SendInput(logStamp() . "`r`n")
}

^!b:: { ; Start/Stop
    global running, paused, g, txt, lbl, total, remaining, showElapsed, reason, sessionStartTime, logFile, overrunBeepInterval, overrunSince
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
    showElapsed := false
    running := true
    paused := false

    ; Log session start
    logmsg := "START " logStamp(sessionStartTime) " | secs: " total " | reason: " reason "`r`n"
    FileAppend logmsg, logFile

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

^!p:: { ; Pause/Resume
    global paused, running
    if !running
        return
    paused := !paused
    UpdateDisplay()
}

^!n:: { ; Toggle elapsed/remaining
    global showElapsed
    showElapsed := !showElapsed
    UpdateDisplay()
}

^!r:: { ; RESET to start value, even in overrun
    global running, total, remaining, overrunSince
    if !running
        return
    remaining := total
    overrunSince := 0
    UpdateDisplay()
}

Esc:: { ; Emergency stop/close (no log)
    global running, paused, g
    if !running
        return
    SetTimer Tick, 0
    if g
        g.Destroy()
    running := false
    paused := false
}

!t:: { ; Alt+T - PROMPT, log, and paste to Notepad if focused, track overrun in log
    global running, total, remaining, reason, logFile
    if !running
        return
    expended := total - remaining
    msgBox := InputBox("What would you like to log?", "Log Note")
    if msgBox.Result != "OK"
        return
    extraNote := msgBox.Value
    ; Overrun-aware expended formatting
    if (expended > total) {
        overrun := expended - total
        exp_str := total " + " overrun "s"
    } else {
        exp_str := expended "s"
    }
    logmsg := "NOTE  " logStamp() " | expended: " exp_str " | reason: " reason " | note: " extraNote "`r`n"
    FileAppend logmsg, logFile

    ; Only paste to Notepad if it is active
    if WinActive("ahk_exe notepad.exe") {
        SendInput("{Text}" . logmsg)
    }
}

Tick() {
    global running, paused, remaining, total, overrunBeepInterval, overrunSince, showElapsed
    if !running
        return
    if !paused
        remaining -= 1

    elapsed := total - remaining
    isOver := ((showElapsed && elapsed > total) || (!showElapsed && remaining < 0))
    if isOver && overrunBeepInterval > 0 {
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
