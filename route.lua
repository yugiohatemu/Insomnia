Route = Core.class(Shape)

function Route:init(x1,y1,x2,y2)
	self.from = {}
	self.to = {}
	self.from[1], self.from[2] = x1, y1
	self.to[1], self.to[2] = x2, y2
	
	self:setLineStyle(3, 0x66CC00)
	self:beginPath()
	self:moveTo(x1,x2)
	self:lineTo(y1,y1)
	self:endPath()
	
end

function Route:moveFromPoint(x1, y1)

end

function Route:moveToPoint(x2, y2)

end