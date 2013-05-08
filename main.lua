application:setOrientation(Application.LANDSCAPE_LEFT) 

isPlaying = false
local info = TextField.new(nil, "pause")
info:setPosition(40, 20)

pointRemain = 5;
local pointInfo = TextField.new(nil, "points remain "..pointRemain)
pointInfo:setPosition(100,20)

-- enum
local State = {CREATE = 1,  DELETE = 2}
local gameState = State.CREATE

local deleteButton = Button.new(Bitmap.new(Texture.new("image/delete.png")), Bitmap.new(Texture.new("image/turnPoint.png")))
deleteButton:setPosition(200,20)
deleteButton:addEventListener("delete", 
	function()
		gameState = State.DELETE
	end
)
-- so need to overwrite the press event? 

stage:addChild(info)
stage:addChild(pointInfo)
stage:addChild(deleteButton)

-----
local lastPoint = {20,250}
local path = {}

-- for simplicity, just use an array for point and lines
-- but need 
local pointList = {}
pointList[1] = TurnPoint.new(20,250,1)
stage:addChild(pointList[1])

local lineList = {}

-- change the way point press work first
-- so need to have a array to remeber points?

local function onTouches(event)
	--depends on state, but ignore that
	--print("on Touch")
	if pointRemain > 0  and gameState == State.CREATE then
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
		
	elseif gameState == State.DELETE then
		i = 2
		while i <= 7 do -- should be current count
			if pointList[i]:hitTestPoint(event.x, event.y) then
				-- add new line
				aLine = pointList[i]:mergeLine()
				pointList[i-1]:addLine(pointList[i-1].from, aLine)
				pointList[i+1]:addLine(aLine, pointList[i+1].to)
				
				-- remove from list and stage
				stage:removeChild(pointList[i].from)
				stage:removeChild(pointList[i].to)
				stage:removeChild(pointList[i])
				
				-- update point list by swaping
				while i < 7 do
					pointList[i] = pointList[ i + 1 ];
					i = i + 1
				end
				-- update info
				pointRemain = pointRemain + 1
				pointInfo:setText("points remain "..pointRemain)
				break
			end
			i = i + 1
		end 
	end
	
end


local aPlayer = nil

local function playAnimation(event)
	if isPlaying then
		info:setText("play")
		
		aPlayer =  Player.new(path)
		stage:addChild(aPlayer)
		
	else
		info:setText("pause")
		if aPlayer then
			stage:removeChild(aPlayer)
		else
			aPlayer = nil
		end
	end
	
	isPlaying = not isPlaying
	
end

stage:addEventListener(Event.TOUCHES_END, onTouches)


-- start main

--touch to draw, but not so useful
--[[local function onTouches(event)
	if pastX > 0 and  pastY > 0 then
		local aLine = Shape.new()
		aLine:setLineStyle(3, 0x000000)
		aLine:beginPath()
		aLine:moveTo(pastX, pastY)
		aLine:lineTo(event.touch.x, event.touch.y)
		aLine:endPath()
		stage:addChild(aLine)
		--- add to path
		
		path[index] = {}
		path[index][0] = event.touch.x
		path[index][1] = event.touch.y
		index = index + 1
		
	end
	pastX, pastY = event.touch.x, event.touch.y

end --]]