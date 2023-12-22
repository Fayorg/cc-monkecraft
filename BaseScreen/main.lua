dofile("api/Button.lua")

local mon = peripheral.wrap("left")
buttons = {}
local screenX, screenY = mon.getSize()

function rebootButtonExecutor()
    local text = "Rebooting..."
    mon.clear()
    mon.setCursorPos(math.floor(screenX/2 - ((string.len(text)-3)/2)), math.floor(screenY/2))
    mon.write("Rebooting...")
    os.reboot()
    exit()
end

function refreshButtonExecutor()
    mon.clear()
    for i, btn in ipairs(buttons) do
        btn:draw(mon)
    end
end

function alarmButtonExecutor()
    if not redstone.getOutput("top") then
        redstone.setOutput("top", true)
        buttons[2]:draw(mon, colors.red)
    else
        redstone.setOutput("top", false)
        buttons[2]:draw(mon)
    end
end

buttons[1] = Button:new(screenX-10,screenY-2,screenX,screenY,"Reboot",rebootButtonExecutor,true)
buttons[2] = Button:new(12,screenY-2,screenX-11,screenY,"Alarm",alarmButtonExecutor,true, colors.orange)
buttons[3] = Button:new(1,screenY-2,11,screenY,"Refresh",refreshButtonExecutor,true)


mon.clear()

for i, btn in ipairs(buttons) do
    btn:draw(mon)
end

local credit = "Made with love by Fayorg - github.com/fayorg";
local version = "v1.0.0"
mon.setBackgroundColor(colors.red)
mon.setCursorPos(1,1)
mon.write(credit)
for i = 1, screenX - string.len(credit)  - string.len(version) do
    mon.write(" ")
end

while(true) do
    local event, side, x, y = os.pullEvent("monitor_touch")
    for i, btn in ipairs(buttons) do
        btn:check(x,y)
    end
end
