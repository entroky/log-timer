# 🎯 Log Timer
A lightning-fast utility for **time-blocking, deep work, and productivity logging**. Ideal for engineers, researchers, writers, students, and anyone who wants ultra-efficient focus sessions, smart overtime alerts, and seamless note capture—all with the speed of a keystroke.

***

## ✨ Features

### 🖥️ **Minimal, Always-On-Top Timer Overlay**
- Always visible, sits in a screen corner
- Color-coded:  
  - **Red:** Countdown (normal mode)
  - **Blue:** Elapsed (count up)
  - **Magenta:** Overtime/Overrun
- Instantly togglable via hotkey for elapsed/remaining

### ⏰ **Flexible, Smart Time Management**
- Set any time block—minutes or hours
- Pause/resume instantly for interruptions (Ctrl + Space)
- Reset timer to original value anytime (Ctrl + Shift + Space)
- Toggle view: see time left (Ctrl+↑) or time elapsed (Ctrl+↓)

### 🔔 **Gentle Overtime Alerts**
- Auto beep at chosen overrun intervals—subtle accountability
- Customize beep timing or silence it entirely

### 📝 **Intelligent Logging System**
- Creates `DailyLog.txt` in your **Documents** folder—no setup required
- Logs every session start, end, and optional notes with timestamps
- Real-time note logging (Ctrl + ,) during focus (with instant Notepad paste if focused)
- All actions append to your log for permanent tracking

### ⌨️ **Blazing Fast, One-Handed Hotkeys**
- All commands are ergonomic, fast, and rarely conflict with typing/editor/terminal use
- No function-keys required—everything is under your left hand or on punctuation

***

## 🚀 Quick Start

### Prerequisites
- Windows 10/11
- [AutoHotkey v2.0](https://www.autohotkey.com/) installed

### Installation
1. Download & install AutoHotkey v2 (see above)
2. Copy this script to a `.ahk` file (e.g., `LogTimer.ahk`)
3. Double-click to run—no configuration needed

***

## 📖 Usage Guide

### Starting Your Focus Block
Press **Ctrl + Left Arrow**  
- Enter block duration (in minutes)
- Optionally specify your session reason (for future review)
- Optionally pick a beep interval for overrun (in seconds, 0 = silent)

### During Your Session

| Action                    | Hotkey                  | Description                                |
|---------------------------|-------------------------|--------------------------------------------|
| **Start block**           | Ctrl + Left Arrow       | Begin a new focus session                  |
| **End block**             | Ctrl + Right Arrow      | Stop session, log END, and close overlay   |
| **Pause/Resume**          | Ctrl + Space            | Instantly pause or resume timer            |
| **Reset session**         | Ctrl + Shift + Space    | Restart block at original time             |
| **Countdown view**        | Ctrl + Up Arrow         | Display remaining time (default)           |
| **Elapsed view**          | Ctrl + Down Arrow       | Display time elapsed (count up mode)       |
| **Log a note**            | Ctrl + , (comma)        | Add a note to your log anytime             |
| **Open log file**         | Ctrl + . (period)       | Instantly view your log in Notepad         |
| **Insert day header**     | Ctrl + / (slash)        | Paste `DAY : <timestamp>` wherever you are |

***

### **Display Legend**
- **Red numeric display:** Time left (countdown)
- **Blue numeric display:** Elapsed (count up)
- **Magenta display:** Overtime, with `block duration + overtime seconds` (e.g., `1200 + 45`)
- Timer window floats in your chosen corner; moveable via script coordinates

***

### **What’s in Your Log?**
```
26082025-140000 | 1200s | Skim the Chemical Engineering Magazine | STARTED
...
26082025-140500 | 300s | Skim the Chemical Engineering Magazine | Finished abstract section
...
26082025-142100 | 1200+60s | Skim the Chemical Engineering Magazine | Deep dive into methodology
...
26082025-143000 | 1800+0s | Skim the Chemical Engineering Magazine | END
```
- Each entry: `timestamp | seconds | reason | note/marker`
- **Overruns**: `1200+60s` = planned 20min + 1min overtime

***

## 🔧 Customization

### Change log file location
```ahk
global logFile := A_MyDocuments "\\DailyLog.txt"
```
Set to any desired path.

### Overlay position  
Change in script:
```ahk
g.Show("x0 y0 NoActivate")    ; Top-left (default)
g.Show("x1820 y0 NoActivate") ; Top-right (edit values for your screen)
```

### Beep
Edit line:
```ahk
SoundBeep(1000, 300)          ; Hertz (pitch), Duration ms
```

***

## 💡 Tips for Power Users

- Use highly descriptive "reasons" for blocks to make logs useful (e.g., `"Design review"`, `"Chapter 4 exercises"`)
- Use notes frequently to mark micro-accomplishments
- Review your `DailyLog.txt` at the end of day/week for patterns, bottlenecks, and review

***

## 🔍 Troubleshooting

- **Script not starting?**  
  Make sure AutoHotkey v2 is installed, not v1. Double-check you’re running the `.ahk` file.

- **Hotkeys not working?**  
  Ensure no other app has claimed the shortcut; try running script as administrator for system-wide binding.

- **Notepad integration?**  
  Log lines paste to Notepad only if it’s focused; change window name in the script for other editors.

***

## 🤝 Contributing
Ideas and pull requests are welcome—for project features, analytics, analytics exports, project tagging, and deeper automation.

***

## 📄 License
MIT License

***

## 🙏 Credits
Designed for maximum focus and minimum friction by people who deeply value productive work.  
Inspired by current best practices in time-blocking, Pomodoro, and deep work culture.

***

**⭐ Star this script if it helps you!**  
**🐛 Issues?** [Open an issue](https://github.com/yourrepo/log-timer/issues)  
**💡 Suggestions?** [Start a discussion](https://github.com/yourrepo/log-timer/discussions)  

***

Let me know if you need the markdown version with github/flavored styling or any tweaks for your documentation/site!
