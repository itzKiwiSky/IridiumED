function love.load()
--libs
    saveLib = require 'Libaries/json'
--archives
    MapFileExiste = love.filesystem.getInfo("map.json")
--blocks
    blocks = {}

    blocksTexture = {
        love.graphics.newImage('Resources/DirtyFloor.png'),
        love.graphics.newImage('Resources/Dirty.png'),
        love.graphics.newImage('Resources/DirtyWall.png'),
        love.graphics.newImage('Resources/DirtyTransition.png'),
        love.graphics.newImage('Resources/DirtyVoid.png')
    }
    
--buttons
    -- button up
    buttonUp = {}
    buttonUp.Texture = love.graphics.newImage('Images/ButtonUpSpriteSheet.png')
    buttonUp.x = 64
    buttonUp.y = love.graphics.getHeight() - 128
    buttonUp.w = 64
    buttonUp.h = 64
    buttonUp.quad = 1
    
    buttonUpQuads = {
        love.graphics.newQuad(0, 0, 64, 64, buttonUp.Texture),
        love.graphics.newQuad(65, 0, 64, 64, buttonUp.Texture)
    }

    -- button down
    buttonDown = {}
    buttonDown.Texture = love.graphics.newImage('Images/ButtonDownSpriteSheet.png')
    buttonDown.x = 64
    buttonDown.y = love.graphics.getHeight() - 64
    buttonDown.w = 64
    buttonDown.h = 64
    buttonDown.quad = 1
    
    buttonDownQuads = {
        love.graphics.newQuad(0, 0, 64, 64, buttonDown.Texture),
        love.graphics.newQuad(65, 0, 64, 64, buttonDown.Texture)
    }

    -- button right
    buttonRight = {}
    buttonRight.Texture = love.graphics.newImage('Images/ButtonRightSpriteSheet.png')
    buttonRight.x = 128
    buttonRight.y = love.graphics.getHeight() - 64
    buttonRight.w = 64
    buttonRight.h = 64
    buttonRight.quad = 1

    buttonRightQuads = {
        love.graphics.newQuad(0, 0, 64, 64, buttonRight.Texture),
        love.graphics.newQuad(65, 0, 64, 64, buttonRight.Texture)
    }

    -- button left
    buttonLeft = {}
    buttonLeft.Texture = love.graphics.newImage('Images/ButtonLeftSpriteSheet.png')
    buttonLeft.x = 0
    buttonLeft.y = love.graphics.getHeight() - 64
    buttonLeft.w = 64
    buttonLeft.h = 64
    buttonLeft.quad = 1

    buttonLeftQuads = {
        love.graphics.newQuad(0, 0, 64, 64, buttonLeft.Texture),
        love.graphics.newQuad(65, 0, 64, 64, buttonLeft.Texture)
    }

    -- buttonS
    buttonS = {}
    buttonS.Texture = love.graphics.newImage('Images/ButtonSSpriteSheet.png')
    buttonS.x = 0
    buttonS.y = 0
    buttonS.w = 48
    buttonS.h = 48
    buttonS.quad = 1

    buttonSQuads = {
        love.graphics.newQuad(0, 0, 64, 64, buttonS.Texture),
        love.graphics.newQuad(65, 0 ,64 ,64, buttonS.Texture)
    }

    -- buttonB
    buttonB = {}
    buttonB.Texture = love.graphics.newImage('Images/ButtonBSpriteSheet.png')
    buttonB.x = 48
    buttonB.y = 0
    buttonB.w = 48
    buttonB.h = 48
    buttonB.quad = 1
    
    buttonBQuads = {
        love.graphics.newQuad(0, 0, 64, 64, buttonB.Texture),
        love.graphics.newQuad(65, 0, 64, 64, buttonB.Texture)
    }
    
    buttonN = {}
    buttonN.Texture = love.graphics.newImage('Images/ButtonNSpriteSheet.png')
    buttonN.x = 96
    buttonN.y = 0
    buttonN.w = 48
    buttonN.h = 48
    buttonN.quad = 1

    buttonNQuads = {
        love.graphics.newQuad(0, 0, 64, 64, buttonN.Texture),
        love.graphics.newQuad(65, 0, 64, 64, buttonN.Texture)
    }
    
    buttonR = {}
    buttonR.Texture = love.graphics.newImage('Images/ButtonRSpriteSheet.png')
    buttonR.x = 144
    buttonR.y = 0
    buttonR.w = 48
    buttonR.h = 48
    buttonR.quad = 1

    buttonRQuads = {
        love.graphics.newQuad(0, 0, 64, 64, buttonR.Texture),
        love.graphics.newQuad(65, 0, 64, 64, buttonR.Texture)
    }

    buttonDelete = {}
    buttonDelete.Texture = love.graphics.newImage('Images/ButtonDeleteSpriteSheet.png')
    buttonDelete.x = love.graphics.getWidth() - 96
    buttonDelete.y = love.graphics.getHeight() - 48
    buttonDelete.w = 69
    buttonDelete.h = 48
    buttonDelete.quad = 1
    
    buttonDeleteQuads = {
        love.graphics.newQuad(0, 0, 128, 64, buttonDelete.Texture),
        love.graphics.newQuad(129, 0, 128, 64, buttonDelete.Texture)
    }
    
-- screen
   screen = {}
   screen.x = buttonRight.x + buttonRight.w
   screen.y = buttonR.h
   screen.w = buttonDelete.x + 64
   screen.h = buttonUp.y + 64

-- vars
    -- touches
    tx = 0
    ty = 0
    -- cam
    editorOffSetX = 0
    editorOffSetY = 0
    -- put blocks in grade
    centerX = 0
    centerY = 0
    rotate = 0
    blockTexture = 1
    deleteBlock = false
-- commands
    -- deafult filter
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- criar arquivo
    if MapFileExiste == nil then
        arquivoMapa = love.filesystem.newFile("map.json", "w")
        arquivoMapa:write(saveLib.encode(blocks))
        arquivoMapa:close()
    end

    if MapFileExiste ~= nil then
        blocks = saveLib.decode(love.filesystem.read("map.json"))
    end
end

function love.draw()
-- grade
    for x = 0, 2048, 32 do
        for y = 0, 2048, 32 do
            love.graphics.setColor(0.5, 0.5, 0.5, 0.25)
            love.graphics.rectangle('line', x, y, 32, 32)
            love.graphics.setColor(1, 1, 1)
        end
    end

-- put blocks and move cam
    for _, block in ipairs(blocks) do
        love.graphics.draw(blocksTexture[block.id], block.x - editorOffSetX * 32, block.y - editorOffSetY * 32, block.rotate)
    end

-- block that go to print
    love.graphics.draw(blocksTexture[blockTexture], love.graphics.getWidth() - 32, 0)
    love.graphics.rectangle('line', love.graphics.getWidth() - 33, 0, 33, 33, 5)

-- buttons
    love.graphics.draw(buttonUp.Texture, buttonUpQuads[buttonUp.quad], buttonUp.x, buttonUp.y)
    love.graphics.draw(buttonDown.Texture, buttonDownQuads[buttonDown.quad], buttonDown.x, buttonDown.y)
    love.graphics.draw(buttonRight.Texture, buttonRightQuads[buttonRight.quad], buttonRight.x, buttonRight.y)
    love.graphics.draw(buttonLeft.Texture, buttonLeftQuads[buttonLeft.quad], buttonLeft.x, buttonLeft.y)
    love.graphics.draw(buttonS.Texture, buttonSQuads[buttonS.quad], buttonS.x, buttonS.y, nil, 0.75)
    love.graphics.draw(buttonB.Texture, buttonSQuads[buttonB.quad], buttonB.x, buttonB.y, nil, 0.75)
    love.graphics.draw(buttonN.Texture, buttonSQuads[buttonN.quad], buttonN.x, buttonN.y, nil, 0.75)
    love.graphics.draw(buttonDelete.Texture, buttonDeleteQuads[buttonDelete.quad], buttonDelete.x, buttonDelete.y, nil, 0.75)
    love.graphics.draw(buttonR.Texture, buttonRQuads[buttonR.quad], buttonR.x, buttonR.y, nil, 0.75)
end

function love.update(dt)
-- take touches on screen and create a table with alls x and y
    local touch = love.touch.getTouches()

    for _, touches in ipairs(touch) do
        tx, ty = love.touch.getPosition(touches)
    end
-- math

    centerX = math.floor(tx / 32) * 32
    centerY = math.floor(ty / 32) * 32
-- buttons
    if love.mouse.isDown(1) then
        -- arrows
        if isTouchOnButton(tx, ty, buttonUp) then
            buttonUp.quad = 2
            buttonLeft.quad = 1
            buttonDown.quad = 1
            buttonRight.quad = 1
            buttonN.quad = 1
            buttonB.quad = 1
            buttonS.quad = 1
            buttonDelete.quad = 1
            buttonR.quad = 1
            editorOffSetY = editorOffSetY - 1
        elseif isTouchOnButton(tx, ty, buttonDown) then
            buttonDown.quad = 2
            buttonLeft.quad = 1
            buttonUp.quad = 1
            buttonRight.quad = 1
            buttonN.quad = 1
            buttonB.quad = 1
            buttonS.quad = 1
            buttonDelete.quad = 1
            buttonR.quad = 1
            editorOffSetY = editorOffSetY + 1
        elseif isTouchOnButton(tx, ty, buttonLeft) then
            buttonLeft.quad = 2
            buttonDown.quad = 1
            buttonUp.quad = 1
            buttonRight.quad = 1
            buttonN.quad = 1
            buttonB.quad = 1
            buttonS.quad = 1
            buttonDelete.quad = 1
            buttonR.quad = 1
            editorOffSetX = editorOffSetX - 1
        elseif isTouchOnButton(tx, ty, buttonRight) then
            buttonLeft.quad = 1
            buttonRight.quad = 2
            buttonDown.quad = 1
            buttonUp.quad = 1
            buttonN.quad = 1
            buttonB.quad = 1
            buttonDelete.quad = 1
            buttonR.quad = 1
            editorOffSetX = editorOffSetX + 1
        -- s, save
        elseif isTouchOnButton(tx, ty, buttonS) then
            buttonN.quad = 1
            buttonB.quad = 1
            buttonLeft.quad = 1
            buttonDown.quad = 1
            buttonUp.quad = 1
            buttonRight.quad = 1
            buttonS.quad = 2
            buttonDelete.quad = 1
            buttonR.quad = 1
            mapFile = love.filesystem.newFile("map.json", "w")
            mapFile:write(saveLib.encode(blocks))
            mapFile:close()
        -- b, back
        elseif isTouchOnButton(tx, ty, buttonB) then
            buttonB.quad = 2
            buttonN.quad = 1
            buttonLeft.quad = 1
            buttonDown.quad = 1
            buttonUp.quad = 1
            buttonRight.quad = 1
            buttonS.quad = 1
            buttonDelete.quad = 1
            buttonR.quad = 1
            if blockTexture > 1 then
                blockTexture = blockTexture - 1 
            end
        --n, next
        elseif isTouchOnButton(tx, ty, buttonN) then
            buttonN.quad = 2
            buttonB.quad = 1
            buttonLeft.quad = 1
            buttonDown.quad = 1
            buttonUp.quad = 1
            buttonRight.quad = 1
            buttonS.quad = 1
            buttonDelete.quad = 1
            buttonR.quad = 1
            if blockTexture < 5 then
                blockTexture = blockTexture + 1
            end
        -- delete
        elseif isTouchOnButton(tx, ty, buttonDelete) then
            buttonDelete.quad = 2
            buttonN.quad = 1
            buttonB.quad = 1
            buttonLeft.quad = 1
            buttonDown.quad = 1
            buttonUp.quad = 1
            buttonRight.quad = 1
            buttonS.quad = 1
            buttonR.quad = 1
            if deleteBlock then
                deleteBlock = false
            else
                deleteBlock = true
            end
        -- rotate
        elseif isTouchOnButton(tx, ty, buttonR) then
            buttonR.quad = 2
            buttonLeft.quad = 1
            buttonDown.quad = 1
            buttonUp.quad = 1
            buttonRight.quad = 1
            buttonS.quad = 1
            buttonN.quad = 1
            buttonB.quad = 1
            buttonDelete.quad = 1
            if rotate == 4.71 then
                rotate = 0
            end
            if rotate == 3.14 then
                rotate = 4.71
            end
            if rotate == 1.57 then
                rotate = 3.14
            end
            if rotate == 0 then
                rotate = 1.57
            end
        end
    else
        buttonR.quad = 1
        buttonLeft.quad = 1
        buttonDown.quad = 1
        buttonUp.quad = 1
        buttonRight.quad = 1
        buttonS.quad = 1
        buttonN.quad = 1
        buttonB.quad = 1
        buttonDelete.quad = 1
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        if isTouchOnButton(tx, ty, screen) then
            if not deleteBlock then
                if rotate == 1.57 then
                   centerX = centerX + 32
                end
                if rotate == 3.14 then
                   centerX = centerX + 32
                   centerY = centerY + 32
                end
                if rotate == 4.71 then
                   centerY = centerY + 32
                end
                createBlocks(centerX + editorOffSetX * 32, centerY + editorOffSetY * 32, blockTexture, rotate)
            end
            if deleteBlock then 
                removeBlock(centerX + editorOffSetX * 32, centerY + editorOffSetY * 32)
            end
        end
    end
end
--[[
function checkRadius(x, y, w, h, r)
    if r == 1.57 then
        x = x + w
    end
    if r == 3.14 then
        x = x + w
        y = y + h
    end
    if r == 4.71 then
        y = y + h
    end
    return x, y
end
]]
function createBlocks(x, y, id, r) 
    block = {}
    block.x = x
    block.y = y
    block.id = id
    block.rotate = r
    table.insert(blocks, block)
end

function removeBlock(x, y)
    for _, block in ipairs(blocks) do
        if block.x == x then
            if block.y == y then
                table.remove(blocks, _)
            end
        end
    end
end

function isTouchOnButton(touchx, touchy, button)
    local tx, ty = touchx, touchy
    if button.x <= tx and button.x + button.w >= tx and button.y <= ty and button.y + button.h >= ty then
        return true
    else
        return false
    end
end
