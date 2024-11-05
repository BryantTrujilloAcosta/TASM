TITLE PALI2 LLE UN STRING DE TAMA?O ARBITRARIO Y LO DESPLIEGA AL REVES
INIT_DS MACRO
    MOV  AX,@DATA
    MOV  DS,AX
ENDM
DISPLAY_ST MACRO ST
    LEA DX, ST
    MOV AH, 9
    INT 21H
ENDM
NEW_LINE MACRO
    MOV AH, 2
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
ENDM
.MODEL SMALL
.STACK 300h
.DATA
    MSG     DB  10,10,13,'DAME UN STRING TERMINA CON ENTER: $'
    MSG2    DB  10,10,13,'TU STRING AL REVES ES: $'
    MSG3    DB  10,10,13,'TECLEA "S" O "Y" PARA VOLVER A COMENZAR$'
    MSG4    DB  10,10,13,'HASTA LUEGO$'
    ST DB 100 DUP('$'), '$'
    LEN_ST DW 0
    MSG_SI DB "SI ES PALINDROME$"
    MSG_NO DB "NO ES PALINDROME$"
.CODE
MAIN PROC
    INIT_DS
INICIO:
    LEA DX, MSG
    MOV AH, 9
    INT 21H
    
    XOR CX,CX       ; PONE CX EN CERO
    LEA BX,ST
LEE_CADENA:
    MOV AH,1
    INT 21h
    
    CMP AL, 13
    JE SIGUE        ;Jump id equal
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
    MOV[BX],AL
    INC BX
    INC CX          ; CX LLEVA LA CUENTA DE CUANTOS CARACTERES SE LEYERON
    JMP LEE_CADENA  ;Salto Incondicional
SIGUE:
    MOV BYTE PTR [BX],"$" 
    MOV LEN_ST,CX

    LEA DX, MSG2
    MOV AH, 9    
    INT 21H
DESPLIEGA_CHAR:
    POP DX
    MOV AH,2 
    INT 21H
    LOOP DESPLIEGA_CHAR

    NEW_LINE
    DISPLAY_ST ST
    
    LEA BX,ST
    MOV CX,LEN_ST
    CALL PALINDROME
    ;PEDIR SI DESEA VOLVER A COMENZAR
    LEA DX, MSG3
    MOV AH, 9
    INT 21h
    
    MOV AH,1 
    INT 21h
    ;IF (AL='S' OR AL='s' OR AL='Y' OR AL='y')
    CMP AL,'S'
    JE INICIO
    CMP AL,'s'
    JE INICIO
    CMP AL,'Y'
    JE INICIO
    CMP AL,'y'
    JE INICIO
TERMINA:    ;ELSE TERMINA
    LEA DX, MSG4
    MOV AH, 9
    INT 21h
    
    MOV AH,4Ch
    INT 21H
MAIN ENDP
PALINDROME PROC  
    
    MOV SI,BX 
    ADD SI,CX
    DEC SI 
    SHR CX, 1
COMPARAR: 
    MOV AL,[BX]
    CMP AL,[SI]
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