#Requires AutoHotkey v2.0.2
#SingleInstance Force

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

DisableLockWorkstation() {
    RegWrite(1, "REG_DWORD", "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System", "DisableLockWorkstation")
}

EnableLockWorkstation() {
    RegWrite(0, "REG_DWORD", "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System", "DisableLockWorkstation")
}

WinLAction() {
    Komorebic("focus right")
}

WinShiftAltLAction() {
    EnableLockWorkstation()
    Sleep(500)
    DllCall("LockWorkStation")
    Sleep(500)
    DisableLockWorkstation()
}

OnExitCallback(ExitReason, ExitCode) {
    EnableLockWorkstation()
}

DisableLockWorkstation()

; # = Win, + = Shift, ! = Alt, ^ = Ctrl

#+!l::WinShiftAltLAction()

#a::Reload
#+a::Komorebic("reload-configuration")
#d::Send("!d")
#Enter::Run("wezterm-gui")

#+q::Komorebic("close")
#m::Komorebic("minimize")

; Focus windows
#h::Komorebic("focus left")
#j::Komorebic("focus down")
#k::Komorebic("focus up")
#l::WinLAction()

#+[::Komorebic("cycle-focus previous")
#+]::Komorebic("cycle-focus next")

; Move windows
#+h::Komorebic("move left")
#+j::Komorebic("move down")
#+k::Komorebic("move up")
#+l::Komorebic("move right")

; Stack windows
#Left::Komorebic("stack left")
#Down::Komorebic("stack down")
#Up::Komorebic("stack up")
#Right::Komorebic("stack right")
#;::Komorebic("unstack")
#[::Komorebic("cycle-stack previous")
#]::Komorebic("cycle-stack next")

; Resize
#p::Komorebic("resize-axis horizontal increase")
#u::Komorebic("resize-axis horizontal decrease")
#i::Komorebic("resize-axis vertical increase")
#o::Komorebic("resize-axis vertical decrease")

; Manipulate windows
#+Space::Komorebic("toggle-float")
#+f::Komorebic("toggle-monocle")

; Window manager options
#+y::Komorebic("retile")

; Layouts
#x::Komorebic("flip-layout horizontal")
#y::Komorebic("flip-layout vertical")
#v::Komorebic("cycle-layout next")
#+v::Komorebic("cycle-layout previous")

; Workspaces
#0::Komorebic("focus-named-workspace 0")
#1::Komorebic("focus-named-workspace 1")
#2::Komorebic("focus-named-workspace 2")
#3::Komorebic("focus-named-workspace 3")
#4::Komorebic("focus-named-workspace 4")
#5::Komorebic("focus-named-workspace 5")
#6::Komorebic("focus-named-workspace 6")
#7::Komorebic("focus-named-workspace 7")
#8::Komorebic("focus-named-workspace 8")
#9::Komorebic("focus-named-workspace 9")

; Move windows across workspaces
#+0::Komorebic("move-to-named-workspace 0")
#+1::Komorebic("move-to-named-workspace 1")
#+2::Komorebic("move-to-named-workspace 2")
#+3::Komorebic("move-to-named-workspace 3")
#+4::Komorebic("move-to-named-workspace 4")
#+5::Komorebic("move-to-named-workspace 5")
#+6::Komorebic("move-to-named-workspace 6")
#+7::Komorebic("move-to-named-workspace 7")
#+8::Komorebic("move-to-named-workspace 8")
#+9::Komorebic("move-to-named-workspace 9")
