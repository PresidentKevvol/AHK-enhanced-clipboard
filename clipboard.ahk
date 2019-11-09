; this is the AHK script for providing an enhanced clipboard system
; to make macros for programmable gaming mouse
; by PresidentKevvol, Nov. 2019

; the secondary clipboard
secondaryClip := ""

; the cache for clipboard
clipCache := ""

; concatenation function
Concatenate2(x, y) {
	Return, x y
}

; secondary copy (ctrl + n)
^n::
clipCache := ClipboardAll 	; cache the current clipboard value
clipboard := "" 		; clear current clipboard(needed for ClipWait)
Send, ^c			; call copy command
ClipWait 			; wait for clipboard to fill
secondaryClip := clipboard 	; store copied temporary clipboard to secondary clipboard
clipboard := clipCache 		; restore clipboard to cached 1st clipboard
clipCache := "" 		; clear clipCache
return

; secondary paste (ctrl + m)
^m::
clipCache := ClipboardAll 	; cache the current clipboard
clipboard := secondaryClip 	; put secondary clipboard to default clipboard
Send, ^v			; call paste command
clipboard := clipCache 		; repaste cached default clipboard
clipCache := "" 		; clear clipCache
return

; copy-concat (ctrl + l)
^l::
clipCache := clipboard				; cache clipboard first
send ^c						; invoke copy command
ClipWait
clipboard := Concatenate2(clipCache, clipboard)	; concatenate new copy to original clipboard and put it back to clipboard
clipCache := ""					; clear clipCache
return

; secondary copy-concat (ctrl + k)
^k::
clipCache := clipboard					; cache clipboard first
send ^c							; invoke copy command
ClipWait
secondaryClip := Concatenate2(secondaryClip, clipboard)	; concatenate copied selected text to secondary clip
clipboard := clipCache					; put the cached clipboard back
return
