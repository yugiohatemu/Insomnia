Player = Core.class(Sprite)

function Player:init(path)
	self.path = path
	self.frame = Bitmap.new(Texture.new("image/print.png"))
	self.currentFrame = 1
	self.maxFrame = table.getn(path)
	self.speed = 1.0
	
	self:setPosition(self.path[1]:getX(),self.path[1]:getY())
	self:addChild(self.frame)
	
	--print(table.getn(path))
	self:addEventListener(Event.ENTER_FRAME, self.play, self)
end

function Player:play(event)
	-- need to get a slope?
	local nextFrame = self.currentFrame + 1
	
	-- vertical line
	if self.path[self.currentFrame]:getX() == self.path[nextFrame]:getX() then
		if self.path[self.currentFrame]:getY() < self.path[nextFrame]:getY() then
			self:setPosition(self:getX() , self:getY() + self.speed )
			if self:getY() >= self.path[nextFrame]:getY() then
				self:setPosition( self.path[nextFrame]:getX(), self.path[nextFrame]:getY())
				self.currentFrame = nextFrame
			end
		else
			self:setPosition(self:getX() , self:getY() - self.speed )
			if self:getY() <= self.path[nextFrame]:getY() then

				self:setPosition( self.path[nextFrame]:getX(), self.path[nextFrame]:getY())
				self.currentFrame = nextFrame
			end
		end
		
	else
		local slope = (self.path[nextFrame]:getY() - self.path[self.currentFrame]:getY()) / 
			(self.path[nextFrame]:getX() - self.path[self.currentFrame]:getX())
		self:setPosition(self:getX() - self.speed * slope , self:getY() + self.speed * slope)
		--print(slope)
		if slope > 0 then
			if self:getX() <= self.path[nextFrame]:getX() or self:getY() >= self.path[nextFrame]:getY() then
				self:setPosition( self.path[nextFrame]:getX(), self.path[nextFrame]:getY())
				self.currentFrame = nextFrame
			end
		elseif slope == 0 then -- horizontal line
			if self.path[nextFrame]:getX() < self.path[nextFrame]:getX() and self:getX() >= self.path[nextFrame]:getX() then
				self:setPosition( self.path[nextFrame]:getX(), self.path[nextFrame]:getY())
				self.currentFrame = nextFrame
			elseif self.path[nextFrame]:getX() > self.path[nextFrame]:getX() and self:getX() <= self.path[nextFrame]:getX() then
				self:setPosition( self.path[nextFrame]:getX(), self.path[nextFrame]:getY())
				self.currentFrame = nextFrame
			end
		else
			if self:getX() >= self.path[nextFrame]:getX() or self:getY() <= self.path[nextFrame]:getY() then
				self:setPosition( self.path[nextFrame]:getX(), self.path[nextFrame]:getY())
				self.currentFrame = nextFrame
			end
		end
	end
	
	--need to calculate speed
	if self.currentFrame >= self.maxFrame then
		print("pause")
		self:removeEventListener(Event.ENTER_FRAME, self.play, self)
	end 
end

function Player:pause()
	--self:removeChild(self.frame)
	frame:removeEventListener(Event.ENTER_FRAME, self.play, self)
end
