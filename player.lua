player = Class{}

playerImage = love.graphics.newImage("imgs/Enemy8.png")
balls={}
enemies={}

function player:init(x,y,r,keyRight,keyLeft,keyShoot)
    self.x = x
    self.y = y
    self.width = 144
    self.hieght = 144
    self.score = 0
    self.r=r
    self.kr = keyRight
    self.kl = keyLeft
    self.kshoot = keyShoot
    self.move = false
    self.ballY = 0
    self.ballY = 0
    self.speedOriantation = 0
    self.red=0
end
time = 0
function player:update(d)
    if love.keyboard.isDown(self.kr)  then
        self.r = self.r+.05
    elseif love.keyboard.isDown(self.kl) then
        self.r = self.r-.05
    end
    self.updateBalls()
    time = time+.01
    if time>.2 then
        -- create a new enemy
        self.creatEnemy()
        
        time = 0
    else
    end
    self.updateEnemies()
    self.checkCollision()
    for index, enemy in ipairs(enemies) do
       local wid = playerImage:getWidth()/2
       local hi = playerImage:getHeight()/2
       if enemy.x >= self.x-wid and enemy.y >= self.y-hi and enemy.x <= self.x+wid and enemy.y <= self.y+hi  then
           if self.kshoot == "w" then
               score1 = score1 - enemy.score
            elseif self.kshoot == "up" then
                score3 = score3 - enemy.score
            elseif self.kshoot == "u" then
                score2 = score2 - enemy.score
           end
           table.remove(enemies,index)
           sounds["ship_hurt"]:play()
       end
    end
end
function player:creatEnemy()
    --enemy = {postionX, postionY, pic, whoKilledIt ???, scoreValue, speedX, speedY}
    local img = love.graphics.newImage("imgs/5.png")
    local ss = math.random(4)
    local xx = love.graphics.getWidth()/ss

    sXX =player:ranX(ss)*.5
    enemy = {x = xx , y = 0, pic = img, score = 5, sX = sXX, sY = math.random(4)/2,wid = img:getWidth(),hi = img:getHeight()}
    table.insert(enemies,enemy)
    enemy = {x = xx , y = 0, pic = img, score = 5, sX = sXX, sY = math.random(3)*2 ,wid = img:getWidth(),hi = img:getHeight()}
    table.insert(enemies,enemy)
    if math.random(2)==1 then
        local ss = math.random(2)
        local xx = love.graphics.getWidth()/ss
        local img = love.graphics.newImage("imgs/10.png")
        sXX = player:ranX(ss)*.5
        enemy = {x = xx , y = 0, pic = img, score = 10, sX = sXX, sY = math.random(2)*4 ,wid = img:getWidth(),hi = img:getHeight()}
        table.insert(enemies,enemy)
    else 
        local ss = math.random(2)
        local xx = love.graphics.getWidth()/ss
        local img = love.graphics.newImage("imgs/15.png")
        sXX = player:ranX(ss)*.5
        enemy = {x = xx , y = 0, pic = img, score = 15, sX = sXX, sY = math.random(3)/2 ,wid = img:getWidth(),hi = img:getHeight()}
        table.insert(enemies,enemy)
    end
    
end
function player:ranX(s)
    if s == 1 or s == 2 or s == 3 then
        return -math.random(3)*2
    else
        return math.random(3)*1.2
    end
end
function player:keypressed(k)
    if k== self.kshoot then
        player.move = true
        sounds['ship_shoot']:play() 
        self.creatBall(7,self.ballX,self.ballY,self.speedOriantation,self.kshoot)       
    end
end

function player:creatBall(x,y,rr,whoShoot)
    ball = {xPos = x, yPos = y , r = rr , who = whoShoot}
    table.insert(balls,ball)
    player.move = false   
end

function player:updateEnemies()
    for index, enemy in ipairs(enemies) do
        enemy.x = enemy.x + enemy.sX
        enemy.y = enemy.y + enemy.sY

        if enemy.x > love.graphics.getWidth() or enemy.x <0 or enemy.y >love.graphics.getHeight() or enemy.y <0 then
            --torpedo = nil -does not actually work-
            table.remove(enemies, index)
        end
    end
end
function player:updateBalls()
    for index, ball in ipairs(balls) do
        x = ball.xPos
        y = ball.yPos
        slope = math.tan(ball.r)
        
        --FIX THIS
            if ball.r == math.pi then ---
                ball.xPos = ball.xPos - 4----
            elseif slope == 0  then---
                if math.cos(ball.r)==1 then----
                    ball.xPos = ball.xPos + 4----
                end---
            elseif slope >0 and math.sin(ball.r)>0 then---
                ball.xPos = ball.xPos + 4  ---
                ball.yPos = (ball.xPos-x)*slope+ ball.yPos---
            elseif slope <0 and math.sin(ball.r)>0 then---
                ball.yPos = ball.yPos + 4  ---
                ball.xPos=((ball.yPos-y)/slope)+x---
            elseif slope >0 and math.sin(ball.r)<0 then---
                ball.xPos = ball.xPos - 4  ---
                ball.yPos = (ball.xPos-x)*slope+ ball.yPos---
            elseif slope <0 and math.sin(ball.r)<0 then---
                ball.yPos = ball.yPos - 4  ---
                ball.xPos=((ball.yPos-y)/slope)+x---
        end---
        -- FIXING AREA
        
        if ball.xPos > love.graphics.getWidth() or ball.xPos <0 or ball.yPos >love.graphics.getHeight() or ball.yPos <0 then
            --torpedo = nil -does not actually work-
            table.remove(balls, index)
        end
    end
    
end
function player:render()
    s = love.graphics.newFont(30)
    love.graphics.setFont(s)
    placeBallX = self.x+math.cos(self.r)*playerImage:getWidth()/2
    placeBallY = self.y + math.sin(self.r)*self.hieght *.5

    if self.move == false then
        self.speedOriantation = self.r
        self.ballX = placeBallX
        self.ballY = placeBallY

        --love.graphics.print(self.ballY,-200+self.ballX,-200+self.ballY)
        --love.graphics.print(self.ballX,50+self.ballX,50+self.ballY)
    end
    for index, ball in ipairs(balls) do
        --love.graphics.print(ball.yPos,100+ball.xPos,100+ball.yPos)
        if ball.who == "w" then
            love.graphics.setColor(0,0,1,1)
            love.graphics.circle("fill",ball.xPos+5,ball.yPos+5,7)
            love.graphics.setColor(1,1,1,1)
        elseif ball.who == "u" then
            love.graphics.setColor(0,1,0,1)
            love.graphics.circle("fill",ball.xPos+5,ball.yPos+5,7)
            love.graphics.setColor(1,1,1,1)
        elseif ball.who == "up" then
            love.graphics.setColor(1,0,0,1)
            love.graphics.circle("fill",ball.xPos+5,ball.yPos+5,7)
            love.graphics.setColor(1,1,1,1)
        end
        --love.graphics.circle("fill",ball.xPos+5,ball.yPos+5,7)
    end
    --THE ENEMIES
    for key, enemy in ipairs(enemies) do
        ratio = .15
        love.graphics.draw(enemy.pic,enemy.x,enemy.y,0,ratio,ratio)
    end
    
    
    if self.move == true then
         b =1  
        --self.move = false
    end
    if b==1 then
        love.graphics.circle("fill",self.ballX+5,self.ballY+5,9)
    end
    love.graphics.draw(playerImage,self.x,self.y,self.r,1,1,playerImage:getWidth()/2,playerImage:getHeight()/2)
    


end

function player:checkCollision()
   for key, enemy in ipairs(enemies) do
       for index, ball in ipairs(balls) do
           if ball.xPos>=enemy.x and ball.yPos>=enemy.y and ball.xPos<=enemy.x+enemy.wid*ratio and ball.yPos <= enemy.y+enemy.hi*ratio then
                if ball.who == "w" then
                   score1 = score1 + enemy.score
                elseif ball.who == "up" then
                    score3 = score3 + enemy.score                
                elseif ball.who == "u" then
                    score2 = score2 + enemy.score
                end
            sounds["score"]:play()
            table.remove(balls, index) 
            table.remove(enemies, key)          
           end
       end
       
   end
end



