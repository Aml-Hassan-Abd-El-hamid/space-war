-- I am just trying to have more clean place in my main file so I can find things faster
-- and still do everything just like I want so I am dividing my project into more files
-- so when I need to change or check anything I just go to that certin file insted of 
-- wondring around in hundrd lines or more :)

Player = player()
g = 1
f=1



background = love.graphics.newImage("imgs/hey.jpg")
function state()
    if SCREEN_TIME_END >= SCREEN_TIME_START + t then
        GAME_STATE = "choose"
    end
end

function drawIntro()

    -- DRAWING THE FIRST SCREEN TO WELCOME THE PLAYER
    t = 100--510
    if  SCREEN_TIME_END <= SCREEN_TIME_START + t then
        love.graphics.setFont(big)
        love.graphics.draw(background,0,0,0,.7,.7)
        love.graphics.print("WELCOME TO SPACE WAR",100,200)
        state()
    end

    -- DRAWING THE 2ND SCREEN & LET THE M CHOOSE THIER NUM & TIME
    if GAME_STATE == "choose" and g==1 then
        love.graphics.clear(40/255, 45/255, 70/255, 255/255)
        love.graphics.setFont(medium)
        love.graphics.print("How many players are you ?",140,100)

        -- THE BUTTONS
        mx,my = love.mouse.getPosition()--know the positon of the mouse
        if mx>320 and mx <320+100 and my > 250 and my <250+100 then
            love.graphics.rectangle ("line",320,250,100,100)
            love.graphics.print("2",350,270)
        else
            love.graphics.rectangle ("fill",320,250,100,100)
            love.graphics.setColor(40/255, 45/255, 70/255, 255/255)
            love.graphics.print("2",350,270)
        end
        love.graphics.setColor(1,1,1,1)
        if mx>910 and mx <910+100 and my > 250 and my <250+100 then
            love.graphics.rectangle ("line",910,250,100,100)
            love.graphics.print("3",940,270)
        else
            love.graphics.rectangle ("fill",910,250,100,100)
            love.graphics.setColor(40/255, 45/255, 70/255, 255/255)
            love.graphics.print("3",940,270)     
        end
        love.graphics.setColor(1,1,1,1)

        -- THE TIME
        love.graphics.print("How much time do you want ",140,440)
        love.graphics.print("to play in seconds ?",250,520)

        --THE TEXTBOX IN SCENE 2
        love.graphics.rectangle ("line",600,620,100,100)
        love.graphics.setFont(textFont)
        suit.draw()

        if love.keyboard.isDown("return") and input.text ~= "" then
            GAME_STATE = "explantion"
            defineplayer3(PLAYERS_COUNTER)
            g = g+1
        end
    end
    if GAME_STATE == "explantion" and f == 1 then
        exImage = love.graphics.newImage("explanation.png")
        love.graphics.draw(exImage,0,0,0,1,1.185)
        GAME_TIME = tonumber(input.text)
        if love.keyboard.isDown("space") then
            GAME_STATE = "playing"
            corn_after = corn_timer.after(GAME_TIME, function () GAME_STATE = "win" end)
            f = f+1
        end
    end

end