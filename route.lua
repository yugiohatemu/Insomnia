Route = Core.class(Shape)

function Route:init(x1,y1,x2,y2)
	self.from = {}
	self.to = {}
	self.from[1], self.from[2] = x1, y1
	self.to[1], self.to[2] = x2, y2
	
	self:drawSelf()
	
end

function Route:drawSelf()
	self:setLineStyle(3, 0x66CC00)
	self:beginPath()
	self:moveTo(self.from[1], self.from[2])
	self:lineTo(self.to[1], self.to[2])
	self:endPath()
end

function Route:moveFromPoint(dx, dy)
	self.to[1] = self.to[1] + dx
	self.to[2] = self.to[2] + dy
	self:clear()
	self:drawSelf()
end

function Route:moveToPoint(dx, dy)
	self.from[1] = self.from[1] + dx
	self.from[2] = self.from[2] + dy
	self:clear()
	self:drawSelf()
end