.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   -51
	b   db   26
	c1  db   36

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(111(a-c)+b^2+2)/(cb+21a)=66
;y=(x^2-bc)/(2(b+x)-a)=14

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=-51
	mov bh,b	;bh=b=26
	mov cl,c1	;cl=c=36
	mov al,bh	;bh=b=26
	mul cl		;ax=bc=936
	mov si,ax	;si=bc=936
	mov al,21	;al=21
	imul bl		;ax=21a=-1071
	add si,ax	;si=cb+21a=-135
	mov al,bh	;al=b=26
	mul bh		;ax=b^2=676
	add ax,2	;ax=b^2+2=678
	mov di,ax	;di=b^2+2=678
	mov al,bl	;al=a=-51
	sub al,cl	;al=a-c=-87
	cbw
	imul ax,111	;ax=111(a-c)=-9657
	add ax,di	;ax=111(a-c)+b^2+2=-8979
	cwd
	idiv si		;ax=(111(a-c)+b^2+2)/(cb+21a)=66
	mov ch,al	;ch=x=66
	mov x,al	;x=66

;Вычисляем y
	add al,bh	;al=b+x=92
	cbw
	imul ax,2	;ax=2(b+x)=184
	mov si,ax	;si=2(b+x)=184
	mov al,bl	;al=a=-51
	cbw
	sub si,ax	;si=2(b+x)-a=235
	mov al,bh	;al=b=26
	mul cl		;ax=bc=936
	mov di,ax	;di=bc=936
	mov al,ch	;al=x=66
	mul ch		;ax=x^2=4356
	sub ax,di	;ax=x^2-bc=3420
	cwd
	div si		;ax=(x^2-bc)/(2(b+x)-a)=14
	mov y,al	;y=14
exit 
end	lab1 