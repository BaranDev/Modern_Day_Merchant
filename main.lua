require 'libs/dependencies'

BACKGROUND_SCROLL_SPEED=60
BACKGROUND_SCROLL_DIRECTION = 'LEFT'
BACKGROUND_X=0
debug = false

gImages = 
{
    ['background'] = love.graphics.newImage('assets/images/menu_bg.png'),
    ['background_wide'] = love.graphics.newImage('assets/images/menu_bg_wide.png'),
    ['intro_cover'] = love.graphics.newImage('assets/images/introCover.png'),
    ['intro_text'] = love.graphics.newImage('assets/images/introText.png'),
    ['title_sprite_sheet'] = love.graphics.newImage('assets/images/TitleSheet.png')
}

gFonts = {
    ['default'] = love.graphics.newFont('assets/fonts/wellbutrin.regular.ttf', 64),
    ['medium'] = love.graphics.newFont('assets/fonts/wellbutrin.regular.ttf', 128),
    ['large'] = love.graphics.newFont('assets/fonts/wellbutrin.regular.ttf', 256)
}
--set font to default
love.graphics.setFont(gFonts['default'])

gStateMachine = StateMachine {
    ['title'] =     function() return TitleScreenState() end,
    ['countdown'] = function() return CountdownState() end,
    ['play'] =      function() return PlayState() end,
    ['score'] =     function() return ScoreState() end,
    ['pause'] =     function() return PauseState() end,
    ['intro'] =    function() return IntroState() end
}

--Text library fonts
Text.configure.font_table("gFonts")

function love.load()

        love.graphics.setDefaultFilter('nearest', 'nearest')
        love.window.setTitle('Modern Day Merchant')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
})



    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}

    local BGimg = gImages['background_wide']

    backgroundWidth = BGimg:getWidth()
    backgroundHeight = BGimg:getHeight()

end -- end of love.load

gStateMachine:change('intro')



function love.resize(w, h)
    push:resize(w, h)
end -- end of love.resize


function love.update(dt)
    
      --scroll handler
    if BACKGROUND_SCROLL_DIRECTION == 'LEFT' then

        BACKGROUND_X =BACKGROUND_X - BACKGROUND_SCROLL_SPEED*dt--scroll left

        if BACKGROUND_X+ backgroundWidth/2 < 0 then

            BACKGROUND_SCROLL_DIRECTION = 'RIGHT' 

        end
   else
        BACKGROUND_X =BACKGROUND_X + BACKGROUND_SCROLL_SPEED*dt --scroll right

        if BACKGROUND_X+backgroundWidth/2 > VIRTUAL_WIDTH then

            BACKGROUND_SCROLL_DIRECTION = 'LEFT'

        end
   end

    gStateMachine:update(dt)
    --get mouse position
    mx,my = love.mouse.getPosition()

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}

    

    

end-- end of love.update

function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end-- end of love.keypressed

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end

end



function love.draw()
    push:apply('start')

   
    love.graphics.draw(gImages['background_wide'],BACKGROUND_X,0)
    gStateMachine:render()
    --love.graphics.rectangle("fill", VIRTUAL_WIDTH/4,VIRTUAL_HEIGHT/16, 700,300)--menuImg test

    push:apply('end')

end-- end of love.draw

