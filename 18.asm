.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   6
	b   db   4
	c1  db   11

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(c^2-4b)/(7(a+b)-24b)=-4
;y=(16(a-c)+bx)/(7x+7(b-1))=13

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=21
	mov bh,b	;bh=b=2
	mov cl,c1	;cl=c=35
	mov al,-24	;al=-24
	imul bh		;ax=-24b=-96
	mov ch,al	;ch=-24b=-96
	mov al,bl	;al=a=6
	add al,bh	;al=a+b=10
	cbw
	imul ax,7	;ax=7(a+b)=70
	add ch,al	;si=7(a+b)-24b=-26
	mov al,-4	;al=-4
	imul bh		;ax=-4b=-16
	mov di,ax	;di=-4b=-16
	mov al,cl	;al=c=11
	mul cl		;ax=c^2=121
	add ax,di	;ax=c^2-4b=105
	idiv ch		;al=(c^2-4b)/(7(a+b)-24b)=-4
	mov ch,al	;ch=x=-4
	mov x,al	;x=-4
;Вычисляем y
	mov al,bh	;al=b=4
	dec al		;al=b-1=3
	cbw
	imul ax,7	;ax=7(b-1)=21
	mov si,ax	;si=7(b-1)=21
	mov al,7	;al=7
	imul ch		;ax=7x=-28
	add si,ax	;si=7x+7(b-1)=-7
	mov al,bh	;al=b=4
	imul ch		;ax=x*b=-16
	mov di,ax	;di=x*b=-16
	mov al,bl	;al=a=6
	sub al,cl	;al=(a-c)=-5
	cbw
	imul ax,16	;ax=16(a-c)=-80
	add ax,di	;ax=16(a-c)+xb=-96
	cwd
	idiv si		;ax=(16(a-c)+bx)/(7x+7(b-1))=13
	mov y,al	;y=13
exit 
end	lab1 