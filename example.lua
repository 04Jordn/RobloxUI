local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/04Jordn/RobloxUI/refs/heads/main/source.lua"))()
-- To toggle the UI, you can call: Library:Toggle()

local Window = Library:Window({
    text = "Hub"
})

local TabSection = Window:TabSection({
    text = "Main"
})

local Tab = TabSection:Tab({
    text = "Tab 1",
    icon = "rbxassetid://7999345313",
})

local Section = Tab:Section({
    text = "Controls"
})

Section:Button({
    text = "Button",
    callback = function()
        print("Button clicked")
    end,
})

Section:Toggle({
    text = "Toggle",
    state = false, -- Default state
    callback = function(state)
        print("Toggle state:", state)
    end,
})

Section:Slider({
    text = "Slider",
    min = 10,
    max = 100,
    callback = function(value)
        print("Slider value:", value)
    end,
})

Section:Dropdown({
    text = "Dropdown",
    list = {"Apple", "Banana", "Coconut"},
    default = "Apple",
    callback = function(choice)
        print("Dropdown selected:", choice)
    end,
})

Section:Textbox({
    text = "Textbox",
    value = "Default",
    callback = function(text)
        print("Textbox input:", text)
    end,
})

Section:Colorpicker({
    text = "Colorpicker",
    color = Color3.new(1, 1, 1),
    callback = function(color)
        print("Colorpicker color:", color)
    end,
})

Section:Keybind({
    text = "Keybind",
    default = Enum.KeyCode.Z,
    callback = function(key)
        print("Keybind triggered, key:", key)
    end,
})
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        Library:Toggle()
    end
end)
