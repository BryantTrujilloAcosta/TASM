TITLE PALI2 LLE UN STRING DE TAMA?O ARBITRARIO Y LO DESPLIEGA AL REVES
;INTEGRANTES DEL EQUIPO
;Trujillo Acosta Bryant No.Control 21170495
;Rubio Soto Jesus Guadalupe No.Control 21170471

LEER MACRO
    MOV AH,1
    INT 21h
ENDM

AGG_CHAR MACRO
    PUSH AX
    MOV [BX],AL
    INC BX
    INC CX          ; CX LLEVA LA CUENTA DE CUANTOS CARACTERES SE LEYERON
ENDM

INICIAR_DATA MACRO
    MOV AX, @DATA
    MOV DS, AX
ENDM

DISPLAY_ST MACRO STR
    LEA DX, STR
    MOV AH, 9
    INT 21h
ENDM

TERMINA_MAIN MACRO
    LEA DX, MSG4
    MOV AH, 9
    INT 21h
    
    MOV AH,4Ch
    INT 21H
ENDM

NEW_LINE MACRO
    MOV AH, 2
    INT 21h
    MOV DL, 13
    INT 21h
ENDM 
.MODEL SMALL
.STACK 300h
.DATA
    MSG     DB  10,10,13,'DAME UN STRING TERMINA CON ENTER: $'
    MSG2    DB  10,10,13,'TU STRING AL REVES ES: $'
    MSG3    DB  10,10,13,'TECLEA "S" O "Y" PARA VOLVER A COMENZAR$'
    MSG4    DB  10,10,13,'HASTA LUEGO$'
    ST      DB  100 DUP('$'), '$'
    LEN_ST  DW  0
    MSG_SI  DB  'SI ES PALINDROME$'
    MSG_NO  DB  'NO ES PALINDROME$'
.CODE
MAIN PROC
   INICIAR_DATA
INICIO:
    DISPLAY_ST MSG
    XOR CX,CX       ; PONE CX EN CERO
    LEA BX, ST
    CALL LEER_STRING
    MOV BYTE PTR[BX], '$'
    MOV LEN_ST, CX
    DISPLAY_ST MSG2


    DESPLIEGA_CHAR:
    POP DX
    MOV AH,2 
    INT 21H
    LOOP DESPLIEGA_CHAR

    NEW_LINE
    DISPLAY_ST ST
    
    LEA BX, ST
    MOV CX, LEN_ST
    CALL PALINDROME
    
    ;PEDIR SI DESEA VOLVER A COMENZAR 
    DISPLAY_ST MSG3
    LEER
    ;IF (AL='S' OR AL='s' OR AL='Y' OR AL='y')
    CMP AL,'S'
    JE INICIO
    CMP AL,'s'
    JE INICIO
    CMP AL,'Y'
    JE INICIO
    CMP AL,'y'
    JNE TERMINA
    JMP INICIO
    
    TERMINA:
    TERMINA_MAIN    
MAIN ENDP

LEER_STRING PROC
LEE_CADENA:
    LEER
    CMP AL, 13
    JE SIGUE        ;Jump is equal
    VALIDAR_SI_NUM:     ;if(AL>='0' and <='9') than mete char
    CMP AL, '0'
    JB  LEE_CADENA  ;Jump if below
    CMP AL, '9'
    JBE METE_CHAR   ;Jump if below of Equal
VALIDAR_MAY:        ;else if(al >= 'A' and AL <='Z') THAN METE CHAR
    CMP AL, 'A'
    JB  LEE_CADENA  ;Jump if below
    CMP AL, 'Z'
    JBE METE_CHAR
VALIDAR_MIN:        ;else if (al>='a' and al<='z') than convierte de min a mayuscula y mete char
    CMP AL, 'a'
    JB  LEE_CADENA
    CMP AL, 'z'
    JA  LEE_CADENA  ;Jump if Above
SI_MIN:
    ;SUB AL, 20h    ;OTRA OPCION 
    AND AL, 0DFh    ; MASCARA 1101 1111
METE_CHAR:    
    PUSH AX
    MOV [BX],AL
    INC BX
    INC CX
    JMP LEE_CADENA  ;Salto Incondicional
SIGUE:
RET
ENDP

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