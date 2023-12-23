function rebootButtonExecutor()
    local text = "Rebooting..."
    mon.clear()
    mon.setCursorPos(math.floor(screenX/2 - ((string.len(text)-3)/2)), math.floor(screenY/2))
    mon.write("Rebooting...")
    os.reboot()
    exit()
end

function refreshButtonExecutor()
    render()
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