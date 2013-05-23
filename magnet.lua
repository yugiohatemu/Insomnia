Magnet = Core.class(Shape)

function Magnet:init(x, y)
	
	self.attract = 0.3 -- + is attract, - is pulse
	self.x = x
	self.y = y
	self.hasInteract = false
	self.radius = 20
	
	self:setFillStyle(Shape.SOLID,0XCCFFCC, 0.5)
	self:setLineStyle(1, 0XCCFFCC)
	self:beginPath()
	self:moveTo(x+self.radius , y)
	for i = 1, 21, 1 do
		self:lineTo(x+math.cos(i * 18) * self.radius,  y+ math.sin(i * 18 ) * self.radius)
	end
	self:closePath()
	self:endPath() 
	
end

-- if the sprite should interact with the player
-- use half width or hieight?
function Magnet:isInteract(player)
	local x, y = player:getX(), player:getY()
	return  (self.x - x)* (self.x - x) + (self.y - y)*(self.y - y) <= self.radius * self.radius
end

-- if so , then what to do 
function Magnet:interact(player)
	
end

Zone = Core.class(Shape)

function Zone:init(x, y)
	
	self.attract = -0.3 -- + is attract, - is pulse
	self.x = x
	self.y = y
	self.hasInteract = false
	self.status = 0 -- before, +,current,  - , after -  0, 1, 2, 3, 
	-- use enum later
	self.radius = 20
	
	self:setFillStyle(Shape.SOLID,0X8888D0, 1)
	self:setLineStyle(1, 0X8888CC)
	self:beginPath()
	self:moveTo(x+self.radius , y)
	for i = 1, 21, 1 do
		self:lineTo(x+math.cos(i * 18) * self.radius,  y+ math.sin(i * 18 ) * self.radius)
	end
	self:closePath()
	self:endPath() 
	
end

-- if the sprite should interact with the player
-- use half width or hieight?
function Zone:isInteract(player)
	
	local x, y, width, height = player:getBounds(stage)
	x = x + width/2
	y = y + height/2
	local status = (self.x - x)* (self.x - x) + (self.y - y)*(self.y - y) <= self.radius * self.radius
	
	if status and self.status == 0 then
		self.status = 1
	end

	if not status and self.status == 2 then
		self.status = 3
		return true
	end
	
	return status 
end

function Zone:interact(player)
	if self.status == 1 then
		player.speed = player.speed + self.attract 
		self.status = 2
	elseif self.status == 3 then
		player.speed = player.speed - self.attract 
		self.status = 4
	end
	
end