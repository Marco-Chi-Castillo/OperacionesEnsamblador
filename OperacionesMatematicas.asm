;Integrantes:
;Marcos Abraham Caamal Tzuc (17070014)
;Marco Antonio Chi Castiilo (17070023)
;Grupo: 6 A  

.model small
.data
    N1 db 0
    N2 db 0 
    letra db 0   
    
    
    D1MULN1 DB 0
    D2MULN1 DB 0
    D1MULN2 DB 0
    D2MULN2 DB 0
    UNIMUL DB 0   
    DECMUL DB 0 
    CENMUL DB 0 
    MILMUL DB 0
    ACA1   DB 0
    ACA2   DB 0
    ACA3   DB 0
        
    
    DECE DB 0
    UNI DB 0   
    CEN DB 0
    NUMERO1 DB 0 
    
    NUMERO2 DB 0
    RESIDUO DB 0 
    
    msg1 db 10, 13, "--- Operaciones matematicas --- $"
    msg2 db 10, 13, "1.-Suma de 2 numeros $"
    msg3 db 10, 13, "2.-Multiplicacion de 2 numeros$"
    msg4 db 10, 13, "3.-Division de 2 numeros $"
    msg5 db 10, 13, "4.-Resta de 2 numeros $"
    msg6 db 10, 13, "5.-Salir $" 
    
      
    msg7 db 10, 13, "Presiona cualquier tecla para regresar al menu $"
    msg8 db 10, 13, "3.-Regresa al menu principal$"  
    msg9 db 10, 13, "Suma$"
    msg10 db 10, 13,"Multiplicacion$"   
    msg11 db 10, 13,"Division$" 
    msg12 db 10, 13,"Resta$" 
    msg13 db 10, 13,"El cociente es: $" 
    msg14 db 10, 13,"El residuo es: $"
    M1 db 10, 13, "Ingresa el primer numero de dos digitos: $"
    M2 db 10, 13, "Ingresa el segundo numero de dos digitos: $" 
    M3 db 10, 13, "El resultado es: $"
    M4 db 10, 13, "Elige una opcion: $"
    M5 db 10, 13, "Ingresa el dividendo de dos digitos: $"
    M6 db 10, 13, "Ingresa el divisor de dos digitos: $"
    M7 db "-$"
.code
    mov ax,@data
    mov ds, ax 
              
    ;---------------MACROS -----------------------   
    
    ;macro para sumar las dos variables
    MACRO DIGITOSUMA MACRO
        MOV AL, NUMERO1              ; MOV VARIABLE N1 A AL
        ADD AL, NUMERO2              ; SUMAR N1 Y N2
    ENDM 
        
    
    MACRO DIGITODIVISION MACRO 
        XOR AX, AX         ;limpiamos el registro AX para evitar problemas en la division
        MOV AL, NUMERO1     ; MOVEMOS VARIABLE N1 A AL
        MOV BL, NUMERO2     ; MOVEMOS VARIABLE N2 A AL
        DIV BL              ;REALIZAMOS LA DIVISION 
        MOV RESIDUO, AH     ;Guardamos el residuo de la division 
        
    ENDM
    
    MACRO DIGITORESTA MACRO 
        MOV AL, NUMERO1
        SUB AL, NUMERO2
    ENDM
      
    ;macro para ingresar digitos
    INGRESODATOS1 MACRO MSG
        
        MENSAJES MSG
        ;INGRESAR DECENAS  
        MOV AH,1       ;SERVICIO DE ENTRADA
        INT 21H        ;INTERRUPCION 21H
        SUB AL, 30H    ;RESTAR 30H / 48D
        MOV DECE, AL     ;MOVER ENTRADA A LA VARIABLE N1
            
        ;INGRESAR UNIDADES
        MOV AH, 1
        INT 21H
        SUB AL, 30H
        MOV UNI, AL
        
        ;UNIMOS LOS DIGITOS SEPARADOS A UNA VARIABLE
        MOV AL,DECE      
        MOV BL,10  
        MUL BL
        ADD AL,UNI
        MOV NUMERO1,AL  
        
    ENDM   
    
    INGRESODATOS2 MACRO MSG
        
        MENSAJES MSG
        ;INGRESAR DECENAS  
        MOV AH,1       ;SERVICIO DE ENTRADA
        INT 21H        ;INTERRUPCION 21H
        SUB AL, 30H    ;RESTAR 30H / 48D
        MOV DECE, AL     ;MOVER ENTRADA A LA VARIABLE N1
            
        ;INGRESAR UNIDADES
        MOV AH, 1
        INT 21H
        SUB AL, 30H
        MOV UNI, AL
        
        ;UNIMOS LOS DIGITOS SEPARADOS A UNA VARIABLE
        MOV AL,DECE      
        MOV BL,10  
        MUL BL
        ADD AL,UNI
        MOV NUMERO2,AL  
        
    ENDM
    
    ;macro para limpiar la pantalla
    LIMPIARPANTALLA MACRO
        MOV ah,0         ;limpia la pantalla
        MOV al,3h
        INT 10h
    ENDM     
     
    ;macro para imprimir mensajes
    MENSAJES MACRO MSG
        MOV AH, 09h      
        LEA DX, MSG
        INT 21h
    ENDM  
    
    ;macro de opciones del menu segundario
    SUBOPCIONES MACRO NUMERO
        CMP NUMERO, 49     ;Opcion 1
        JE CALL SUMA  
        
        CMP NUMERO, 50     ;Opcion 2
        JE CALL MULTIPLICACION 
        
         CMP NUMERO, 51     ;Opcion 3
        JE CALL DIVISION 
        
         CMP NUMERO, 52     ;Opcion 4
        JE CALL RESTA
        
        CMP NUMERO, 53     ;Opcion 5
        JE SALIR                      
         
    ENDM      
    
    ;macro de opciones del menu principal
    OPCIONES MACRO NUMERO
        CMP NUMERO, 49 ;opcion 1
        JE SUBMENU
    
      
        CMP NUMERO, 50 ;opcion 2
        JE CALL ABC
        
        
        CMP NUMERO, 51 ;opcion 3
        JE SALIR
    ENDM   
    
    ;menu principal
    
    MENU:  
           
        LIMPIARPANTALLA 
        MENSAJES msg1
        
        MENSAJES msg2
        
        MENSAJES msg3 
        
        MENSAJES msg4  
        
        MENSAJES msg5 
        
        MENSAJES msg6 
        
        MENSAJES M4 
        
        MOV AH, 01h     ;esperamos que ingrese una tecla el usuario
        INT 21h  
        
        SUBOPCIONES AL
        
    JMP MENU
    
    ;--------------- PROCEDIMIENTOS --------------- 
    
    ;procedimiento para sumar los digitos
    SUMA PROC NEAR
        LIMPIARPANTALLA
        
        MENSAJES msg9  
        
        MOV SI, 0

        INGRESODATOS1 M1
        
        INGRESODATOS2 M2
        
        DIGITOSUMA
        
        CALL RESULTADOOPERACIONES
    SUMA ENDP  
                              
    ;procedimiento para la multiplicacion de los digitos                                      
    MULTIPLICACION PROC NEAR
        LIMPIARPANTALLA
  
        MENSAJES msg10
            
        CALL RESULTADOOPERACIONESMUL
        
    MULTIPLICACION ENDP  
                        
                        
    DIVISION PROC NEAR
        LIMPIARPANTALLA
        
        MENSAJES msg11
            
        INGRESODATOS1 M5
        
        INGRESODATOS2 M6
    
        DIGITODIVISION
            
        CALL RESULTADOOPERACIONESDIV   
        
    DIVISION ENDP  
    
    
    RESTA PROC NEAR
        LIMPIARPANTALLA
        
        MENSAJES msg12
            
        INGRESODATOS1 M1
        
        INGRESODATOS2 M2 
        
        MOV SI, 0
         
        MOV AL, NUMERO1
        CMP AL, NUMERO2
        JNLE CONTINUA
            MOV AH, NUMERO2
            MOV NUMERO1, AH
            MOV NUMERO2, AL
            MOV SI, 1
        
        CONTINUA:
        
    
        DIGITORESTA
            
        CALL RESULTADOOPERACIONES  
        
    RESTA ENDP 
    
    ;procedimiento para la impresion del abecedario        
    ABC PROC NEAR
        LIMPIARPANTALLA  
        
        MOV CL, 90  ;le pasamos el valor de 90 a cl que representa la Z en ascii
        
        FOR:
            CMP CL, 64   ;comparamos si cl es <=64
            JLE REGRESAR ;si es menor o igual a 64 significa que ya imprimio todos las letras del abecedario
            
            MOV AL,CL ;movemos en al el valor actual de cl
            MOV letra, AL ;guardamos el valor de la letra actual 
            
            MOV AH,02h
            MOV DL,letra ;espacio que separa letra por letra
            INT 21h        
            
            MOV AH,02h
            MOV DL,32 ;espacio que separa letra por letra
            INT 21h
            
            DEC CL
        JMP FOR
        
        REGRESAR:
         
            MENSAJES msg7  
            
            MOV AH, 01h     ;esperamos que ingrese una tecla el usuario
            INT 21h  
           
            JMP MENU
    ABC ENDP
             
    ;procedimiento para imprimir los resultados de las operaciones
    RESULTADOOPERACIONES PROC NEAR  
      
        aam ;ajusta el valor en AL por: AH=23 Y AL=4
      
        mov UNI,al ; Respaldo 4 en unidades
        mov al,ah ;muevo lo que tengo en AH a AL para poder volver a separar los números
        
        aam ; separa lo qe hay en AL por: AH=2 Y AL=3
        mov CEN,ah ;respaldo las centenas en cen en este caso 2
        
        mov DECE,al ;respaldo las decenas en dec, en este caso 3
                                                                 
        
        ;Imprimos los tres valores empezando por centenas, decenas y unidades.
        MENSAJES M3   
        
        CMP SI, 0
        JE  IMPRIMIR
            MENSAJES M7
        
        IMPRIMIR:
        mov ah,02h
        
        mov dl,CEN
        add dl,30h ; se suma 30h a dl para imprimir el numero real.
        int 21h
        
        mov dl,DECE
        add dl,30h
        int 21h
        
        mov dl,UNI
        add dl,30h
        int 21h 
         
            
        MENSAJES msg7
            
        mov ah, 01h     ;esperamos que el usuario ingrese una tecla
        int 21h
            
        jmp MENU
    RESULTADOOPERACIONES ENDP
    
    ;procedimiento para imprimir los resultados de las operaciones
    RESULTADOOPERACIONESDIV PROC NEAR 
        aam ;ajusta el valor en AL por: AH=23 Y AL=4
        
        mov UNI,al ; Respaldo 4 en unidades
        mov al,ah ;muevo lo que tengo en AH a AL para poder volver a separar los números
        
        aam ; separa lo qe hay en AL por: AH=2 Y AL=3
        mov CEN,ah ;respaldo las centenas en cen en este caso 2
        
        mov DECE,al ;respaldo las decenas en dec, en este caso 3
        
        
        ;Imprimos los tres valores empezando por centenas, decenas y unidades.
        MENSAJES msg13
        
        mov ah,02h
        
        mov dl,CEN
        add dl,30h ; se suma 30h a dl para imprimir el numero real.
        int 21h
        
        mov dl,DECE
        add dl,30h
        int 21h
        
        mov dl,UNI
        add dl,30h
        int 21h
         
        MENSAJES msg14  
        Mov al, RESIDUO 
        aam   
        
        mov DECE, ah
        mov UNI, al
        
        mov ah,02h
        mov dl,DECE
        add dl,30h
        int 21h
        
        mov ah,02h
        mov dl,UNI
        add dl,30h
        int 21h
            
            
        MENSAJES msg7
            
        mov ah, 01h     ;esperamos que el usuario ingrese una tecla
        int 21h
            
        jmp MENU
    RESULTADOOPERACIONESDIV ENDP 
    
    
    RESULTADOOPERACIONESMUL PROC NEAR 
        
        MENSAJES M1  
        
        ;LEEMOS LOS DATOS DEL PRIMER NUMERO
        ;INGRESAR DECENAS  
        MOV AH,1       ;SERVICIO DE ENTRADA
        INT 21H        ;INTERRUPCION 21H
        SUB AL, 30H    ;RESTAR 30H / 48D
        MOV D1MULN1, AL     ;MOVER ENTRADA A LA VARIABLE N1
            
        ;INGRESAR UNIDADES
        MOV AH, 1
        INT 21H
        SUB AL, 30H
        MOV D2MULN1, AL
         
        MENSAJES M2
        
        ;LEEMOS LOS DATOS DEL SEGUNDO NUMERO
        ;INGRESAR DECENAS  
        MOV AH,1       ;SERVICIO DE ENTRADA
        INT 21H        ;INTERRUPCION 21H
        SUB AL, 30H    ;RESTAR 30H / 48D
        MOV D1MULN2, AL     ;MOVER ENTRADA A LA VARIABLE N1
            
        ;INGRESAR UNIDADES
        MOV AH, 1
        INT 21H
        SUB AL, 30H
        MOV D2MULN2, AL  
        
        ;INICIA EL ALGORITMO DE LA MULTIPLICACION 
        MOV AL, D2MULN2             ; MOV VARIABLE N1 A AL
        MOV BL, D2MULN1             ; MOV VARIABLE N2 A BL
        MUL BL                    ;realizamos la multiplicacion
        
        AAM            ;AJUSTE DE CARGA PARA AX
        
        MOV ACA1,ah ;respaldamos nuestro acarreo 
        
        MOV UNIMUL,al ;guardamos la unidad de la multiplicacion 
        
                             
        ;REALIZAMOS LA MULTIPLICACION PARA OBTENER LAS DECENAS DE LA MULTIPLICACION
        MOV AL, D2MULN2             ; MOV VARIABLE N1 A AL
        MOV BL, D1MULN1             ; MOV VARIABLE N2 A BL
        MUL BL                      ;realizamos la multiplicacion  
        ADD AL, ACA1                ;LE SUMANOS A AL NUESTRO ANTERIOR ACARREO
        
        AAM                         ;AJUSTE DE CARGA
        
        MOV ACA1, 0h                ;REINICIAMOS EL VALOR EN CERO DE NUESTRO ACARREO
        
        MOV ACA1,ah ;respaldamos el nuevo valor nuestro acarreo     
        
        MOV DECMUL,al ;guardamos la pre-decena de la multiplicacion
      
        ;REALIZAMOS OTRA MULTIPLICACION 
        MOV AL, D1MULN2             ; MOV VARIABLE N1 A AL
        MOV BL, D2MULN1             ; MOV VARIABLE N2 A BL
        MUL BL                    ;realizamos la multiplicacion  
        
        AAM                  ;AJUSTE DE CARGA
        
        MOV ACA2,ah ;respaldamos nuestro segundo acarreo 
        
        ADD DECMUL,al ;sumamos la pre-decena de la multiplicacion
        
        MOV AL,DECMUL    ;ACEMOS EL AJUSTE DE CARGA A NUESTRA PREDECEHA
        AAM  
        
        MOV ACA3,ah ;respaldamos nuestro tercer acarreo 
        
        MOV DECMUL,al ;guardamos la verdadera decena de la multiplicacion 
        
        
        ;MULTIPLICACION PARA OBTENER LAS CENTENAS Y MILES DE LA MULTIPLICACION 
        MOV AL, D1MULN2             ; MOV VARIABLE N1 A AL
        MOV BL, D1MULN1             ; MOV VARIABLE N2 A BL
        MUL BL                    ;realizamos la multiplicacion 
        ADD AL, ACA1              ;SUMANOS LOS ACARREOS A EL RESULTADO DE NUESTRA MULTIPLICACION
        ADD AL, ACA2
        ADD AL, ACA3
                                   
        AAM                       ;AJUSTE DE CARGA PARA OBTENER LAS CENTENAS Y DECENAS DE NUESTRA MULTIPLICACION
        
        MOV MILMUL,ah ;respaldamos nuestro acarreo 
        
        MOV CENMUL,al ;guardamos la verdadera decena de la multiplicacion 
         
         
        MENSAJES M3
        
        mov ah,02h 
       
        mov dl,MILMUL
        add dl,30h ; se suma 30h a dl para imprimir el numero real.
        int 21h
        
        mov ah,02h
        mov dl,CENMUL
        add dl,30h
        int 21h   
        
        mov ah,02h
        mov dl,DECMUL
        add dl,30h
        int 21h
        
        mov ah,02h
        mov dl,UNIMUL
        add dl,30h
        int 21h  
        
            
        MENSAJES msg7
            
        mov ah, 01h     ;esperamos que el usuario ingrese una tecla
        int 21h
            
        jmp MENU
    RESULTADOOPERACIONESMUL ENDP 
    
          
    ;etiqueta para salir
    SALIR:
        .exit 
    
    
end