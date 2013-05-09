TurnPoint = Core.class(Sprite)

function TurnPoint:init(px, py, index)
	self.frame = Bitmap.new(Texture.new("image/turnPoint.png"))
	self:setPosition(px-8,py-8)
	
	--self.index = index
	
	self:addChild(self.frame)
	self.isFocus = false
	
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
	
end

function TurnPoint:addLine(from, to)
	self.from = from
	self.to = to
end

-- gideros does not support tapping now, so have to use another way to handle

function TurnPoint:onMouseDown(event)

	if self:hitTestPoint(event.x, event.y) then
		self.isFocus = true

		self.x0 = event.x
		self.y0 = event.y

		event:stopPropagation()
	end
	
end

function TurnPoint:mergeLine()
	print(self.from.from[1][1], self.from.from[1][2], self.to.to[1][1], self.to.to[1][2])
	return Route.new(self.from.from[1][1], self.from.from[1][2], self.to.to[1][1], self.to.to[1][2])
end

function TurnPoint:onMouseMove(event)

	if self.isFocus then
		local dx = event.x - self.x0
		local dy = event.y - self.y0
		
		self:setX(self:getX() + dx)
		self:setY(self:getY() + dy)

		self.x0 = event.x
		self.y0 = event.y

		self.from:moveFromPoint(dx,dy)
		self.to:moveToPoint(dx,dy)
		
		event:stopPropagation()
	end
	
end

function TurnPoint:onMouseUp( event)

	if self.isFocus then
		self.isFocus = false
		event:stopPropagation()
	end
	
end