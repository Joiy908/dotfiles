#NoEnv
#MaxHotkeysPerInterval 999
SendMode Input
SetWorkingDir %A_ScriptDir%
SetCapsLockState, AlwaysOff
CoordMode, ToolTip, Screen

;==== 锁定CapsLock, ctrl + CapsLock 开启
*Capslock::SetCapsLockState, AlwaysOff
^Capslock::SetCapsLockState, On


;===== vim 反向键映射
!k::
  Send {Up}
return

!j::Send {Down}


!h::Send {Left}
!l::Send {Right}

; === vim
!o:: Send {End}`n ; open a line
!i:: Send {Home} ; I in vim
!a:: Send {End} ; A in vim

!d:: Send {Home}+{End}{Del} ; del curr line
;=== copy and past
!y:: Send, ^c
!p:: Send, ^+v

;==== CapsLock 层
; 删除到行尾
CapsLock & ]:: Send, +{End}{Del}
; 删除到行首
CapsLock & [:: Send, +{Home}{Del}
; CapsLock+kjhl 选中
CapsLock & k::Send {ShiftDown}{Up}{shiftup}
CapsLock & j::Send {ShiftDown}{Down}{shiftup}
CapsLock & h::Send {ShiftDown}{Left}{shiftup}
CapsLock & l::Send {ShiftDown}{Right}{shiftup}


;=== close window
!x:: Send ^w ; alt + x => ctrl + w
+!x:: Send !{f4} ; shift + alt +x => alt + f4

;=== click 页面
!m:: Send,{Click 500,500}

;=== 打开应用篇
!c:: Run, D:\Program Files (x86)\Clash for Windows\Clash for Windows.exe
!q:: Run, D:\Program Files (x86)\Q-Dir\Q-Dir_x64.exe


;=== hot word
; ::mgn::margin-left:0 ;输入mgn+终止符(space/.)触发
:*:mgn::margin-left:0 ; 输入后直接触发
:*:<sup::<sup>2</sup>
:*:<sub::<sub>2</sub>

:*:]d::  ; 此热字串通过后面的命令把 "]d" 替换成当前日期和时间.
  FormatTime, CurrentDateTime,, yyyy-MM-dd
  SendInput %CurrentDateTime%
return

:*:]qm::2922667152@qq.com
:*:]gm::joiy9088@gmail.com
:*:]163m::xiahongchao09@163.com
:*:]p::13315983848


;==== 浏览器-搜索相关
!g::
    InputBox, content, Search, 使用谷歌搜索, , ,135
    if ErrorLevel ;如果点击取消按钮
        return
    else
        run https://www.google.com/search?q=%content%
return

!b::
    InputBox, content, search, 使用bing搜索, , ,135
    if ErrorLevel ;如果点击取消按钮
        return
    else
        run https://cn.bing.com/search?q=%content%
return

;!p:: ;复制选中的文字, google
;    send ^c
;    sleep,200
;    run https://www.google.com/search?q=%clipboard%
;return

#b:: ; win + b进入选中链接
    send ^c
    sleep,200
    run %clipboard%
return

!t:: ;translate
    send ^c
    sleep,200
    run https://translate.google.cn/?sl=auto&tl=zh-CN&text=%clipboard%&op=translate
return


;===== 滚轮调整声音
~lbutton & enter::
exitapp
~WheelUp::
if (existclass("ahk_class Shell_TrayWnd")=1)
Send,{Volume_Up}
Return
~WheelDown::
if (existclass("ahk_class Shell_TrayWnd")=1)
Send,{Volume_Down}
Return
~MButton::
if (existclass("ahk_class Shell_TrayWnd")=1)
Send,{Volume_Mute}
Return
Existclass(class)
{
MouseGetPos,,,win
WinGet,winid,id,%class%
if win = %winid%
Return,1
Else
Return,0
}


#c:: ; get 当前选中文件的路径
    send ^c
    sleep,200
    clipboard=%clipboard% ;windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来
了
    tooltip,%clipboard% ;提示文本
    sleep,300
    tooltip,
return
