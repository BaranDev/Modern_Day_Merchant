TitleScreenState = Class{__includes = BaseState}
--local coloredText = love.graphics.newText(font, {{1, 0, 0}, "Hello ", {0, 0, 1}, " world"})

function TitleScreenState:init() 

    self.grid = anim8.newGrid(700,300,gImages['title_sprite_sheet']:getWidth(),gImages['title_sprite_sheet']:getHeight())
    self.animation = anim8.newAnimation(self.grid('1-7',1),0.5)
    self.selections={
    ['PLAY'] = false,
    ['HIGH SCORES'] = false,
    ['EXIT'] = false
    }
    
    self.TEXT_PLAY= love.graphics.newText(gFonts['title_text'],'PLAY')
    self.TEXT_HIGHSCORES= love.graphics.newText(gFonts['title_text'], 'HIGH SCORES')
    self.TEXT_EXIT= love.graphics.newText(gFonts['title_text'], 'EXIT')
end-- end of init

function TitleScreenState:enter() 

end-- end of enter

function selection(x,y,option)
    if x>mx and x<mx+200 and y>my and y<my+50 then
        return option
    else
        return not option
    end
end

function TitleScreenState:update(dt) 
    self.animation:update(dt)

end-- end of update


function TitleScreenState:render() 
    self.animation:draw(gImages['title_sprite_sheet'],VIRTUAL_WIDTH/4-40,VIRTUAL_HEIGHT/16)

    --draw rectangle from -200 of self.animation
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line", VIRTUAL_WIDTH/4-40,VIRTUAL_HEIGHT/16-40, 700,710)

    --set font to title_text
    love.graphics.setColor(love.math.colorFromBytes(12, 43, 165))
    love.graphics.draw(self.TEXT_PLAY, VIRTUAL_WIDTH/2-100,VIRTUAL_HEIGHT/64+395)--opt1
    love.graphics.rectangle("line", VIRTUAL_WIDTH/2-200,VIRTUAL_HEIGHT/64+385, 400,100)

    love.graphics.draw(self.TEXT_HIGHSCORES, VIRTUAL_WIDTH/2-240,VIRTUAL_HEIGHT/64+500)
    love.graphics.rectangle("line", VIRTUAL_WIDTH/2-250,VIRTUAL_HEIGHT/64+485, 500,115)--opt2

    love.graphics.draw(self.TEXT_EXIT, VIRTUAL_WIDTH/2-80,VIRTUAL_HEIGHT/64+610)
    love.graphics.rectangle("line", VIRTUAL_WIDTH/2-200,VIRTUAL_HEIGHT/64+600, 400,100)--opt3

end--end of render

function TitleScreenState:exit() 

end-- end of exit

