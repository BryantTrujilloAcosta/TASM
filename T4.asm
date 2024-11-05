TITLE T4 LEE DOS NUMEROS BINARIOS Y CALCULA LA SUMA O LA RESTA DEPENDIENDO DE LO QUE EL USAURIO INDIQUIE
;EQUIPO
;TRUJILLO ACOSTA BRYANT No.Control. 21170495
;RUBIO SOTO JESUS GUADALUPE No.Control. 21170471

.MODEL SMALL
.STACK 300h
.DATA
    MSG     DB 10,13,'INGRESE UN NUMERO EN BINARIO DE 8 BITS: $'
    MSG2    DB 10,13,'INGRESE OTRO NUMERO EN BINARIO DE 8 BITS: $'
    MSG3    DB 10,13,'EL RESULTADO DE LA SUMA ES: $'
    MSG4    DB 10,13,'EL RESULTADO DE LA RESTA ES: $'
    MSG5    DB 10,13,'DESEA SUMAR(S) O RESTAR(R): $'
    MSG6    DB 10,13,'DESEA VOLVER A COMENZAR? SI(S) / NO(N):  $'
    MSG7    DB 10,13,'TERMINA PROGRAMA $'
    MSG_ERR DB 10,13,'DATO INVALIO INTENTE DE NUEVO: $'
    BINARIO1    DB 0
    BINARIO2    DB 0
    RESULTADO   DB 0
.CODE
    MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    
INICIO1:
    LEA DX,MSG
    MOV AH,9
    INT 21h
    
    MOV CX, 8
CICLO1:
    MOV AH,1
    INT 21h
    
    ;VALIDAR SI EL DATO VALIDO
    CMP AL,'0'
    JE VALIDO1
    CMP AL,'1'
    JE VALIDO1

ERROR1:
    LEA DX, MSG_ERR
    MOV AH,9
    INT 21H
    JMP INICIO1
    
VALIDO1:
    SHR AL,1
    RCL BINARIO1,1
    
LOOP CICLO1

INICIO2:
    LEA DX, MSG2
    MOV AH,9
    INT 21H
    
    MOV CX, 8
    
CICLO2:
    MOV AH,1
    INT 21H
    ;VALIDAR SI EL DATO ES VALIDO
    CMP AL,'0'
    JE VALIDO2
    CMP AL,'1'
    JE VALIDO2

ERROR2:
    LEA DX, MSG_ERR
    MOV AH,9
    INT 21H
    JMP INICIO2

VALIDO2:
    SHR AL,1
    RCL BINARIO2,1
    
LOOP CICLO2

    ;SOLICITAR RESTAR O SUMAR
    LEA DX,MSG5
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    
    ;IF
    CMP AL,'R'
    JE RESTA
    CMP AL,'r'
    JE RESTA
SUMA:
    LEA DX, MSG3
    MOV AH,9
    INT 21H
    
    MOV AL, BINARIO1
    ADD AL, BINARIO2
    MOV RESULTADO, AL
    
    MOV CX, 8
CICLOSUMA:;SE MUESTRA EL RESULTADO DE LA SUMA
    
    XOR DL,DL
    ROL RESULTADO,1
    RCL DL,1

    OR DL,30h
    
    MOV AH,2
    INT 21h
LOOP CICLOSUMA

JMP PEDIR_REINICIO
    
RESTA:
    LEA DX, MSG4
    MOV AH,9
    INT 21H
    
    MOV AL, BINARIO1
    SUB AL, BINARIO2    
    MOV RESULTADO, AL
    
    MOV CX, 8

CICLORESTA:;SE MUESTRA EL RESULTADO DE LA RESTA
    
    XOR DL,DL
    ROL RESULTADO,1
    RCL DL,1

    OR DL,30h
    
    MOV AH,2
    INT 21h
LOOP CICLORESTA
PEDIR_REINICIO:
    ;PREGUNTAR SI QUIERE HACER OTRA OPERACION
    LEA DX,MSG6
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    
    ;IF
    CMP AL,'S'
    JE REINICIAR
    CMP AL,'s'
    JE REINICIAR
    CMP AL,'N'
    JE TERMINA
    CMP AL,'n'
    JE TERMINA
    
REINICIAR:
   JMP INICIO1
       
TERMINA:
    LEA DX,MSG7
    MOV AH,9
    INT 21H
    
    MOV AH,4Ch
    INT 21h
MAIN ENDP
END MAIN