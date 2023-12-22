Button = { active=true, color=colors.red }

function Button:new(x,y,x2,y2,text,onPress,active, color)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.x = x
    o.y = y
    o.x2 = x2
    o.y2 = y2
    o.text = text
    o.onPress = onPress
    o.active = active
    o.color = color or colors.red
    return o
end

function Button:toggle()
    if self.active then
        self.active = false
    else
        self.active = true
    end
end

function Button:check(x, y)
    if not self.active then
        return
    end
    if y >= self.y and y <= self.y2 then
        if x >= self.x and x <= self.x2 then
            self.onPress()
        end
    end
end

function Button:isActive()
    return self.active
end

function Button:draw(mon, color)
    mon.setBackgroundColor(color)
    yspot = math.floor((self.y + self.y2) /2)
    xspot = math.floor((self.x2 - self.x - string.len(self.text)) /2) +1
    
    for j = self.y, self.y2 do
        mon.setCursorPos(self.x,j)
        if j == yspot then
            for k = 0, self.x2 - self.x - string.len(self.text) + 1 do
                if k == xspot then
                    mon.write(self.text)
                else
                    mon.write(" ")
                end
            end
        else
            for i = self.x, self.x2 do
                mon.write(" ")
            end
        end
    end
    mon.setBackgroundColor(colors.black) 
end
