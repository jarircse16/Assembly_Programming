includelib "e:\masm32\lib\irvine32.lib"
include "irvine32.inc"
BUFMAX = 128
.data
CaseTable  BYTE   'A'
           DWORD   Process_A
           BYTE   'B'
           DWORD   Process_B
           BYTE   'C'
           DWORD   Process_C
           BYTE   'D'
           DWORD   Process_D
           BYTE   'E'
           DWORD   Process_E
    NumberOfEntries = 5
        Nameprompt BYTE "Please enter your name: ", 0
        prompt BYTE "Choose a letter by pressing the corresponding capital letter: ", 0dh, 0ah
           BYTE "A: Add two binary numbers", 0dh, 0ah
           BYTE "B: Subtract two binary numbers", 0dh, 0ah
           BYTE "C: Writing from decimal number to a binary form", 0dh, 0ah
           BYTE "D: Converting a character to capital", 0dh, 0ah
           BYTE "E: Reverse the case of an alphabetic character", 0dh, 0ah, 0
    msgA BYTE "Add two binary numbers: ",0
    msgB BYTE "Subtract two binary numbers: ",0
    msgC BYTE "Writing out a decimal number in its binary form: ", 0
    msgD BYTE "Convert a character to an uppercase: ", 0
    msgE BYTE "Reverse the case of an alphabetic character: ", 0

    prompt1 BYTE "Enter a number: ", 0
    prompt2 BYTE "Enter lowercase letter: ", 0
    prompt3 BYTE "Enter a lowercase or capital letter: ", 0
    promptAdd BYTE ", the binary sum is: ", 0
    promptSub BYTE ", the binary difference is: ", 0
    promptCon BYTE ", the binary number is: ", 0
    promptUp BYTE ", this is the uppercase letter: ", 0
    promptReverse BYTE ", this is the reverse case: ", 0
    buffer BYTE BUFMAX+1 DUP(0)
    bufSize DWORD ?
.code
main PROC
    mov edx, OFFSET Nameprompt
    call WriteString
    mov ecx, BUFMAX
    mov edx, OFFSET buffer
    call ReadString
    mov bufSize,eax
    call Crlf
    mov edx, OFFSET prompt
    call WriteString
    call Crlf
    call ReadChar
    mov  ebx,OFFSET CaseTable
    mov  ecx,NumberOfEntries
L1:
    cmp  al,[ebx]
    jne  L2
    call NEAR PTR [ebx + 1]
    call Crlf
    jmp  L3
L2:
    add  ebx,5
    loop L1
L3:
    exit
main ENDP
Process_A PROC
    mov  edx,OFFSET msgA
    call WriteString
    call Crlf
    call Process_A1
    call Process_A2
    ret
Process_A ENDP
Process_A1 PROC
    mov edx,OFFSET prompt1
    call WriteString
    call ReadInt
    mov ebx, eax
    call WriteBinB
    call Crlf
    mov edx,OFFSET prompt1
    call WriteString
    call ReadInt
    mov ecx, eax
    call WriteBinB
    call Crlf
    ret
Process_A1 ENDP
Process_A2 PROC
    call Crlf
    mov ax, blue + (white * 16)
    call SetTextColor
    mov edx,OFFSET buffer
    call WriteString
    mov edx,OFFSET promptAdd
    call WriteString
    add ebx, ecx
    mov eax, ebx
    call WriteBinB
    call Crlf
    mov eax, white + (black * 16)
    call SetTextColor
    ret
Process_A2 ENDP
Process_B PROC
    mov  edx,OFFSET msgB
    call WriteString
    call Crlf
    call Process_B1
    call Process_B2
    ret
Process_B ENDP
Process_B1 PROC
    mov edx,OFFSET prompt1
    call WriteString
    call ReadInt
    mov ebx, eax
    call WriteBinB
    call Crlf
    mov edx,OFFSET prompt1
    call WriteString
    call ReadInt
    mov ecx, eax
    call WriteBinB
    call Crlf
    ret
Process_B1 ENDP
Process_B2 PROC
    call Crlf
    mov eax, blue + (white * 16)
    call SetTextColor
    mov edx,OFFSET buffer
    call WriteString
    mov edx,OFFSET promptSub
    call WriteString
    sub ebx, ecx
    mov eax, ebx
    call WriteBinB
    call Crlf
    mov eax, red + (black * 16)
    call SetTextColor
    ret
Process_B2 ENDP
Process_C PROC
    mov  edx,OFFSET msgC
    call WriteString
    call Crlf
    mov edx,OFFSET prompt1
    call WriteString
    call ReadInt
    mov ebx, eax
    call Crlf
    mov eax, blue + (white * 16)
    call SetTextColor
    mov edx,OFFSET buffer
    call WriteString
    mov edx,OFFSET promptCon
    call WriteString
    mov eax, ebx
    call WriteBinB
    call Crlf
    mov eax, white + (black * 16)
    call SetTextColor
    ret
Process_C ENDP
Process_D PROC
    mov  edx,OFFSET msgD
    call WriteString
    call Crlf
    mov edx,OFFSET prompt2
    call WriteString
    call ReadChar
    call WriteChar
    and al, 11011111b
    mov bl, al
    call Crlf
    mov eax, blue + (white * 16)
    call SetTextColor
    mov edx,OFFSET buffer
    call WriteString
    mov edx,OFFSET promptUp
    call WriteString
    mov eax, 0
    mov al, bl
    call WriteChar
    call Crlf
    mov eax, white + (black * 16)
    call SetTextColor
    ret
Process_D ENDP
Process_E PROC
    mov  edx,OFFSET msgE
    call WriteString
    call Crlf
    mov edx,OFFSET prompt3
    call WriteString
    call ReadChar
    call WriteChar
L1: cmp al, 01100001b
    jl L2
    and al, 11011111b
    mov bl, al
    jmp L3
L2: or al,  00100000b
    mov bl, al
    jmp L3
L3: call Crlf
    mov eax, blue + (white * 16)
    call SetTextColor
    mov edx,OFFSET buffer
    call WriteString
    mov edx,OFFSET promptReverse
    call WriteString
    mov eax, 0
    mov al, bl
    call WriteChar
    call Crlf
    mov eax, white + (blue * 16)
    call SetTextColor
    ret
Process_E ENDP
END main