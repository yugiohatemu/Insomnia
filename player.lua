Player = Core.class(Sprite)

function Player:init(path)
	self.frame = Bitmap.new(Texture.new("image/print.png"))
	self.speed = 1.0
	self:setPosition(path[1]:getX(),path[1]:getY())
	self:addChild(self.frame)
	
	--print(table.getn(path))
	
end

function Player:startPlay(path)
	self.path = path
	self.currentFrame = 1
	self.maxFrame = table.getn(path) + 1
	self.path[self.maxFrame] = self.path[1]
	
	self:addEventListener(Event.ENTER_FRAME, self.play, self)
	
end

function Player:addScene(spriteList)
	self.spriteList = spriteList
end

function Player:play(event)
	-- need to get a slope?
	local nextFrame = self.currentFrame + 1
	
	-- vertical line
	if self.path[self.currentFrame]:getX() == self.path[nextFrame]:getX() then
		local dy = 1
		if self.path[self.currentFrame]:getY() < self.path[nextFrame]:getY() then
			dy = -1
		end
		self:setPosition(self:getX() , self:getY() + self.speed * dy )
		if ( dy > 0 and self:getY() >= self.path[nextFrame]:getY()) or 
			( dy < 0 and self:getY() <= self.path[nextFrame]:getY()) then
			self:setPosition( self.path[nextFrame]:getX(), self.path[nextFrame]:getY())
			self.currentFrame = nextFrame
		end
		
	else
		local slope = (self.path[nextFrame]:getY() - self.path[self.currentFrame]:getY()) / 
			(self.path[nextFrame]:getX() - self.path[self.currentFrame]:getX())
		local b = self.path[nextFrame]:getY() - self.path[nextFrame]:getX() * slope
		
		local dx = 1
		if self.path[self.currentFrame]:getX() > self.path[nextFrame]:getX() then
			dx = -1
		end
		self:setPosition( self:getX() + self.speed * dx  , slope * (self:getX() + self.speed * dx) + b)	
		-- update
		if (dx > 0 and self:getX() >= self.path[nextFrame]:getX()) or -- x increase
			(dx < 0 and self:getX() <= self.path[nextFrame]:getX()) then 
			self:setPosition( self.path[nextFrame]:getX(), self.path[nextFrame]:getY())
			self.currentFrame = nextFrame
		end
	end
	
	for i = 1 , table.getn(self.spriteList), 1 do  
		if self.spriteList[i]:isInteract(self) then
			self.spriteList[i]:interact(self)
		end
	end
	
	
	--need to calculate speed
	if self.currentFrame >= self.maxFrame or self.speed <= 0 then
		print("pause")
		self:removeEventListener(Event.ENTER_FRAME, self.play, self)
		self.currentFrame = 0
	end 
end

function Player:pause()
	--self:removeChild(self.frame)
	frame:removeEventListener(Event.ENTER_FRAME, self.play, self)
end
