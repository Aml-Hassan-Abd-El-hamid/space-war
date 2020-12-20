Class = require "class"
--THE TEXTBOX IN SCENE 2
suit = require "suit-master"
corn_timer = require "cron"
require "player"
require "intro"

-- VARIBLES :)
            WINDOW_WIDTH = 1600
            WINDOW_HEIGHT = 650

            SCREEN_TIME_START = love.timer.getTime()
            SCREEN_TIME_END = SCREEN_TIME_START

            love.graphics.setDefaultFilter('nearest', 'nearest')

            --Fonts area that should be defently be a table latter for a less messy code
            --THE WELCOME FONT
            big = love.graphics.newFont('04B_03__.TTF', 96)
            -- THE SECOND SCREEN FONT
            medium = love.graphics.newFont('04B_03__.TTF', 72)
            -- TEXT FONT
            textFont = love.graphics.newFont('04B_03__.TTF', 24)


            GAME_STATE = "welcome"

            PLAYERS_COUNTER = 0

            GAME_TIME = 10

            --THE TEXTBOX IN SCENE 2
            input = {text="0"}

            Player1 = player(100,100,0,"d","a","w")
            score1=0
            Player2 = player(WINDOW_WIDTH-400,WINDOW_HEIGHT-50,math.pi,"right","left","up")
            score3=0
            score2=0
                        
            gameBackground = love.graphics.newImage("imgs/anton-nikolov-JKeIu3jjJFw-unsplash.jpg")

            sounds = {
                ['ship_shoot'] = love.audio.newSource("sounds/Hit_Hurt11.wav","static"),
                ['ship_hurt'] = love.audio.newSource("sounds/min.wav","static"),
                ['score'] = love.audio.newSource("sounds/Explosion280.wav","static")
            }


function love.load()
    math.randomseed(os.time())
-- SETTING THE SCREEN    
    love.window.setMode( WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        resizable = true,
        vsync = true
    } ) 
end

function love.update(dt)
    SCREEN_TIME_END = SCREEN_TIME_END + 1
    --THE TEXTBOX IN SCENE 2
    suit.Input(input, 600,620,100,100)

    mx,my = love.mouse.getPosition()--know the positon of the mouse

    if GAME_STATE=="playing" then
        Player1:update(dt)
        Player2:update(dt)
        if PLAYERS_COUNTER == 3 then
            Player3:update(dt)
        end
        corn_after:update(dt)
    end
end

--THE TEXTBOX IN SCENE 2
function love.textinput(t)
    suit.textinput(t)
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.quit()
    end 
    --THE TEXTBOX IN SCENE 2
    suit.keypressed(k)
    if GAME_STATE == "playing" then     
        Player1:keypressed(k)
        Player2:keypressed(k)
        if PLAYERS_COUNTER == 3 then
            Player3:keypressed(k)
        end
    end

end

function love.mousepressed(x, y, button)
    if button == 1 and mx>320 and mx <320+100 and my > 250 and my <250+100 then -- "Versions prior to 0.10.0 use the MouseConstant 'l'"
       PLAYERS_COUNTER = 2
    elseif button == 1 and mx>910 and mx <910+100 and my > 250 and my <250+100 then
        PLAYERS_COUNTER = 3
    end
 end

function love.draw()

        drawIntro()

        if GAME_STATE == "playing" then
            love.graphics.draw(gameBackground,0,0,0,.75,.6)
            Player1:render()
            Player2:render()
            --love.graphics.setColor(0,1,0,1)
            if PLAYERS_COUNTER == 3 then
                Player3:render()
            end
            --love.graphics.setColor(1,1,1,1)
            love.graphics.setFont(textFont)
            love.graphics.setColor(0,0,1,1)
            love.graphics.print("Blue: ",10,10)
            love.graphics.print(score1,90,10)
            love.graphics.setColor(1,1,1,1)
            if PLAYERS_COUNTER == 3 then
                love.graphics.setColor(0,1,0,1)
                love.graphics.print("Green: ",10,WINDOW_HEIGHT+50)
                love.graphics.print(score2,90,WINDOW_HEIGHT+50)
                love.graphics.setColor(1,1,1,1)   
            end
            love.graphics.setColor(1,0,0,1)
            love.graphics.print("RED: ",WINDOW_WIDTH-440,WINDOW_HEIGHT+50)
            love.graphics.print(score3,WINDOW_WIDTH-380,WINDOW_HEIGHT+50)
            love.graphics.setColor(1,1,1,1)      
        end

        if GAME_STATE == "win" then
            love.graphics.setFont(big)
            love.graphics.draw(background,0,0,0,.7,.7)
            if math.max(score1,score2,score3) == score3 then
                love.graphics.setColor(1,0,0,1)
                y = "RED WINS!"
            elseif math.max(score1,score2,score3) == score2 then
                love.graphics.setColor(0,1,0,1)
                y="GREEN WINS!"
            elseif math.max(score1,score2,score3) == score1 then
                love.graphics.setColor(0,0,1,1)
                y="BLUE WINS!"
            end
            love.graphics.print(y,400,200)
        
        end

end

function defineplayer3(us)
    if us == 3 then
            Player3 = player(100,WINDOW_HEIGHT-50,0,"k","h","u")    
    end
end


