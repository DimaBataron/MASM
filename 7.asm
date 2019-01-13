.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   6
	b   db   -2
	c1  db   3

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(4ab^2-3ac)/(2c+ab)=-7
;y=(21x-ac^2)/(x+12(x-b))=3

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov ch,a	;ch=a=6
	mov bh,b	;bh=b=-2
	mov bl,c1	;bl=c=3
	mov cl,bl	;cl=c=3
	add cl,cl   ;cl=2c=6
	mov al,ch	;al=a=6
	imul bh		;ax=a*b=-12
	add cl,al	;cl=2c+ab=-6
	mov al,4	;al=4
	mul ch		;ax=4*a=24
	imul bh		;ax=4*a*b=-48
	imul bh		;ax=4*a*b^2=96
	mov si,ax	;si=4*a*b^2=96
	mov al,-3	;al=-3
	imul ch		;ax=-3*a=-18
	imul bl		;ax=-3*a*c=-54
	add ax,si	;ax=4*a*b^2-3*a*c=42
	idiv cl		;al=(7ab-4bc)/(a^2-b(a+1))=-7
	mov x,al	;x=-7
	mov cl,al	;cl=x
;Вычисляем y
	sub al,bh	;al=(x-b)=-5
	cbw			;ax=al
	imul ax,12	;ax=12(x-b)=-60
	add al,cl	;ax=x+12(x-b)=-67
	mov si,ax	;si=x+12(x-b)=-67
	mov al,21	;al=21
	imul cl		;ax=21*x=-147
	mov di,ax	;di=21*x=-147
	mov al,bl	;al=c=3
	mul bl		;ax=c^2=9
	mul ch		;ax=a*c^2=54
	neg ax		;ax=-a*c^2=-54
	add ax,di	;ax=21x-ac^2=-201
	cwd
	idiv si		;ax=(21x-ac^2)/(x+12(x-b))=3
	mov y,al	;y=3
exit 
end	lab1 