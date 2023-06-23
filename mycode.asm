include 'emu8086.inc'
org 100h

.data 

player_nums db 25 dup(?)  
player_times db 25 dup(?)
len db 25  

msg1 db 'Enter each of 25 players number and time in seconds:$' 
msg2 db 'Player number: $'
msg3 db 'Player time: $'
msg4 db '---------------------------$'
msg5 db 'Players info after arranging ascendingly:$'
msg6 db 'number: $'
msg7 db 'time: $'
msg8 db '       $'
    
.code

main proc
    mov ax,@data
    mov ds,ax

;;;;;;;;;;;;;;;; input stage ;;;;;;;;;;;;;;;;;;;;;;;;;
   
    mov ah,09h 
    lea dx,msg1
    int 21h          
    
    mov ah,02h 
    mov dl,0ah ;new line
    int 21h
    mov dl,0dh ;removes space
    int 21h    
    
    mov si,0
    mov di,0
    
    input:
        mov ah,09h 
        lea dx,msg2
        int 21h
        
        call SCAN_NUM
        mov player_nums[si],cl   
           
        mov ah,02h
        mov dl,0ah ;new line
        int 21h
        mov dl,0dh ;removes space
        int 21h
        
        mov ah,09h 
        lea dx,msg3
        int 21h
        
        call SCAN_NUM
        mov player_times[di],cl
           
        mov ah,02h
        mov dl,0ah ;new line
        int 21h
        mov dl,0dh ;removes space
        int 21h  
        
        mov ah,09h 
        lea dx,msg4
        int 21h 
        
        mov ah,02h
        mov dl,0ah ;new line
        int 21h
        mov dl,0dh ;removes space
        int 21h
        
        inc si
        inc di
        dec len
        cmp len,0
        jne input 
        
;;;;;;;;;;;;;;;; sorting stage ;;;;;;;;;;;;;;;;;;;;;;; 
    
    mov cx,24  ;array size - 1
    mov si,0
    
    bubble_sort:
        cmp cx,si
        jz next
        mov al,player_times[si]
        mov bl,player_times[si+1] 
        mov ah,player_nums[si]
        mov bh,player_nums[si+1]
        cmp al,bl
        ja exchange
        inc si
        jmp bubble_sort
        
        exchange:
            mov player_times[si],bl
            mov player_times[si+1],al
            mov player_nums[si],bh
            mov player_nums[si+1],ah
            inc si
            jmp bubble_sort
           
        next:
            mov si,0
            dec cx
            cmp cx,0
            jnz bubble_sort
        
;;;;;;;;;;;;;;;; output stage ;;;;;;;;;;;;;;;;;;;;;;;;
        
    mov ah,09h 
    lea dx,msg5
    int 21h
    
    mov ah,02h 
    mov dl,0ah ;new line
    int 21h
    mov dl,0dh ;removes space
    int 21h 
    
    mov si,0
    mov di,0    
    
    mov [len],25
        
    output: 
        mov ah,09h 
        lea dx,msg6
        int 21h
              
        mov ah,0
        mov al,player_nums[si]
        call PRINT_NUM
        
        mov ah,09h 
        lea dx,msg8
        int 21h 
        
        mov ah,09h 
        lea dx,msg7
        int 21h
                 
        mov ah,0
        mov al,player_times[di]
        call PRINT_NUM  
        
        mov ah,02h 
        mov dl,0ah ;new line
        int 21h
        mov dl,0dh ;removes space
        int 21h   
        
        inc si
        inc di
        dec len
        cmp len,0
        jne output
           
        
    main endp 

DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_NUM
DEFINE_SCAN_NUM 

end main

ret