; Ejercicio lee un # decimal de hasta 5 cifras y dejalo en BX, Asume que es un numero menor a 65,535
; TAREA HACER LAS VALIDACIONES AL DAR ENTER Y AL INGRESAR EL NUMERO
TITLE NUM_DE LEE UN NUMERO DECIMAL DE HASTA 5 CIFRAS Y DEJALO EN BX
.MODEL SMALL
.STACK 100H
.DATA
        MSG2  DB "DAME UN NUMERO DECIMAL DE HASTA 5 CIFRAS $ "
        MSG DB 10,13,"EL NUMERO DECIMAL ES : $ "
        NUM1 DW 0
        NUM2 DW 0
        SUMA DW 0

.CODE
MAIN PROC
        MOV  AX,@DATA
        MOV  DS,AX
        ;PEDIR UN NUMERO
        LEA  DX, MSG2
        CALL DESPLIEGA_ST
        CALL LEE_DECIMAL
        MOV NUM1,BX
        ;PEDIR SEGUNDO NUMERO
        LEA DX,MSG2
        CALL DESPLIEGA_ST
        ;NUMERO A DESPLEGAR
        ;MOV BX,65432
        CALL DESPLIEGA_DECIMAL
        ;TERMINAR MI PROGRAMA
        MOV  AH,4Ch
        INT  21H
MAIN ENDP
DESPLIEGA_ST PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

        XOR CX,CX

        MOV AX,BX
DIVIDIR:
        XOR DX,DX
        ;DIVIDIR ENTRE 10
        MOV BX,10

LEE_NUM:
        MOV  AX,10
        MUL  BX                   ; DX:AX = BX * AX
        MOV  BX,AX

        MOV  AH,1
        INT  21h

        ; CONVERTIR A NUMERO
        AND  AL,0Fh
        CBW                       ; EXTENDER EL BIT DE SIGNO, QUE SIEMPRE SERÁ 0 A AX

        ADD  BX, AX
        LOOP LEE_NUM

        ; EL NUMERO QUEDÓ EN BX
        ; AHORA LO DESPLEGAREMOS POR PANTALLA
        XOR  CX,CX
        MOV  AX,BX
DIVIDE_BX:
        MOV  BX,10
        XOR  DX,DX
        DIV  BX                   ; DIVISION ES: DX:AX /BX
        ; COCIENTE EN AX, RESIDUO EN DX
        PUSH DX
        INC  CX

        CMP  AX,0
        JNE  DIVIDE_BX

        LEA  DX,MSG
        MOV  AH,9
        INT  21H
DESPLIEGA_DEC:
        MOV  AH,2
        POP  DX
        OR   DL,30h
        INT  21H
        LOOP DESPLIEGA_DEC

        MOV  AH,4Ch
        INT  21H
        END MAIN
