player={
	x=0,
	y=0,
	s=1,

	update=function(_ENV)
		x+=1
	end,

	draw=function(_ENV)
		spr(s,x,y)
	end,
}
