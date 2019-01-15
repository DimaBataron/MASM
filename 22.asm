.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   -3
	b   db   2
	c1  db   5

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(bc^2+13(a-c))/(ac+14)=54
;y=((x-2)c-ba)/(3b-cx)=-1

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=-3
	mov bh,b	;bh=b=2
	mov cl,c1	;cl=c=5
	mov al,bl	;al=a=-3
	imul cl		;ax=ac=-15
	add ax,14	;ax=ac+14=-1
	mov si,ax	;si=ac+14=-1
	mov al,bl	;al=a=-3
	sub al,cl	;al=(a-c)=-8
	cbw
	imul ax,13	;ax=13(a-c)=-104
	mov di,ax	;di=13(a-c)=-104
	mov al,bh	;al=b=2
	mul cl		;ax=bc=10
	mul cl		;ax=bc^2=50
	add ax,di	;ax=bc^2+13(a-c)=-54
	cwd
	idiv si		;ax=(bc^2+13(a-c))/(ac+14)=54
	mov ch,al	;ch=x=54
	mov x,ch	;x=54
;Вычисляем y
	imul cl		;ax=cx=270
	mov si,ax	;si=cx=270
	mov al,3	;al=3
	mul bh		;ax=3b=6
	sub	ax,si	;ax=3b-cx=264
	mov si,ax	;si=3b-cx=264
	mov al,bh	;al=b=2
	imul bl		;ax=ba=-6
	mov di,ax	;ax=ba=-6
	mov al,ch	;al=x=54
	sub al,2	;al=x-2=52
	mul cl		;ax=(x-2)c=260
	sub ax,di	;ax=(x-2)c-ba=266
	cwd
	idiv si		;ax=((x-2)c-ba)/(3b-cx)=-1
	mov y,al	;y=-1
exit 
end	lab1 