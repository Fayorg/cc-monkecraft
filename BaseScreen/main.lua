dofile("api/Button.lua")
dofile("render.lua")
dofile("ButtonExecutor.lua")

mon = peripheral.wrap("left")
screenX, screenY = mon.getSize()

buttons = {
    Button:new(screenX-10,screenY-2,screenX,screenY,"Reboot",rebootButtonExecutor,true),
    Button:new(12,screenY-2,screenX-11,screenY,"Alarm",alarmButtonExecutor,true, colors.orange),
    Button:new(1,screenY-2,11,screenY,"Refresh",refreshButtonExecutor,true)
}

render()

while(true) do
    local event, side, x, y = os.pullEvent("monitor_touch")
    for i, btn in ipairs(buttons) do
        btn:check(x,y)
    end
end
