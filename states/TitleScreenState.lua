TitleScreenState = Class{__includes = BaseState}
--local coloredText = love.graphics.newText(font, {{1, 0, 0}, "Hello ", {0, 0, 1}, " world"})

example = {
    display_mode = 1,
    maxmodes = 9,
    ex5_textboxsize = 64,
    bop = true,
    boptimer = 1,
    }

function TitleScreenState:init() 

    self.grid = anim8.newGrid(700,300,gImages['title_sprite_sheet']:getWidth(),gImages['title_sprite_sheet']:getHeight())
    self.animation = anim8.newAnimation(self.grid('1-7',1),0.5)
    self.check = 0
    self.selection_point = 1
    self.selections={
    ['PLAY'] = false,
    ['HIGHSCORES'] = false,
    ['EXIT'] = false
    }

    self.TEXT_PLAY= love.graphics.newText(gFonts['default'],'PLAY')
    self.TEXT_HIGHSCORES= love.graphics.newText(gFonts['default'], 'HIGHSCORES')
    self.TEXT_EXIT= love.graphics.newText(gFonts['default'], 'EXIT')


    textbox_play = Text.new("left", { color = {1,1,1,1}, shadow_color = {0.5,0.5,1,0.4}, default_underline_position = -2, default_strikethrough_position = 1,dropshadow=10})
    textbox_play:send("[color=#0D00A4][dropshadow=3]PLAY", 320, true)
    textbox_highscore = Text.new("center", { color = {1,1,1,1}, shadow_color = {0.5,0.5,1,0.4}, default_underline_position = -2, default_strikethrough_position = 1})
    textbox_highscore:send("[color=#0D00A4][dropshadow=3]HIGHSCORES", 500, true)
    textbox_exit = Text.new("center", { color = {1,1,1,1}, shadow_color = {0.5,0.5,1,0.4}, default_underline_position = -2, default_strikethrough_position = 1})
    textbox_exit:send("[color=#0D00A4][dropshadow=3]EXIT", 400, true)
    
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
    textbox_exit:update(dt)
    textbox_play:update(dt)
    textbox_highscore:update(dt)
    self.cnt=0
        if not (self.selection_point == 1) then
            self.selections['PLAY']=false
            textbox_play:send("[color=#0D00A4][dropshadow=3][textspeed=0]PLAY", 320, true)
        elseif self.selection_point==1 then
            self.selections['PLAY']=true
            textbox_play:send("[color=#0D00A4][dropshadow=10][textspeed=0]PLAY", 320, true)
        end
        

        if not (self.selection_point == 2) then
            self.selections['HIGHSCORES']=false
            if self.cnt == 0 then
            textbox_highscore:send("[color=#0D00A4][dropshadow=3][textspeed=0]HIGHSCORES", 500, true)
            end
        elseif self.selection_point == 2 then
            self.selections['HIGHSCORES']=true
            if self.cnt == 0 then
            textbox_highscore:send("[color=#0D00A4][dropshadow=10][textspeed=0]HIGHSCORES", 500, true)
            self.cnt = self.cnt + 1    
            end
        end

        if not (self.selection_point == 3) then
            self.selections['EXIT']=false
            textbox_exit:send("[color=#0D00A4][dropshadow=3][textspeed=0]EXIT", 400, true)
        elseif self.selection_point == 3 then
            self.selections['EXIT']=true
            textbox_exit:send("[color=#0D00A4][dropshadow=10][textspeed=0]EXIT", 400, true)
        end


    if love.keyboard.wasPressed('down') then
        self.cnt = 0
        self.selection_point = self.selection_point + 1
        if self.selection_point == 4 then
            self.selection_point = 1
        end
        self.check = 1
    elseif love.keyboard.wasPressed('up') then
        self.cnt = 0
        self.selection_point = self.selection_point - 1
        if self.selection_point == 0 then
            self.selection_point = 3
        end
        self.check = 1
    end

end-- end of update


function TitleScreenState:render() 
    self.animation:draw(gImages['title_sprite_sheet'],VIRTUAL_WIDTH/4-40,VIRTUAL_HEIGHT/16)

    --draw rectangle from -200 of titleanimation
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line", VIRTUAL_WIDTH/4-40,VIRTUAL_HEIGHT/16-40, 700,710)
    love.graphics.rectangle("line", VIRTUAL_WIDTH/4-42.5,VIRTUAL_HEIGHT/16-40, 705,710)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line", VIRTUAL_WIDTH/4-41.25,VIRTUAL_HEIGHT/16-40, 702.5,710)
    
    textbox_play:draw(VIRTUAL_WIDTH/2-100,VIRTUAL_HEIGHT/64+395)
    textbox_highscore:draw(VIRTUAL_WIDTH/2-240,VIRTUAL_HEIGHT/64+500)
    textbox_exit:draw(VIRTUAL_WIDTH/2-200,VIRTUAL_HEIGHT/64+600, 400,100)
    --set font to title_text
--[[ old text code
    love.graphics.setColor(0,0,0)--love.math.colorFromBytes(12, 43, 165))
    love.graphics.draw(self.TEXT_PLAY, VIRTUAL_WIDTH/2-100,VIRTUAL_HEIGHT/64+395)--opt1
    love.graphics.rectangle("line", VIRTUAL_WIDTH/2-200,VIRTUAL_HEIGHT/64+385, 400,100)

    love.graphics.draw(self.TEXT_HIGHSCORES, VIRTUAL_WIDTH/2-240,VIRTUAL_HEIGHT/64+500)
    love.graphics.rectangle("line", VIRTUAL_WIDTH/2-250,VIRTUAL_HEIGHT/64+485, 500,115)--opt2

    love.graphics.draw(self.TEXT_EXIT, VIRTUAL_WIDTH/2-80,VIRTUAL_HEIGHT/64+610)
    love.graphics.rectangle("line", VIRTUAL_WIDTH/2-200,VIRTUAL_HEIGHT/64+600, 400,100)--opt3
]]



end--end of render

function TitleScreenState:exit() 

end-- end of exit

