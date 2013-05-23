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
	local nextFrame = self.currentFrame + 1
	local x1, y1 = self.path[self.currentFrame]:getX(), self.path[self.currentFrame]:getY()
	local x2, y2 = self.path[nextFrame]:getX(), self.path[nextFrame]:getY()
	local dis =  math.sqrt((x2 - x1) * (x2 - x1) + (y1 - y2) * (y1 - y2))
	local dsin = (x2-x1) / dis 
	local dcos = (y2-y1) / dis
	self:setPosition(self:getX() + self.speed * dsin , self:getY() + self.speed * dcos)
	
	if  (dsin >= 0 and self:getX() >= x2) or (dsin < 0 and self:getX() < x2)  then
		self:setPosition(x2, y2)
		self.currentFrame = nextFrame
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

function Player:getCurrentPath()
	local p = {}
	if self.currentFrame < self.maxFrame then
		p[1], p[2] = self.path[self.currentFrame]:getX(), self.path[self.currentFrame]:getY()
		p[3], p[4] = self.path[self.currentFrame+1]:getX(), self.path[self.currentFrame+1]:getY()
	end
	return p
end

function Player:pause()
	--self:removeChild(self.frame)
	frame:removeEventListener(Event.ENTER_FRAME, self.play, self)
end
