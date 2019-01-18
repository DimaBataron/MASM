.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   dw   7
	b   dw   4

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	y   dw    ?

;		/(ab),		a*b^2<0
;	y=	|(b-a)^2	a*b^2=0
;		\10	,		a*b^2>0

.CODE   ;Директива описания начала сегмента кода. 
lab2:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
	mov ax,b	;ax=b=4
	mul ax		;ax=b^2=16
	mul a		;ax=ab^2=112
	cmp ax,0
	jl	m1		;a*b^2<0
	je	m2		;a*b^2=0
	mov ax,10	;ax=10
	jmp m3
m1:	mov ax,a	;ax=a=7
	mul b		;ax=ab=28
	fabs		;ax=|ab|=28
	jmp m3
m2: mov ax,b	;ax=b=4
	sub ax,a	;ax=b-a=-3
	imul ax		;ax=(b-a)^2=9
m3: mov y,ax	
exit
end	lab2 