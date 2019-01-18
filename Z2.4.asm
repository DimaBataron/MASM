.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   4
	b   dw   7

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   dw    ?

;		/b^2		b*a+2<1
;	y=	|5a+b^2		b*a+2=1
;		\30/A^2*b	b*a+2>1

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,b	;ax=b=7
	mul a		;ax=ba=28
	add ax,2	;ax=ba+2=30
	cmp ax,1	
	jl m1
	je m2
	
	;b*a+2>1
	mov ax,a	;ax=a=4
	mul	ax		;ax=a^2=16
	mov si,ax	;si=a^2=16
	mov ax,30
	cwd
	div si		;ax=30/a^2=1
	mul b		;ax=30/a^2*b=7
	jmp m3
m1:	mov ax,b	;ax=b=7
	mul ax		;ax=b^2=49
	jmp m3
m2:	mov ax,5	;ax=5
	mul a		;ax=5a=20
	mov si,ax	;si=5a=20
	mov ax,b	;ax=b=7
	mul ax		;ax=b^2=49
	add ax,si	;ax=5a+b^2=69
m3: mov y,ax	
exit
end	lab2 