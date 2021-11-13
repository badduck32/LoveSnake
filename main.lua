function love.load()
    test = false
end

function love.update(dt)
    -- body
end

function love.draw()
    if test then 
        love.graphics.print("pressed", 10, 10)
    end 
end

function love.keypressed(key)
    if key == "right" then
        test = true 
    end
end