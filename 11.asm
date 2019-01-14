.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   3
	b   db   7
	c1  db   2

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(17ca^2-b^2c)/(2b^2 - a)=2
;y=(14-8(b+a))/(4x+cb)=-3

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov al, 2	;al=2
	mul b		;ax=2*b=14
	mul b		;ax=2*b^2=98
	sub al,a	;al=2b^2-a=95
	mov bl,al	;bl=2b^2-a=95
	mov al,a	;al=a=3
	mul al		;ax=a^2=9
	mul c1		;ax=c*a^2=18
	imul ax,ax,17	;ax=17*c*a^2=306
	mov cx,ax	;cx=17*c*a^2=306
	mov al,b	;al=b=7
	mul al		;ax=b^2=49
	mul c1		;ax=b^2*c=98
	neg ax		;ax=-b^2*c=98
	add ax,cx	;ax=17ca^2-b^2c=208
	div bl		;al=(17ca^2-b^2c)/(2b^2 - a)=2
	mov cl,al	;cl=x=2
	mov x,cl	;x=2
;Вычисляем y
	mov al,4	;al=4
	mul cl		;ax=4*x=8
	mov bl,al	;bl=4*x=8
	mov al,c1	;al=c=2
	mul b		;ax=cb=14
	add bl,al	;bl=4x+cb=22
	mov al,b	;al=b=7
	add al,a	;al=b+a=10
	cbw		
	imul ax,ax,-8;ax=-8(b+a)=-80
	add ax,14	;ax=14-8(b+a)=-66
	idiv bl		;al=(14-8(b+a))/(4x+cb)=-3
	mov y,al	;y=-3
exit 
end	lab1 