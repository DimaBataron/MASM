.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   4
	b   db   3
	c1  db   13

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=((c-5)^2+ca)/(b+21(a-b)^2)=4
;y=(ba^2-c(21+x))/(114(x+a)-920)=34

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=4
	mov bh,b	;bh=b=3
	mov cl,c1	;cl=c=13
	mov al,bl	;al=a=4
	sub	al,bh	;al=a-c=1
	cbw
	imul ax,21	;ax=21(a-b)^2=21
	add al,bh	;al=b+21(a-b)^2=24
	cbw
	mov si,ax	;si=b+21(a-b)^2=24
	mov al,cl	;al=c=13
	mul bl		;ax=ca=52
	mov di,ax	;di=ca=52
	mov al,cl	;al=c=13
	sub al,5	;al=c-5=8
	mul al		;ax=(c-5)^2=64
	add ax,di	;ax=(c-5)^2+ca=116
	cwd
	idiv si		;ax=((c-5)^2+ca)/(b+21(a-b)^2)=4
	mov ch,al	;ch=x=4
	mov x,ch	;x=4
;Вычисляем y
	add al,bl	;al=x+a=8
	cbw
	imul ax,114	;ax=114(x+a)=912
	sub ax,920	;ax=114(x+a)-920=-8
	mov si,ax	;si=114(x+a)-920=-8
	mov al,ch	;al=x=4
	add al,21	;ax=21+x=25
	cbw
	mul cl		;ax=c(21+x)=325
	mov di,ax	;di=c(21+x)=325
	mov al,bh	;al=b=3
	mul bl		;ax=ba=12
	mul bl		;ax=ba^2=48
	sub ax,di	;ax=ba^2-c(21+x)=-277
	cwd
	idiv si		;ax=(ba^2-c(21+x))/(114(x+a)-920)=34
	mov y,al	;y=34
exit 
end	lab1 