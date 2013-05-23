Sleep = Core.class(Sprite)

function Sleep:init(x, y)
	self.frame = Bitmap.new(Texture.new("image/z.png"))
	self.slow = 0.5
	self.radius = 20
	self:setPosition(x, y)
	
	self.circle = Shape.new() -- position is related to the sprite it self
	self.circle:setFillStyle(Shape.SOLID,0XCCFFCC, 0.5)
	self.circle:setLineStyle(1, 0XCCFFCC)
	self.circle:beginPath()
	self.circle:moveTo(0 , 0)
	for i = 1, 20, 1 do
		self.circle:lineTo(math.cos(i * 18) * self.radius,  math.sin(i * 18 ) * self.radius)
	end
	self.circle:closePath()
	self.circle:endPath() 
	self:addChild(self.circle)
	
	self:addChild(self.frame)
	
end

function Sleep:isInZone(x , y )
	return (x - self:getX()) * (x - self:getX()) + (y - self:getY()) * (y - self:getY()) < self.radius * self.radius
end

function Sleep:isOverlap(x, y)
	return self.frame:hitTestPoint(x, y)
end
