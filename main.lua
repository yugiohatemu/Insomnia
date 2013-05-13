application:setOrientation(Application.LANDSCAPE_LEFT) 

-----
pointRemain = 5;
local pointInfo = TextField.new(nil, "points remain "..pointRemain)
pointInfo:setPosition(100,20)

local lastPoint = {20,250}
local path = {}

-- for simplicity, just use an array for point and lines
-- but need 
local pointList = {}
pointList[1] = TurnPoint.new(20,250,1)
stage:addChild(pointList[1])

local lineList = {}

--local aPlayer = nil
--isPlaying = false
local playButton = Button.new(Bitmap.new(Texture.new("image/play_on.png")), Bitmap.new(Texture.new("image/play_on.png")))
playButton:setPosition(40, 5)
playButton:addEventListener("click",
	function()
		aPlayer =  Player.new(pointList)
		stage:addChild(aPlayer)
		--
		--afterward, remove it
	end
)


-- draw boundary
local function drawBoundary ()
	local boarderWidth = application:getContentWidth()
	local boarderHeight = application:getContentHeight()
	local boarder = Shape.new()
	boarder:setLineStyle(3, 0x66CC00)
	boarder:beginPath()
	boarder:moveTo(boarderWidth * 0.03 , boarderHeight * 0.08)
	boarder:lineTo(boarderWidth * 0.03 , boarderHeight * 0.95)
	boarder:lineTo(boarderWidth * 0.97 , boarderHeight * 0.95)
	boarder:lineTo(boarderWidth * 0.97 , boarderHeight * 0.08)
	boarder:closePath()
	boarder:endPath()
	
	stage:addChild(boarder)
end

local function isInBoundary ( x , y )
	if x < application:getContentWidth() * 0.97 and x > application:getContentWidth() * 0.03
		and y < application:getContentHeight() * 0.95 and y > application:getContentHeight() * 0.08 then
		return true
	end
	return false
end

drawBoundary()

-- enum
local State = {CREATE = 1,  RESET = 2}
local gameState = State.CREATE

local resetButton = Button.new(Bitmap.new(Texture.new("image/delete.png")), Bitmap.new(Texture.new("image/turnPoint.png")))
resetButton:setPosition(200,5)
resetButton:addEventListener("click", 
	function()
	--gameState = State.RESET
		-- remove line
		i = 1
		while lineList[i]  do
			stage:removeChild(lineList[i])
			lineList[i] = nil
			i = i + 1
		end
		-- remove point
		i = 2
		while pointList[i] do
			stage:removeChild(pointList[i])
			pointList[i] = nil
			i = i + 1
		end
		-- reset 
		pointRemain = 5
	end
)
-- so need to overwrite the press event? 

--stage:addChild(info)
stage:addChild(pointInfo)
stage:addChild(resetButton)
stage:addChild(playButton)

-- change the way point press work first
-- so need to have a array to remeber points?

local function onTouches(event)
	--depends on state, but ignore that
	--print("on Touch")
	if pointRemain > 0  and gameState == State.CREATE and  isInBoundary(event.touch.x, event.touch.y) then
		--draw point
		local aPoint = TurnPoint.new(event.touch.x, event.touch.y,7-pointRemain)
		pointList[7-pointRemain] = aPoint
		stage:addChild(aPoint)
		
		if pointRemain == 5 then 
			-- 1st point
			lineList[1] = Route.new(20, 250, event.touch.x, event.touch.y)
			lineList[2] = Route.new(event.touch.x, event.touch.y, 20, 250)
			
			aPoint:addLine(lineList[1], lineList[2])
			stage:addChild(lineList[1])
			stage:addChild(lineList[2])
		else
			-- need to swap the last line and new line
			stage:removeChild(lineList[6 - pointRemain])
			
			-- new line
			lineList[6 - pointRemain] = Route.new(lastPoint[1], lastPoint[2], event.touch.x, event.touch.y)
			lineList[7 - pointRemain] = Route.new(event.touch.x, event.touch.y, 20, 250)
			
			-- add new line to new point
			aPoint:addLine(lineList[6 - pointRemain], lineList[7 - pointRemain])
			stage:addChild(lineList[6 - pointRemain])
			stage:addChild(lineList[7 - pointRemain])
			
			-- update the line link on prev line
			pointList[6 - pointRemain]:addLine(lineList[5 - pointRemain], lineList[6 - pointRemain])
			
		end
		
		-- do update on text
		pointRemain = pointRemain - 1
		lastPoint[1],lastPoint[2] = event.touch.x, event.touch.y
		pointInfo:setText("points remain "..pointRemain)
		
	end
	
end

stage:addEventListener(Event.TOUCHES_END, onTouches)
