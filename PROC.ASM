TITLE HOLA MUNDO CON PROCEDIMIENTO
.MODEL SMALL
.STACK 100h
.DATA
MSG DB "      HOLA MUNDO!$"
MSG2 DB 10,10,10,13,"BRYANT TRUJILLO$"
.CODE
MAIN PROC
    ;INICIALIZAR SEGMENTO DE DATOS
    MOV AX,@DATA
    MOV DS,AX ;INICIALIZA DS 
    ;DESPLEGAR MENSAJE
    LEA DX,MSG
    CALL DESPLIEGA_MSG

    LEA DX,MSG2
    CALL DESPLIEGA_MSG
; SALIR A DOS
    MOV AH, 4Ch
    INT 21h

MAIN ENDP

DESPLIEGA_MSG PROC
    MOV AH, 9 ;FUNCION DE DESPLEGAR STRING
    INT 21h;DESPLEGAR MENSAJE

    RET
DESPLIEGA_MSG ENDP
    END MAIN
