TITLE PALI2.ASM LEE UN STRING DE TAMANO ARBITRARIO E IDENTIFICA SI ES PALINDROME O NO

INICIAR_D MACRO
    MOV AX,@DATA
    MOV DS,AX
ENDM

DISPLAY_ST MACRO ST
    LEA DX, ST
    MOV AH, 9
    INT 21H
ENDM

NEW_LINE MACRO
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
ENDM

SALIR_DOS MACRO
    ;SALIR A DOS
    MOV AH,4Ch
    INT 21h
ENDM

.MODEL SMALL
.STACK 300h
.DATA
    MSG     DB 10,13, 'DAME UN STRING [TERMINA CON ENTER]: $'
    MSG3    DB 10,13, '"S" O "Y" PARA INICIAR OTRA VEZ. PARA SALIR CUALQUIER TECLA.: $'
    MSG4    DB 10,13, 'FINALIZADO.$'
    STA     DB 100 DUP('$')
    LEN_ST  DW 0
    MSG_SI  DB 10,13, "SI ES PALINDROME.$"
    MSG_NO  DB 10,13, "NO ES PALINDROME.$"
.CODE
MAIN PROC
    INICIAR_D
    ;Armenta Vazquez Airam 21170247
    ;Pedro Chairez Audelo 20170634
    ;Retamoza Salazar Mariajose 20170794

OTRAVEZ:
    DISPLAY_ST MSG
    XOR CX, CX          ; PONE CX EN CERO
    MOV BX, OFFSET STA  ; INICIALIZA BX AL INICIO DEL STRING

LEE_CADENA:
    MOV AH, 1
    INT 21h
    CMP AL, 13
    JE SIGUE            ; SALTA SI SE PRESION? ENTER

VALIDAR_SI_NUM:         
    CMP AL, '0'
    JB  LEE_CADENA      ; SALTA SI ES MENOR QUE '0'
    CMP AL, '9'
    JBE METE_CHAR       ; SALTA SI ES MENOR O IGUAL A '9'

VALIDAR_MAY:           
    CMP AL, 'A'
    JB  LEE_CADENA
    CMP AL, 'Z'
    JBE METE_CHAR

VALIDAR_MIN:           
    CMP AL, 'a'
    JB  LEE_CADENA
    CMP AL, 'z'
    JA  LEE_CADENA

SI_MIN:
    AND AL, 0DFh        

METE_CHAR:    
    MOV [BX], AL
    INC BX
    INC CX              ; CX LLEVA LA CUENTA DE CUANTOS CARACTERES SE LEYERON
    JMP LEE_CADENA

SIGUE:
    MOV BYTE PTR [BX], '$'
    MOV LEN_ST, CX
    NEW_LINE
    LEA BX, STA
    MOV CX, LEN_ST
    CALL PALINDROME
    
    DISPLAY_ST MSG3
    
    MOV AH, 1 ;LEER CHAR
    INT 21h
    CMP AL, 'S'
    JE INICIOCERCA
    CMP AL, 's'
    JE INICIOCERCA
    CMP AL, 'Y'
    JE INICIOCERCA
    CMP AL, 'y'
    JE INICIOCERCA
    JMP TERMINA

INICIOCERCA:
    JMP OTRAVEZ

TERMINA:
    DISPLAY_ST MSG4
    SALIR_DOS
MAIN ENDP

PALINDROME PROC  
    MOV SI, BX
    ADD SI, CX
    DEC SI
    SHR CX, 1

COMPARAR: 
    MOV AL, [BX]
    CMP AL, [SI]
    JNE NO_ES
    INC BX
    DEC SI 
    LOOP COMPARAR

SI_ES:
    NEW_LINE
    DISPLAY_ST MSG_SI
    JMP FINALIZA

NO_ES:
    NEW_LINE
    DISPLAY_ST MSG_NO

FINALIZA:
    RET
PALINDROME ENDP
END MAIN