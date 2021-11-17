function love.load()
    dirHor = 1
    dirVer = 0
    headX = 100
    headY = 100
    moveSpeed = 25
    cntr = moveSpeed
    tail = {}
end

function love.update(dt)
    cntr = cntr - 100 * dt
    if cntr <= 0 then 
        cntr = moveSpeed
        headX = headX + 50 * dirHor
        headY = headY + 50 * dirVer
    end 
end

function love.draw()
    love.graphics.setColor(0, 0.8, 0)
    love.graphics.rectangle("fill", headX, headY, 50, 50)
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
    elseif "down" then
        dirVer = 1
        dirHor = 0
    end
end

function moveSnake()

end