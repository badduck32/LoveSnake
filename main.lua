function love.load()
    
    moveSpeed = 25
    cellSize = 25
    cntr = moveSpeed
    screenWidth, screenHeight = love.graphics.getDimensions();
    --applePosX = 0
    --applePosY = 0
    
    function newApplePosition()
        applePosX = math.random( 0, (screenWidth / cellSize) - 1 ) * cellSize
        applePosY = math.random( 0, (screenHeight / cellSize) - 1 ) * cellSize
        if applePosX ~= headX and applePosY ~= headY then
            for i, v in pairs(tailPosX) do 
                if tailPosX[i] == applePosX and tailPosY[i] == applePosY then 
                    newApplePosition()
                end
            end
        else 
            newApplePosition()
        end
    end
    
    function reset()
        dirHor = 1
        dirVer = 0
        prevDirHor = 1
        prevDirVer = 0
        headX = 200
        headY = 100
        tailPosX = {headX - cellSize, headX - cellSize - cellSize}
        tailPosY = {headY, headY}
        newApplePosition()
    end

    reset()
end

function love.update(dt)
    cntr = cntr - 100 * dt
    if cntr <= 0 then 
        cntr = moveSpeed
        moveSnake()
    end
end

function love.draw()
    love.graphics.setColor(0.8, 0, 0)
    love.graphics.rectangle("fill", applePosX, applePosY, cellSize, cellSize)
    love.graphics.setColor(0, 0.8, 0)
    love.graphics.rectangle("fill", headX, headY, cellSize, cellSize)
    for i, v in pairs(tailPosX) do
        love.graphics.rectangle("fill", tailPosX[i], tailPosY[i], cellSize, cellSize)
    end
end

function love.keypressed(key)
    if key == "right" and prevDirHor ~= -1 then
        dirHor = 1
        dirVer = 0
    elseif key == "left" and prevDirHor ~= 1 then
        dirHor = -1
        dirVer = 0
    elseif key == "up" and prevDirVer ~= 1 then
        dirVer = -1
        dirHor = 0
    elseif key == "down" and prevDirVer ~= -1 then
        dirVer = 1
        dirHor = 0
    end
end

function moveSnake()
    prevDirHor = dirHor
    prevDirVer = dirVer
    for i, v in pairs(tailPosX) do
        if #tailPosX - i > 0 then
            tailPosX[#tailPosX - i + 1] = tailPosX[#tailPosX - i]
            tailPosY[#tailPosY - i + 1] = tailPosY[#tailPosY - i]
        else
            tailPosX[1] = headX
            tailPosY[1] = headY
        end
    end
    headX = headX + cellSize * dirHor
    headY = headY + cellSize * dirVer
    --check if it touches an apple
    if applePosX == headX and applePosY == headY then
        growTail()
    end
    --check if it touches its own tail
    for i, v in pairs(tailPosX) do 
        if tailPosX[i] == headX and tailPosY[i] == headY then 
            reset()
        end
    end
    --check if it's not out of bounds
    if headX >= 800 or headX < 0 or headY < 0 or headY >= 600 then 
        reset()
    end
end

function growTail()
    newApplePosition()
    if #tailPosX == 0 then
        tailPosX[#tailPosX + 1] = headX
        tailPosY[#tailPosY + 1] = headY
    else
        tailPosX[#tailPosX + 1] = tailPosX[#tailPosX]
        tailPosY[#tailPosY + 1] = tailPosY[#tailPosY]
    end
end