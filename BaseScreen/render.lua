function render()
    mon.clear()

    for i, btn in ipairs(buttons) do
        btn:draw(mon)
    end
end