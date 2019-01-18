.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   5
	b   dw   3

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   dw    ?

;		/a/b^2		ab<0
;	y=	|5a+b^2		ab=0
;		\30/A^2*b	ab>0

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,b	;ax=b=3
	mul a		;ax=ba=15
	cmp ax,0
	jl m1
	je m2
	;ab>0
	mov ax,a	;ax=a=5
	mul ax		;dx:ax=a^2=25
	mov si,ax	;si=a^2=25
	mov ax,30	;ax=30
	cwd
	div si		;ax=30/a^2=1
	mul b		;ax=30/a^2*b=3
	jmp m3
m1:	mov ax,a	;ax=a=5
	cwd
	div	b		;ax=a/b=1
	cwd
	div b		;ax=a/b^2=0
	jmp m3
m2: mov ax,5	;ax=5
	mul a		;ax=5a
	mov si,ax	;si=5a=25
	mov ax,b	;ax=b=3
	mul ax		;ax=b^2=9
	add ax,si	;ax=5a+b^2=34
m3 : mov y,ax	
exit
end	lab2 