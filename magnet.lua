Magnet = Core.class(Shape)

function Magnet:init(x, y)
	
	self.attract = 0.3 -- + is attract, - is pulse
	self.x = x
	self.y = y
	self.hasInteract = false
	self.radius = 30
	
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

local function disToCenter(x1,y1,x2,y2, rx, ry)
	local divid = math.sqrt((x1 - x2)*(x1 - x2) + (y1 - y2)* (y1- y2))
	local det = math.abs((x2-x1)(y1-ry) - (x1-rx)(y2-y1))
	return det/divid
end

local function lineIntersectCircle(x1,y1,x2, y2,rx, ry , r)
	local dx = x2- x1
	local dy = y2- y1
	local dr2 = dx * dx + dy * dy
	local D = (x1 - rx )* (y2 - ry) - (x2 - rx)*( y1 - ry)

end

-- if the sprite should interact with the player
-- use half width or hieight?
function Magnet:isInteract(player)
	local x, y, width, height = player:getBounds(stage)
	x = x + width/2
	y = y + height/2
	local status = (self.x - x)* (self.x - x) + (self.y - y)*(self.y - y) <= self.radius * self.radius
	
	if status and  player.currentFrame < player.maxFrame then
		local x1, y1 , x2 , y2 = player:getCurrentPath()
		local dr = disToCenter(x1,y1,x2,y2, self.x, self.y)
		if dr < self.radius then -- has two intersection
			local inCircle = math.sqrt(self.radius *self.radius - dr * dr)
			local dis =  math.sqrt((x2 - x1) * (x2 - x1) + (y1 - y2) * (y1 - y2))
			local dsin, dcos = (x2-x1) / dis , (y2-y1) / dis
			local px, py = x + dcos *  inCircle , y + dsin* inCircle -- the other intersection 
			-- create new route
			
		end
	end
	
	return status
end

-- if so , then what to do 
function Magnet:interact(player)
	-- draw v path for testing first
	
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
	end
	
end