.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   3
	b   dw   2

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   dw    ?

;		/(ab)^2 ,	a+|b|<0
;	y=	|5a+b^2,	a+|b|=0
;		\30/a^2*b,	a+|b|>0

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,b	;ax=b=2
	fabs		;ax=|b|=2
	add ax,a	;ax=a+|b|=5
	cmp ax,0
	jl m1		;a+|b|<0
	je m2		;a+|b|=0
	
	;a+|b|>0
	
	mov ax,a	;ax=a=3
	mul ax		;dx:ax=a^2=9
	mov si,ax	;si=a^2=9
	mov ax,30	;ax=30
	cwd
	div si		;ax=30/a^2=3
	mul b		;ax=30/a^2*b=6
	jmp m3
m1: mov ax,a	;ax=a=3
	mul b		;ax=ab=6
	mul ax		;ax=(a*b)^2=36
	jmp m3
m2: mov ax,b	;ax=b=2
	mul ax		;ax=b^2=4
	mov si,ax	;si=b^2=4
	mov ax,5	;ax=5
	mul a		;ax=5a=15
	add ax,si	;ax=5a+b^2=19
m3: mov y,ax	
exit
end	lab2 