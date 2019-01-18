.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   11
	b   dw   2

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   dw    ?

;		/a+b ,	a/b<0
;	x=	|a*b^2,	a/b=0
;		\10+b,	a/b>0

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,a	;ax=a=11
	cwd			;dx:ax=a=11
	div b		;ax=2
	cmp ax,0	;сравнение
	jl m1		;m1 a/b<0
	je m2		;m2 a/b=0
	jmp m3		;m3 a/b>0
m1: mov ax,a	;ax=a=11 
	add ax,b	;ax=a+b=13
	jmp m4
m2:	mov ax,b	;ax=b=2
	mul ax		;dx:ax=b^2=4
	mul a		;dx:ax=ab^2=44
	jmp m4
m3: mov ax,b	;ax=b=2
	add ax,10	;ax=b+10=12
m4: mov x,ax	
exit
end	lab2 