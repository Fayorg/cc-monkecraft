-- os.loadAPI("test2.lua")

dofile("test2.lua")

local mon = peripheral.wrap("left")
local x,y = mon.getSize()

function pressBtn()
    print("Button 1 pressed")
    btn2:toggle()
end

function pressBtn2()
    print("Button 2 pressed")
end

btn = Button:new(1, 1, 7, 3, "test", pressBtn, true)
btn2 = Button:new(x - 6, 1, x, 3, "test 2", pressBtn2, true)

mon.clear()

btn:draw(mon, 2)
btn2:draw(mon, 2)

while(true) do
    event, d, x, y = os.pullEvent("monitor_touch")
    btn:check(x,y)
    btn2:check(x,y)
end
