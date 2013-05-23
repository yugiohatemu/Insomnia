Sleep = Core.class(Sprite)

function Sleep:init(x, y)
	self.frame = Bitmap.new(Texture.new("image/z.png"))
	self.slow = 0.3
	self:setPosition(x, y)
	self.hasInteract = false
	-- for impulse, save for later
	--[[self.radius = 20
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
	self:addChild(self.circle) --]]
	
	self:addChild(self.frame)
	
end

function Sleep:isInZone(x , y )
	return (x - self:getX()) * (x - self:getX()) + (y - self:getY()) * (y - self:getY()) < self.radius * self.radius
end

-- if the sprite should interact with the player
-- use half width or hieight?
function Sleep:isInteract(player)
	local x, y, width, height = player:getBounds(stage)
	return not self.hasInteract and 
		(self.frame:hitTestPoint(x,y) or self.frame:hitTestPoint(x+width,y) or 
		self.frame:hitTestPoint(x,y+height) or self.frame:hitTestPoint(x,y) )
end

-- if so , then what to do 
function Sleep:interact(player)
	-- can we expand the library?
	player.speed = player.speed - self.slow
	self.hasInteract = true
	stage:removeChild(self)
	-- need to remove the impact
end
