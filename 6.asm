.XLIST
	include \masm32\include\masm32rt.inc
	    ;	Обеспечивает подключение всех необходимых функций 
	    ;	и макросов.	

.LIST ; Директивы .XLIST и .LIST обеспечивают правильное
      ; формирование листинга программы
.DATA ; Директива описания начала раздела инициализированных данных. 
	a   db   2
	b   db   7
	c1  db   -3

.DATA? ;Директива описания начала раздела неинициализированных данных. 
	x   db    ?
	y   db    ?

;x=(7ab-4bc)/(a^2-b(a+1))=-10
;y=(4x-16(a-c))/(-50-bx)=-6

.CODE   ;Директива описания начала сегмента кода. 
lab1:   ;Это метка, в нашей программе определяет точку
			  ;входа - стартовый адрес
         
;Вычисляем x
	mov al,a	;al=a=2
	mov ch,al	;ch=a=2
	mov bh,b	;bh=b=7
	mul al		;ax=a*a=4
	mov cl,al	;cl=a*a=4
	mov al,ch	;al=a=2
	inc al		;al=a+1=3
	mul bh		;ax=b(a+1)=21
	sub cl,al	;cl=a*a-b(a+1)=-17
	mov al,7	;al=7
	mul ch		;ax=7*a=14
	mul bh		;ax=7*a*b=98
	mov bl,al	;bl=7*a*b=98
	mov al,4	;al=4
	mul	bh		;ax=4*b=28
	imul c1		;ax=4*b*c1=-84
	mov bp,ax   ;bp=4*b*c1=-84
	mov al,bl	;al=7*a*b=98
	cbw
	sub ax,bp	;ax=7ab-4bc=182
	idiv cl		;al=(7ab-4bc)/(a^2-b(a+1))=-10
	mov x,al	;x=-10
	mov bl,al   ;bl=x=-10

;Вычисляем y
	mov al,bh	;al=b=7
	neg al		;al=-b=-7
	imul bl		;ax=-b*x=70
	add ax,-50	;ax=-50-b*x=20
	mov bp,ax	;bp=-50-b*x=20
	mov al,4	;al=4
	imul bl		;ax=4*x=-40
	mov si,ax	;si=4*x=-40	
	sub ch,c1	;ch=a-c=5
	mov al,-16	;al=-16
	imul ch		;ax=-16(a-c)=-80
	add ax,si	;ax=4x-16(a-c)=-120
	cwd
	idiv bp		;al=(4x-16(a-c))/(-50-bx)=-6
exit 
end	lab1 