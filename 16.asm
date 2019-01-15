.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   6
	b   db   -4
	c1  db   6

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(c^2+8(a-b))/(bc+21)=-38
;y=((b-a)^2+x^2)/(18x+c)=-2

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=6
	mov bh,b	;bh=b=-4
	mov cl,c1	;cl=c=2
	mov al,bh	;al=b=6
	imul cl		;ax=bc=-24
	add ax,21	;ax=bc+21=-3
	mov ch,al	;ch=bc+21=-3
	mov al,cl	;al=c=6
	mul al		;ax=c^2=36
	mov si,ax	;si=c^2=36
	mov al,bl	;al=a=6
	sub al,bh	;al=(a-b)=10
	cbw
	imul ax,8	;ax=8(a-b)=80
	add ax,si	;ax=c^2+8(a-b)=116
	idiv ch		;al=(c^2+8(a-b))/(bc+21)=-38
	mov ch,al	;ch=x=-38
	mov x,al	;x=-38
;Вычисляем y
	cbw
	imul ax,18	;ax=18x=-684
	mov si,ax	;si=18x=-684
	mov al,cl	;al=c=6
	cbw
	add si,ax	;si=18x+c
	mov al,bh	;al=b=-4
	sub	al,bl	;al=(b-a)=-10
	imul al		;ax=(b-a)^2=100
	mov di,ax	;di=(b-a)^2=100
	mov al,ch	;al=x=-38
	imul al		;ax=x^2=1444
	add ax,di	;ax=(b-a)^2+x^2
	cwd	
	idiv si		;ax=((b-a)^2+x^2)/(18x+c)=-2
	mov y,al	;y=-2

exit 
end	lab1 