; �������������������������������������������������������������������������
; General Asm Template by Lahar 
; �������������������������������������������������������������������������

.686					;Use 686 instuction set to have all inel commands
.model flat, stdcall	;Use flat memory model since we are in 32bit 
option casemap: none	;Variables and others are case sensitive

include Template.inc	;Include our files containing libraries

; �������������������������������������������������������������������������
; Our initialised variables will go into in this .data section
; �������������������������������������������������������������������������
.data
	szAppName	db	"Application Name",0

; �������������������������������������������������������������������������
; Our uninitialised variables will go into in this .data? section
; �������������������������������������������������������������������������
.data?
	hInstance	HINSTANCE	?

; �������������������������������������������������������������������������
; Our constant values will go onto this section
; �������������������������������������������������������������������������
.const
	IDD_DLGBOX	equ	1001
	IDC_EXIT	equ	1002
	APP_ICON	equ	2000

; �������������������������������������������������������������������������
; This is the section to write our main code
; �������������������������������������������������������������������������
.code

start:	
	invoke GetModuleHandle, NULL
	mov hInstance, eax
	invoke InitCommonControls
	invoke DialogBoxParam, hInstance, IDD_DLGBOX, NULL, addr DlgProc, NULL
	invoke ExitProcess, NULL

DlgProc		proc	hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	.if uMsg == WM_INITDIALOG
		invoke SetWindowText, hWnd, addr szAppName
		invoke LoadIcon, hInstance, APP_ICON
		invoke SendMessage, hWnd, WM_SETICON, 1, eax
	.elseif uMsg == WM_COMMAND
		mov eax, wParam
		.if eax == IDC_EXIT
			;invoke SendMessage, hWnd, WM_CLOSE, 0, 0
			invoke mouse_event,MOUSEEVENTF_MOVE,20,30,0,0
		.endif
	.elseif uMsg == WM_CLOSE
		invoke EndDialog, hWnd, NULL
	.endif
	
	xor eax, eax				 
	Ret
DlgProc EndP

end start	
	 