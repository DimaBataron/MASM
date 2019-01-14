.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   -12
	b   db   9
	c1  db   0

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(ab-2(c+a))/(10a-c+118)=42
;y=((x+c^2)-3333)/(12a-b)=21

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov bl,a	;bl=a=-12
	mov bh,b	;bh=b=9
	mov cl,c1	;cl=c=0
	mov al,10	;al=10
	imul bl		;ax=10*a=-120
	sub al,cl	;al=(10*a-c)=-120
	cbw
	add ax,118	;ax=(10*a-c)+118=-2
	mov ch,al	;ch=(10*a-c)+118=-2
	mov al,bl	;al=a=-12
	imul bh		;ax=a*b=-108
	mov si,ax	;si=a*b=-108
	mov al,cl	;al=c=0
	add al,bl	;al=c+a=-12
	cbw
	imul ax,-2	;ax=-2(c+a)=24
	add ax,si	;ax=ab-2(c+a)=-84
	idiv ch		;al=(ab-2(c+a))/(10a-c+118)=42
	mov ch,al	;ch=x=42
	mov x,al	;x=42
;Вычисляем y
	mov al,12	;al=12
	imul bl		;ax=12a=-144
	xchg ax,bx
	mov al,ah	;al=b=9
	neg al		;al=-b=-9
	cbw
	add bx,ax	;ax=12a-b=-153
	mov al,ch	;al=x=42
	cbw
	sub ax,3333	;ax=(x+c^2)-3333=-3291
	cwd
	idiv bx		;ax=((x+c^2)-3333)/(12a-b)=21
	mov y,al	;y=21
exit 
end	lab1 