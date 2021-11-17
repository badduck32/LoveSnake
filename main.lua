function love.load()
    dirHor = 1
    dirVer = 0
    headX = 100
    headY = 100
    moveSpeed = 25
    snakeSize = 50
    cntr = moveSpeed
    tailPosX = {}
    tailPosY = {}
end

function love.update(dt)
    cntr = cntr - 100 * dt
    if cntr <= 0 then 
        cntr = moveSpeed
        moveSnake()
    end 
end

function love.draw()
    love.graphics.setColor(0, 0.8, 0)
    love.graphics.rectangle("fill", headX, headY, snakeSize, snakeSize)
    for i, v in pairs(tailPosX) do
        love.graphics.rectangle("fill", tailPosX[i], tailPosY[i], snakeSize, snakeSize)
    end
end

function love.keypressed(key)
    if key == "right" then
        dirHor = 1
        dirVer = 0
    elseif key == "left" then
        dirHor = -1
        dirVer = 0
    elseif key == "up" then
        dirVer = -1
        dirHor = 0
    elseif key == "down" then
        dirVer = 1
        dirHor = 0
    else
        growTail();
    end
end

function moveSnake()
    for i, v in pairs(tailPosX) do
        if #tailPosX - i > 0 then
            tailPosX[#tailPosX - i + 1] = tailPosX[#tailPosX - i]
            tailPosY[#tailPosY - i + 1] = tailPosY[#tailPosY - i]
        else
            tailPosX[1] = headX
            tailPosY[1] = headY
        end
    end
    headX = headX + snakeSize * dirHor
    headY = headY + snakeSize * dirVer
end

function growTail()
    if #tailPosX == 0 then
        tailPosX[#tailPosX + 1] = headX
        tailPosY[#tailPosY + 1] = headY
    else
        tailPosX[#tailPosX + 1] = tailPosX[#tailPosX]
        tailPosY[#tailPosY + 1] = tailPosY[#tailPosY]
    end
end