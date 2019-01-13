.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   -11
	b   db   0
	c1  db   -9

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(a^2+bc^2)/(-2a+12bc)=5
;y=(-4x+a^2-1)/(2x+bc)=10

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov al,-2	;al=-2
	imul a		;ax=-2*a=22
	mov bl,al	;bl=-2*a=22
	mov al,a	;al=a=-11
	imul al		;ax=a^2=121
	mov cx,ax	;cx=a^2=121
	div bl		;al= (a^2+bc^2)/(-2a+12bc)=5
	mov x,al	;x=5
;Вычисляем y
	add al,al	;al=2x=10
	mov bl,al	;bl=2x=10
	mov al,-4	;al=-4
	imul x		;ax=-4*x=-20
	dec cx		;cx=a^2-1=120
	add al,cl	;al=-4x+a^2-1=100
	cbw
	idiv bl		;al=(-4x+a^2-1)/(2x+bc)=10
	mov y,al	;y=10
exit 
end	lab1 