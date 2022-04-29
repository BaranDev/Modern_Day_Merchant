IntroState = Class{__includes = BaseState}


function IntroState:init()
    self.intro = true
    self.canContinue    = false
    self.IntroCover = gImages['intro_cover']
    self.IntroText = gImages['intro_text']
end

function IntroState:update(dt)


   if not self.intro then
        gStateMachine:change('title')
   end
  
    if canContinue and love.mouse.wasPressed(1) then
        self.intro = false
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

end -- end of update


function IntroState:render()

    if self.intro then
        local introCWidth,introCHeight = self.IntroCover:getWidth(),self.IntroCover:getHeight()
        love.graphics.draw(self.IntroCover, VIRTUAL_WIDTH/2-introCWidth/2,VIRTUAL_HEIGHT/2-introCHeight/2)
        
        
        
        --IntroCover's position
        local ix=VIRTUAL_WIDTH/2-introCWidth/2
        local iy=VIRTUAL_HEIGHT/2-introCHeight/2
        
        

        --if the mouse (x,y) is in the range of the cover
        if mx > ix and mx < ix + introCWidth then
            if my > iy and my < iy + introCHeight then
            love.graphics.draw(self.IntroText, VIRTUAL_WIDTH/2-introCWidth/2,VIRTUAL_HEIGHT/2-introCHeight/2)
            canContinue=true
            end
        else
            canContinue = false
        end
    end
    
end-- end of render