.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   -1
	b   db   -2
	c1  db   32

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   dw    ?
	y   db    ?

;x=(2c^2-bc)/(8ab-c)=-132
;y=(3-x^2-c)/(ba-2x)+12=-53

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov cl,c1	;cl=32=c1
	mov al,8	;al=8
	imul a		;ax=8a=-8
	imul b		;ax=8ab=16
	sub al,c1	;al=8ab-c=-16
	cbw
	mov bx,ax	;bx=-16
	mov al,cl	;al=c1=32
	mul al		;ax=c^2=1024
	add ax,ax	;ax=2c^2=2048
	mov si,ax	;si=2c^2=2048
	mov al,b	;al=b=-2
	imul cl		;ax=bc=-64
	neg ax		;ax=-bc=64
	add ax,si	;ax=2c^2-bc=2112
	cwd
	idiv bx		;ax=(2c^2-bc)/(8ab-c)=-132
	mov x,ax	;x=-132
	mov di,ax	;di=x=-132
;Вычисляем y
	imul ax		;dx:ax=x^2=17424
	mov si,ax	;si=x^2=17424
	mov al,b	;al=b=-2
	imul a		;ax=ba=2
	mov bx,ax	;bx=2
	imul ax,di,-2;ax=-2x=264
	add bx,ax	;bx=ba-2x=266
	mov ax,si	;ax=x^2
	neg ax		;ax=-x^2=-17424
	add ax,3	;ax=3-x^2=-17421
	xchg ax,cx	;ax=c1=32
	cbw
	neg ax
	add ax,cx	;ax=3-x^2-c=-17453
	cwd
	idiv bx		;ax=(3-x^2-c)/(ba-2x)=-65
	add ax,12	;ax=(3-x^2-c)/(ba-2x)+12=-53
	mov y,al    ;y=-53
exit 
end	lab1 