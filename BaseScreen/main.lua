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

local credit = "Base Screen";
local version = "v1.0.0"
local witespace = screenX - string.len(credit)  - string.len(version)
print("Credit : ", (string.len(credit) + string.len(version) + witespace), "/", screenX)
if witespace > 0 then
    mon.setBackgroundColor(colors.red)
    mon.setTextScale(0.5)
    mon.setCursorPos(1,1)
    mon.write(credit)
    for i = 1, witespace do
        mon.write(" ")
    end
    mon.write(version)
    mon.setTextScale(1)
    mon.setBackgroundColor(colors.black)
end

for i, btn in ipairs(buttons) do
    btn:draw(mon)
end

while(true) do
    local event, side, x, y = os.pullEvent("monitor_touch")
    for i, btn in ipairs(buttons) do
        btn:check(x,y)
    end
end
