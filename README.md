# 🎯 Productivity Focus Timer

   ![Status](https://img.shields.io/badge/status v2 script for time-blocking, deep work sessions, and productivity logging. Perfect for engineers, students, researchers, and professionals who need focused work sprints with intelligent overrun tracking and seamless note-taking.

## ✨ Features

### 🖥️ **Visual Timer Overlay**
- Always-on-top countdown timer in your screen corner
- Color-coded display: Red (normal) → Blue (elapsed mode) → Magenta (overrun)
- Shows `block time + overtime` format during overrun (e.g., `1200 + 45`)

### ⏰ **Smart Time Management**
- Flexible time blocks from minutes to hours
- Pause/resume functionality for interruptions
- Reset timer without losing session context
- Toggle between elapsed and remaining time views

### 🔔 **Intelligent Overrun Alerts**
- Customizable beep intervals when exceeding planned time
- Optional silent mode (set to 0)
- Gentle accountability without harsh interruptions

### 📝 **Comprehensive Logging System**
- Auto-creates `DailyLog.txt` in your Documents folder
- Logs session starts with timestamp, duration, and reason
- Real-time note-taking during sessions (Alt+T)
- Overrun-aware time tracking in logs
- Live integration with Notepad for instant visibility

### ⌨️ **Hotkey-Driven Workflow**
- No mouse clicks needed during focus sessions
- Universal timestamp insertion (Win+Alt+C)
- Quick note logging without breaking flow
- Emergency stop for urgent interruptions

## 🚀 Quick Start

### Prerequisites
- Windows 10/11
- [AutoHotkey v2.0](https://www.autohotkey.com/) installed

### Installation
1. **Download AutoHotkey v2** from [autohotkey.com](https://www.autohotkey.com/)
2. **Clone or download** this repository
3. **Double-click** `ProductivityTimer.ahk` to run
4. That's it! No configuration needed.

## 📖 Usage Guide

### Starting Your First Focus Block

1. **Press `Ctrl+Alt+B`** to start a new session


*Enter the number of minutes for your focus block*

 
*Optionally specify what you're working on (great for review later)*


*Set beep interval for overtime alerts (0 = silent)*

2. **Focus Timer Appears**


*The timer appears in your screen corner, always visible*

### During Your Session

| Action | Hotkey | Description |
|--------|--------|-------------|
| **Add Note** | `Alt+T` | Log progress, thoughts, or milestones |
| **Pause/Resume** | `Ctrl+Alt+P` | Handle interruptions gracefully |
| **Reset Timer** | `Ctrl+Alt+R` | Start block time over |
| **Toggle Display** | `Ctrl+Alt+N` | Switch between elapsed/remaining |
| **Emergency Stop** | `Esc` | Close timer immediately |
| **Insert Timestamp** | `Win+Alt+C` | Type timestamp anywhere |

### Understanding the Timer Display

- **Red Numbers**: Normal countdown (e.g., `1547` = 25 minutes 47 seconds remaining)
- **Blue Numbers**: Elapsed time mode (e.g., `213` = 3 minutes 13 seconds elapsed)  
- **Magenta "Block time" + Numbers**: Overrun mode (e.g., `1200 + 45` = planned 20 min + 45 sec overtime)

## 📊 Logging System

### Automatic Log Creation
The script creates `Documents\DailyLog.txt` automatically. All entries are appended, never overwritten.

### Log Entry Types

**Session Start:**
```
START 26082025-140000 | secs: 1200 | reason: Skim the Chemical Engineering Magazine
```

**Progress Notes (Alt+T):**
```
NOTE  26082025-140500 | expended: 300s | reason: Skim the Chemical Engineering Magazine | note: Finished abstract section
NOTE  26082025-142100 | expended: 1200 + 60s | reason: Skim the Chemical Engineering Magazine | note: Deep dive into methodology
```

### Smart Overrun Tracking
- **Normal time**: `expended: 300s` 
- **Overrun**: `expended: 1200 + 60s` (planned time + overtime)

## 🔧 Customization

### File Location
```ahk
global logFile := A_MyDocuments . "\DailyLog.txt"
```
Change to any path you prefer.

### Timer Position
```ahk
g.Show("x0 y0 NoActivate")  // Top-left corner
g.Show("x1820 y0 NoActivate")  // Top-right corner
```

### Beep Sound
```ahk
SoundBeep(1000, 300)  // Frequency: 1000Hz, Duration: 300ms
```

### Colors
```ahk
txt.Opt("cRed")      // Normal countdown
txt.Opt("cBlue")     // Elapsed mode  
txt.Opt("cFF00FF")   // Overrun (magenta)
```

## 💡 Pro Tips

### 🎯 **For Deep Work**
- Start with 25-50 minute blocks
- Use meaningful reasons ("Research Phase 1", "Code Review")
- Log key insights with Alt+T

### 📚 **For Studying** 
- Set subject-specific blocks ("Organic Chemistry Ch. 5")
- Use Alt+T to mark completed sections
- Review daily logs to track progress

### 👨‍💻 **For Programming**
- Time debugging sessions
- Log breakthrough moments
- Track time spent on different features

### 📝 **For Writing**
- Set word count goals with time blocks
- Log completed sections or milestones
- Use overrun data to improve time estimates

## 🔍 Troubleshooting

### Script Not Starting?
- Ensure AutoHotkey v2.0 is installed (not v1.1)
- Right-click script → "Run as Administrator" if needed

### Win+Alt+C Not Working?
- Check if other software is using this hotkey
- Try running script as administrator
- Ensure target application has text cursor visible

### Timer Not Visible?
- Check if overlay is behind other windows
- Adjust position in script (x0 y0 coordinates)
- Ensure script is running (check system tray for "H" icon)

### Notepad Integration Issues?
- Make sure Notepad is focused when pressing Alt+T
- Script detects `notepad.exe` - works with Windows Notepad
- For other editors, modify the `WinActive` check in Alt+T function

## 🤝 Contributing

We welcome contributions! Areas for enhancement:

- **Analytics Dashboard**: Parse logs for productivity insights
- **Project Tracking**: Organize blocks by project/category  
- **Calendar Integration**: Sync with Outlook/Google Calendar
- **Mobile Companion**: View logs on phone
- **Team Features**: Shared focus sessions

### Development Setup
1. Fork the repository
2. Make your changes in AutoHotkey v2 syntax
3. Test on Windows 10/11
4. Submit pull request with description

## 📄 License

MIT License - feel free to modify and distribute!

## 🙏 Credits

Created for focused productivity by engineers who understand the value of deep work. Inspired by Pomodoro Technique, timeboxing, and Getting Things Done methodologies.

***

**⭐ Star this repo if it helps your productivity!**

**🐛 Found a bug?** [Open an issue](https://github.com/entroky/productivity-timer/issues)

**💡 Have ideas?** [Start a discussion](https://github.com/entroky/productivity-timer/discussions)
