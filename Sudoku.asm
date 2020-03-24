
;; 210
;;SUDOKU PUZZLE 
;;Vulis

;; added two puzzle with their solution. Most of the codes are not commented well, and it is kinda messy.
.model small
.386
.data
background db ?
lin_col    db ?
boar_col   db ?
new_lin_col db 11h    
new_back_col  db 17h
new_boar_col  db 10h
x_pos   db ?
y_pos   db ?
count1 db ?
count2 db ?
count3 db ?
count4 db ?
ind_ex db ?
prob1    db 48,55,48,53,51,49,48,48,48 ;;default
         db 48,48,48,48,48,48,48,48,54
         db 52,49,50,56,48,48,48,48,48
         db 53,48,51,49,48,48,48,48,48
         db 48,56,48,48,48,48,48,48,48
         db 48,48,48,48,48,55,54,48,56
         db 48,48,48,48,48,52,51,57,55
         db 50,48,48,48,48,48,48,54,48
         db 48,48,48,55,49,57,48,50,48,'$'

sol1         db 54,55,57,53,51,49,52,56,50
             db 56,51,53,57,52,50,55,49,54 ;;default
             db 52,49,50,56,55,54,57,53,51
             db 53,52,51,49,54,56,50,55,57
             db 55,56,54,50,57,51,53,52,49
             db 57,50,49,52,53,55,54,51,56
             db 49,53,56,54,50,52,51,57,55
             db 50,57,55,51,56,53,49,54,52
             db 51,54,52,55,49,57,56,50,53,'$'

prob2    db 48,48,48,48,48,48,48,48,50 
         db 48,48,48,48,48,48,57,52,48
         db 48,48,51,48,48,48,48,48,53
         db 48,57,50,51,48,53,48,55,52
         db 56,52,48,48,48,48,48,48,48
         db 48,54,55,48,57,56,48,48,48
         db 48,48,48,55,48,54,48,48,48
         db 48,48,48,57,48,48,48,50,48
         db 52,48,56,53,48,48,51,54,48,'$'

sol2     db 54,56,52,49,53,57,55,51,50 
         db 55,53,49,56,51,50,57,52,54
         db 57,50,51,54,55,52,49,56,53
         db 49,57,50,51,54,53,56,55,52
         db 56,52,53,50,49,55,54,57,51
         db 51,54,55,52,57,56,50,53,49
         db 50,51,57,55,52,54,53,49,56
         db 53,49,54,57,56,51,52,50,55
         db 52,55,56,53,50,49,51,54,57,'$'

prob     db 48,55,48,53,51,49,48,48,48
         db 48,48,48,48,48,48,48,48,54
         db 52,49,50,56,48,48,48,48,48
         db 53,48,51,49,48,48,48,48,48
         db 48,56,48,48,48,48,48,48,48
         db 48,48,48,48,48,55,54,48,56
         db 48,48,48,48,48,52,51,57,55
         db 50,48,48,48,48,48,48,54,48
         db 48,48,48,55,49,57,48,50,48,'$'
         
         sol db 54,55,57,53,51,49,52,56,50
             db 56,51,53,57,52,50,55,49,54
             db 52,49,50,56,55,54,57,53,51
             db 53,52,51,49,54,56,50,55,57
             db 55,56,54,50,57,51,53,52,49
             db 57,50,49,52,53,55,54,51,56
             db 49,53,56,54,50,52,51,57,55
             db 50,57,55,51,56,53,49,54,52
             db 51,54,52,55,49,57,56,50,53,'$'

       
 user_in db 48,55,48,53,51,49,48,48,48
         db 48,48,48,48,48,48,48,48,54
         db 52,49,50,56,48,48,48,48,48
         db 53,48,51,49,48,48,48,48,48
         db 48,56,48,48,48,48,48,48,48
         db 48,48,48,48,48,55,54,48,56
         db 48,48,48,48,48,52,51,57,55
         db 50,48,48,48,48,48,48,54,48
         db 48,48,48,55,49,57,48,50,48,'$'
    row_num db ?
    col_num db ?
    board_count db 1
    
.code




START:
mov ax, @DATA
mov ds, ax
mov ah, 00h 
mov al, 03h 
int 10h
 ;Set color by default
 mov background, 67h
 mov lin_col,    68h
 mov boar_col,   60h
mov count1 , 0h
mov count2 , 0h
mov count3 , 0h
mov count4 , 0h
mov ind_ex , 0h
mov row_num , 0h
mov col_num , 0h
	BOARD:
    
	mov ax, 0600h
	mov bh, background
	mov cx, 0000h
	mov dx, 184Fh 
	int 10h 

    Hor_line MACRO Row, Column, Color,Character
	mov ah, 2
	mov dh, Row
	mov dl, Column
	mov bh, 0
	int 10h

    mov ah, 09h
	mov al, Character
	mov bh, 0
	mov bl, Color
	mov cx, 55
	int 10h 
    
  	ENDM
   S_line MACRO Row, Column, Color,Character
	mov ah, 2
	mov dh, Row
	mov dl, Column
	mov bh, 0
	int 10h

    mov ah, 09h
	mov al, Character
	mov bh, 0
	mov bl, Color
	mov cx, 1
	int 10h 
    
  	ENDM
    Ver_line MACRO Row, Column, Color, Character,endd,start,loopss
    mov dh, endd
    loopss:
    S_line  dh,Row,Color,Character
    add dh,-1
    cmp dh,start
    JGE loopss
    ENDM
	
    Hor_line    3,5,boar_col,205d
    Hor_line    5,5,lin_col,196d
    Hor_line    7,5,lin_col,196d
    Hor_line    9,5,boar_col,205d
    Hor_line    11,5,lin_col,196d
    Hor_line    13,5,lin_col,196d
    Hor_line    15,5,boar_col,205d
    Hor_line    17,5,lin_col,196d
    Hor_line    19,5,lin_col,196d
    Hor_line    21,5,boar_col,205d
    S_line       3,4,boar_col,201d
    S_line       3,60,boar_col,187d
    S_line       21,4,boar_col,200d
    S_line       21,60,boar_col,188d
    S_line       9,4,boar_col,204d
    S_line       9,60,boar_col,185d
    S_line       15,4,boar_col,204d
    S_line       15,60,boar_col,185d

    Ver_line    4,4,boar_col,186d,8,4,l1
    Ver_line    4,4,boar_col,186d,14,10,l2
    Ver_line    4,4,boar_col,186d,20,16,l3
    Ver_line    60,4,boar_col,186d,8,4,l4
    Ver_line    60,4,boar_col,186d,14,10,l5
    Ver_line    60,4,boar_col,186d,20,16,l6

    Ver_line    10,4,lin_col,179d,8,4,v1
    S_line      3,10 ,lin_col,209d
    S_line      9,10 ,lin_col,216d
    Ver_line    16,4,lin_col,179d,8,4,v2
    S_line      3,16 ,lin_col,209d
    S_line      9,16 ,lin_col,216d
    Ver_line    23,4,boar_col,186d,8,4,v3
    S_line      3,23 ,boar_col,203d
    S_line      9,23 ,boar_col,206d
    Ver_line    29,4,lin_col,179d,8,4,v4
    S_line      3,29 ,lin_col,209d
    S_line      9,29 ,lin_col,216d
    Ver_line    35,4,lin_col,179d,8,4,v5
    S_line      3,35 ,lin_col,209d
    S_line      9,35 ,lin_col,216d
    Ver_line    41,4,boar_col,186d,8,4,v6
    S_line      3,41 ,boar_col,203d
    S_line      9,41 ,boar_col,206d
    Ver_line    47,4,lin_col,179d,8,4,v7
    S_line      3,47 ,lin_col,209d
    S_line      9,47 ,lin_col,216d
    Ver_line    53,4,lin_col,179d,8,4,v8
    S_line      3,53 ,lin_col,209d
    S_line      9,53 ,lin_col,216d

    Ver_line    10,4,lin_col,179d,14,10,v9
    S_line      15,10 ,lin_col,216d
    Ver_line    16,4,lin_col,179d,14,10,v10
    S_line      15,16 ,lin_col,216d
    Ver_line    23,4,boar_col,186d,14,10,v11
    S_line      15,23 ,boar_col,206d
    Ver_line    29,4,lin_col,179d,14,10,v12
    S_line      15,29 ,lin_col,216d
    Ver_line    35,4,lin_col,179d,14,10,v13
    S_line      15,35 ,lin_col,216d
    Ver_line    41,4,boar_col,186d,14,10,v14
    S_line      15,41 ,boar_col,206d
    Ver_line    47,4,lin_col,179d,14,10,v15
    S_line      15,47,lin_col,216d
    Ver_line    53,4,lin_col,179d,14,10,v16
    S_line      15,53 ,lin_col,216d

    Ver_line    10,4,lin_col,179d,20,16,v17
    S_line      21,10 ,lin_col,207d
    Ver_line    16,4,lin_col,179d,20,16,v18
    S_line      21,16 ,lin_col,207d
    Ver_line    23,4,boar_col,186d,20,16,v19
    S_line      21,23 ,boar_col,202d
    Ver_line    29,4,lin_col,179d,20,16,v20
    S_line      21,29 ,lin_col,207d
    Ver_line    35,4,lin_col,179d,20,16,v21
    S_line      21,35 ,lin_col,207d
    Ver_line    41,4,boar_col,186d,20,16,v22
    S_line      21,41 ,boar_col,202d
    Ver_line    47,4,lin_col,179d,20,16,v23
    S_line      21,47,lin_col,207d
    Ver_line    53,4,lin_col,179d,20,16,v24
    S_line      21,53 ,lin_col,207d

    ;;INTERSECTION CONNECTION
    s_line  5,10,lin_col,197d
    s_line  5,16,lin_col,197d
    s_line  5,23,boar_col,215d
    s_line  5,29,lin_col,197d
    s_line  5,35,lin_col,197d
    s_line  5,41,boar_col,215d
    s_line  5,47,lin_col,197d
    s_line  5,53,lin_col,197d

    s_line  7,10,lin_col,197d
    s_line  7,16,lin_col,197d
    s_line  7,23,boar_col,215d
    s_line  7,29,lin_col,197d
    s_line  7,35,lin_col,197d
    s_line  7,41,boar_col,215d
    s_line  7,47,lin_col,197d
    s_line  7,53,lin_col,197d

    s_line  11,10,lin_col,197d
    s_line  11,16,lin_col,197d
    s_line  11,23,boar_col,215d
    s_line  11,29,lin_col,197d
    s_line  11,35,lin_col,197d
    s_line  11,41,boar_col,215d
    s_line  11,47,lin_col,197d
    s_line  11,53,lin_col,197d

    s_line  13,10,lin_col,197d
    s_line  13,16,lin_col,197d
    s_line  13,23,boar_col,215d
    s_line  13,29,lin_col,197d
    s_line  13,35,lin_col,197d
    s_line  13,41,boar_col,215d
    s_line  13,47,lin_col,197d
    s_line  13,53,lin_col,197d

    s_line  17,10,lin_col,197d
    s_line  17,16,lin_col,197d
    s_line  17,23,boar_col,215d
    s_line  17,29,lin_col,197d
    s_line  17,35,lin_col,197d
    s_line  17,41,boar_col,215d
    s_line  17,47,lin_col,197d
    s_line  17,53,lin_col,197d

    s_line  19,10,lin_col,197d
    s_line  19,16,lin_col,197d
    s_line  19,23,boar_col,215d
    s_line  19,29,lin_col,197d
    s_line  19,35,lin_col,197d
    s_line  19,41,boar_col,215d
    s_line  19,47,lin_col,197d
    s_line  19,53,lin_col,197d

;Boarder Connections
    S_line 5,4,boar_col,199d
    S_line 7,4,boar_col,199d
    S_line 11,4,boar_col,199d
    S_line 13,4,boar_col,199d
    S_line 17,4,boar_col,199d
    S_line 19,4,boar_col,199d

    S_line 5,60,boar_col,182d
    S_line 7,60,boar_col,182d
    S_line 11,60,boar_col,182d
    S_line 13,60,boar_col,182d
    S_line 17,60,boar_col,182d
    S_line 19,60,boar_col,182d





    ;HEADING AND INSTRUCTIONS
    mov al,1
	mov bh, 0
	mov bl, 13h
	mov cx, msg0end - offset msg0
	mov dl, 20
	mov dh, 0
	push cs
	pop es
	mov bp, offset msg0
	mov ah, 13h
	int 10h
	jmp msg0end
	msg0 db "Sudoku by Shamim Babul"
	msg0end:

    mov al,1
	mov bh, 0
	mov bl, 19h
	mov cx, msg1end - offset msg1
	mov dl, 62
	mov dh, 4
	push cs
	pop es
	mov bp, offset msg1
	mov ah, 13h
	int 10h
	jmp msg1end
	msg1 db "Instructions: "
	msg1end:

    mov al,1
	mov bh, 0
	mov bl, 20h
	mov cx, msg2end - offset msg2
	mov dl, 62
	mov dh, 6
	push cs
	pop es
	mov bp, offset msg2
	mov ah, 13h
	int 10h
	jmp msg2end
	msg2 db "Use Arrow Keys"
	msg2end:
   
    mov al,1
	mov bh, 0
	mov bl, 20h
	mov cx, msg3end - offset msg3
	mov dl, 62
	mov dh, 7
	push cs
	pop es
	mov bp, offset msg3
	mov ah, 13h
	int 10h
	jmp msg3end
	msg3 db "To Navigate   "
	msg3end:

    mov al,1
	mov bh, 0
	mov bl, 30h
	mov cx, msg4end - offset msg4
	mov dl, 62
	mov dh, 9
	push cs
	pop es
	mov bp, offset msg4
	mov ah, 13h
	int 10h
	jmp msg4end
	msg4 db "Use Number Keys "
	msg4end:
   
    mov al,1
	mov bh, 0
	mov bl, 30h
	mov cx, msg5end - offset msg5
	mov dl, 62
	mov dh, 10
	push cs
	pop es
	mov bp, offset msg5
	mov ah, 13h
	int 10h
	jmp msg5end
	msg5  db "To Enter/Replace"
	msg5end:

    mov al,1
	mov bh, 0
	mov bl, 30h
	mov cx, msg6end- offset msg6
	mov dl, 63
	mov dh, 10
	push cs
	pop es
	mov bp, offset msg5
	mov ah, 13h
	int 10h
	jmp msg6end
    msg6 db "A Number     "
	msg6end:

    mov  al,1
	mov bh, 0
	mov bl, 30h
	mov cx, msg8end- offset msg8
	mov dl, 62
	mov dh, 12
	push cs
	pop es
	mov bp, offset msg8
	mov ah, 13h
	int 10h
	jmp msg8end
    msg8 db "Press 'r' to reset"
	msg8end:

    mov  al,1
	mov bh, 0
	mov bl, 30h
	mov cx, msg10end- offset msg10
	mov dl, 62
	mov dh, 13
	push cs
	pop es
	mov bp, offset msg10
	mov ah, 13h
	int 10h
	jmp msg10end
    msg10 db "and change color"
	msg10end:

    mov  al,1
	mov bh, 0
	mov bl, 70h
	mov cx, msg11end- offset msg11
	mov dl, 62
	mov dh, 14
	push cs
	pop es
	mov bp, offset msg11
	mov ah, 13h
	int 10h
	jmp msg11end
    msg11 db "Use s for entire"
	msg11end:

    mov  al,1
	mov bh, 0
	mov bl, 70h
	mov cx, msg12end- offset msg12
	mov dl, 62
	mov dh, 15
	push cs
	pop es
	mov bp, offset msg12
	mov ah, 13h
	int 10h
	jmp msg12end
    msg12 db "solutions.     "
	msg12end:

    mov  al,1
	mov bh, 0
	mov bl, 20h
	mov cx, msg13end- offset msg13
	mov dl, 62
	mov dh, 17
	push cs
	pop es
	mov bp, offset msg13
	mov ah, 13h
	int 10h
	jmp msg13end
    msg13 db "Use a to check one"
	msg13end:
     mov  al,1
	mov bh, 0
	mov bl, 20h
	mov cx, msg14end- offset msg14
	mov dl, 62
	mov dh, 18
	push cs
	pop es
	mov bp, offset msg14
	mov ah, 13h
	int 10h
	jmp msg14end
    msg14 db "answer. If "
	msg14end:

     mov  al,1
	mov bh, 0
	mov bl, 20h
	mov cx, msg15end- offset msg15
	mov dl, 62
	mov dh, 19
	push cs
	pop es
	mov bp, offset msg15
	mov ah, 13h
	int 10h
	jmp msg15end
    msg15 db "it is right,It"
	msg15end:

     mov  al,1
	mov bh, 0
	mov bl, 20h
	mov cx, msg16end- offset msg16
	mov dl, 62
	mov dh, 20
	push cs
	pop es
	mov bp, offset msg16
	mov ah, 13h
	int 10h
	jmp msg16end
    msg16 db "will change color"
	msg16end:

    mov  al,1
	mov bh, 0
	mov bl, 30h
	mov cx, msg17end- offset msg17
	mov dl, 62
	mov dh, 22
	push cs
	pop es
	mov bp, offset msg17
	mov ah, 13h
	int 10h
	jmp msg17end
    msg17 db "press b to   "
	msg17end:

    mov  al,1
	mov bh, 0
	mov bl, 30h
	mov cx, msg18end- offset msg18
	mov dl, 62
	mov dh, 23
	push cs
	pop es
	mov bp, offset msg18
	mov ah, 13h
	int 10h
	jmp msg18end
    msg18 db "change the puzzle"
	msg18end:



   mov x_pos,7
   mov y_pos,4



   mov si, OFFSET prob
   mov count1,0h


    WRITE:
       mov al,[si]
    
    cmp al,'$'
    je Cursor
    cmp count1,ah
    je reset_count
    cmp al,48
    je NEXT_ONE

  
    mov ah,02h  
    mov dh,y_pos    
    mov dl,x_pos     
    int 10h
    mov ah,09h
    mov bl,boar_col   
    mov cx,1    
    int 10h 
   inc count1
   inc si
   cmp x_pos, 13
   je add_seven
    add x_pos,6

    jmp WRITE





   Cursor:
   mov x_pos, 7
   mov y_pos, 4
    mov ch, 7
    mov cl, 5
    mov ah, 1 
    int 10h
    mov ah,2
	mov dh,y_pos
	mov dl,x_pos
	mov bh,00h
	int 10h




 
  




    USER:

    mov ah, 00h 
	int 16h 
    cmp al, 27
	je QUIT 


	cmp ah, 48h 
	je UP

	cmp ah, 4Bh
	je LEFT

	cmp ah, 50h
	je DOWN

	cmp ah,4Dh
	je RIGHT

    cmp al,'r'
    je change_col

    cmp al,'1'
    je check_spot
    cmp al,'2'
    je check_spot
    cmp al,'3'
    je check_spot
    cmp al,'4'
    je check_spot
    cmp al,'5'
    je check_spot
    cmp al,'6'
    je check_spot
    cmp al,'7'
    je check_spot
    cmp al,'8'
    je check_spot
    cmp al,'9'
    je check_spot
    cmp al,'s'
    je Print_Sol
     cmp al,'a'
    je check_ans
    cmp al,'b'
    je change_prob

    jmp USER

    Print_Sol:
       mov x_pos,7
   mov y_pos,4  
   mov si, OFFSET sol
   mov count1,0h
   jmp WRITE

    change_col:
    
    add new_back_col,16h
    add new_lin_col,16h
    add new_boar_col,16h
    mov bl, new_back_col
    mov background, bl
    mov bl, new_lin_col
    mov lin_col,    bl
    mov bl, new_boar_col
    mov boar_col,   bl
    jmp BOARD 


    QUIT:
	mov ax, 0600h 
	mov bh, 07h 
	mov cx, 0000h
	mov dx, 184fh 
	int 10h 

	mov ah, 4ch 
	int 21h 

    change_prob:
    mov al, board_count
    cmp al,1
    jne revert_prob
    mov si, offset[prob]
    mov di, offset[prob2]
    mov cx,82
    call COPY1
    mov si, offset[sol]
    mov di, offset[sol2]
    mov cx,82
    call COPY1  
   mov x_pos,7
   mov y_pos,4  
   mov si, OFFSET prob
   mov count1,0h
   add board_count,-1
   jmp WRITE

   revert_prob:
   mov si, offset[prob]
    mov di, offset[prob1]
    mov cx,82
    call COPY1
    mov si, offset[sol]
    mov di, offset[sol1]
    mov cx,82
    call COPY1  
   mov x_pos,7
   mov y_pos,4  
   mov si, OFFSET prob
   mov count1,0h
   add board_count,1
   jmp WRITE
  

   COPY1 PROC
    mov al,[di]
    mov [si],al
    inc si
    inc di
    LOOP COPY1
    ret
    COPY1 ENDP
    ;;;;;  ALL POSITION FOR THE INPUTS:
    ;;;;    7,4    13,4    20,4    26,4 32,4 38,4   44,4  50,4  56,4    
    ;;;;    y changes by 2  
  
  
  
  UP:


    cmp y_pos,4
    je USER
	add y_pos,-2
	
	mov ah,2
	mov dh,y_pos
	mov dl,x_pos
	mov bh,0
	int 10h
    jmp USER 
    
    DOWN:

    cmp y_pos,20
    je USER
	add y_pos,2
	
	mov ah,2
	mov dh,y_pos
	mov dl,x_pos
	mov bh,0
	int 10h
    JMP USER
    
    RIGHT:


    cmp x_pos,56    
    je USER
    
    cmp x_pos, 13
    je go_more
    add x_pos,6

    mov ah,2
	mov dh,y_pos
	mov dl,x_pos
	mov bh,0
	int 10h
    JMP USER
    LEFT:

    cmp x_pos,7
    je USER
    cmp x_pos,20
    je go_less
    add x_pos,-6

    mov ah,2
	mov dh,y_pos
	mov dl,x_pos
	mov bh,0
	int 10h
    JMP USER

    go_more:
    add x_pos,7
    mov ah,2
	mov dh,y_pos
	mov dl,x_pos
	mov bh,0
	int 10h
    JMP USER
     
     go_less:
    add x_pos,-7
    mov ah,2
	mov dh,y_pos
	mov dl,x_pos
	mov bh,0
	int 10h
    JMP USER

     NEXT_ONE:
     mov ah,02h  
    mov dh,y_pos    
    mov dl,x_pos     
    int 10h
    mov ah,09h
    MOV AL,' '
    mov bl,lin_col   
    mov cx,1    
    int 10h 
  inc si
  inc count1
  cmp x_pos,13
  je add_seven
  add x_pos,6
  jmp WRITE
 
  add_seven:
  add x_pos,7
  jmp WRITE
  reset_count:
  mov count1,0h
  mov x_pos,7
  add y_pos,2
  jmp WRITE
  Print_NUMB:
  
  mov dl,al
  mov ah,2
  int  21h
  
  mov ah,3
  mov bh,00
  int 10h

  mov ah,2
  mov dh,y_pos
  mov dl,x_pos
  mov bh,0
  int 10h
  mov si, offset[user_in]
  call reset_index
  call set_si
 call  inc_si
  mov [si],al
  jmp USER


  check_ans:
   ;mov si, offset[sol]
  ;call reset_index
   ;call set_si
  ; call inc_si 
  ; mov bl, [si]
  ; mov si, offset[user_in]
  ; call reset_index
  ; call set_si
  ; call inc_si
  ; mov al,[si]
  ; cmp al,bl
  ; je Print_NUMB_right
    ;mov si, offset[sol]
  ;call reset_index
   ;call set_si
  ; call inc_si 
  ; mov bl, [si]
  ; mov si, offset[user_in]
  ; call reset_index
  ; call set_si
  ; call inc_si
  ; mov al,[si]
  ; cmp al,bl
  ; je Print_NUMB_right
  mov si, offset[user_in]
  ;call reset_count
  call reset_index
  call set_si
  call inc_si
  mov al, [si]
  mov si,0
  mov si, offset[sol]
  call reset_index
  call set_si
  call inc_si
  mov cl,[si]
  cmp cl,al
  jne USER
  ;mov si,0
  ;mov si, offset[sol]
  ;call reset_count
  ;call reset_index
  ;call
  ;mov al,[si]
   mov ah,2
  mov dh,y_pos
  mov dl,x_pos
  mov bh,0
  int 10h
  mov ah,09h
  mov bl,boar_col   
  mov cx,1      
  int 10h   

  mov si,0
  mov si, offset[prob]
  call reset_index
  call set_si
  call inc_si
  mov [si],al
  
   jmp USER
 
  check_spot:
  call reset_index
  call set_si
  mov si, offset prob
  call inc_si
  mov bl,[si]
  cmp bl,48
  je Print_NUMB
    jmp USER
 reset_index proc
         mov count1 , 0h
mov count2 , 0h
mov count3 , 0h
mov count4 , 0h
mov ind_ex , 0h
mov row_num , 0h
mov col_num , 0h
ret
reset_index ENDP 
 inc_si PROC
    cmp ind_ex,0h
    jne llll1
         
    ret
   inc_si ENDP
     llll1:
            inc si

            add ind_ex,-1h
            cmp ind_ex,0h
            jne llll1
  set_si PROC
  call get_col
  call get_row
  call get_count3
  call get_count4
 
  mov bl, count3
  add bl, count4
  mov ind_ex, bl
  ret
  set_si ENDP

 
  
  
  get_col proc
  cmp y_pos,4
   je set_col_1
  cmp y_pos,6
  je set_col_2
  cmp y_pos,8
  je set_col_3
  cmp y_pos,10
  je set_col_4
  cmp y_pos,12
  je set_col_5
  cmp y_pos,14
  je set_col_6
  cmp y_pos,16
  je set_col_7
  cmp y_pos,18
  je set_col_8
  cmp y_pos,20
  je set_col_9
 get_col ENDP
     set_col_1:
    mov col_num, 1h
    ret
    set_col_2:
    mov col_num, 2h
    ret
    set_col_3:
    mov col_num, 3h
   ret
    set_col_4:
    mov col_num, 4h
   ret
    set_col_5:
    mov col_num, 5h
    ret
    set_col_6:
    mov col_num, 6h
    ret
    set_col_7:
    mov col_num, 7h
    ret
    set_col_8:
    mov col_num, 8h
    ret
    set_col_9:
    mov col_num, 9h
    ret
 get_row proc
  cmp x_pos,7
  je set_row_1
  cmp x_pos,13
  je set_row_2
  cmp x_pos,20
  je set_row_3
  cmp x_pos,26
  je set_row_4
  cmp x_pos,32
  je set_row_5
  cmp x_pos,38
  je set_row_6
  cmp x_pos,44
  je set_row_7
  cmp x_pos,50
  je set_row_8
  cmp x_pos,56
  je set_row_9
  get_row ENDP
  set_row_1:
    mov row_num, 1h
    ret
    set_row_2:
    mov row_num,2h   
    ret
    jmp get_count3
    set_row_3:
    mov row_num, 3h
    ret
    set_row_4:
    mov row_num, 4h
    ret
    set_row_5:
    mov row_num, 5h
    ret
    set_row_6:
    mov row_num, 6h
    ret
    set_row_7:
    mov row_num, 7h
    ret
    set_row_8:
    mov row_num, 8h
    ret
    set_row_9:
    mov row_num, 9h
    ret

 
  get_count3 proc
  cmp col_num, 1h
  je set_count3_0
  cmp col_num, 2h
  je set_count3_9
  cmp col_num, 3h
  je set_count3_18
  cmp col_num, 4h
  je set_count3_27
  cmp col_num, 5h
  je set_count3_36
  cmp col_num, 6h
  je set_count3_45
  cmp col_num, 7h
  je set_count3_54
  cmp col_num, 8h
  je set_count3_63
  cmp col_num, 9h
  je set_count3_72
  get_count3 ENDP
      set_count3_0:
    mov count3,0h
    ret
    set_count3_9:
    mov count3,9h
    ret
    set_count3_18:
    mov count3,12h
    ret
    set_count3_27:
    mov count3,1bh
    ret
    set_count3_36:
    mov count3,24h
    ret
    set_count3_45:
    mov count3,2dh
    ret
    set_count3_54:
    mov count3,36h
    ret
    set_count3_63:
    mov count3,3fh
    ret
    set_count3_72:
    mov count3,48h
    ret
  get_count4 proc
  cmp row_num,1h
  je set_count4_0
  cmp row_num,2h
  je set_count4_1
  cmp row_num,3h
  je set_count4_2
  cmp row_num,4h
  je set_count4_3
  cmp row_num,5h
  je set_count4_4
  cmp row_num,6h
  je set_count4_5
  cmp row_num,7h
  je set_count4_6
  cmp row_num,8h
  je set_count4_7
  cmp row_num,9h
  je set_count4_8
  get_count4 ENDP
    set_count4_0:
    mov count4,0h
    ret
    set_count4_1:
    mov count4,1h
    ret
    set_count4_2:
    mov count4,2h
    ret
    set_count4_3:
    mov count4,3h
    ret
    set_count4_4:
    mov count4,4h
    ret
    set_count4_5:
    mov count4,5h
    ret
    set_count4_6:
    mov count4,6h
    ret
    set_count4_7:
    mov count4,7h
    ret
    set_count4_8:
    mov count4,8h
    ret




END START
