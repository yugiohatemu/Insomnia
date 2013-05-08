--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2010 - 2011 Gideros Mobile 
--]]

Player = Core.class(Sprite)

function Player:init(path)
	self.path = path
	self.frame = Bitmap.new(Texture.new("image/print.png"))
	self.currentFrame = 0
	self.maxFrame = table.getn(path)
	--point = path[0]
	self:setPosition(self.path[1][1]-8,self.path[1][2]-8)
	self:addChild(self.frame)
	--print(table.getn(path))
	self:addEventListener(Event.ENTER_FRAME, self.play, self)
end

function Player:play(event)
	
	self:setPosition(self.path[self.currentFrame][1]-8, self.path[self.currentFrame][2]-8)
	self.currentFrame = self.currentFrame + 1
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
