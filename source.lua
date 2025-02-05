local Library = {}

local NeverloseVersion = "v1.1A."

local TweenService = game:GetService("TweenService")
local input = game:GetService("UserInputService")

-- Modern Dark / Purple theme colors
local theme = {
    Background      = Color3.fromRGB(25, 25, 25),         -- Main background (dark gray)
    Sidebar         = Color3.fromRGB(20, 20, 20),         -- Sidebar background
    Accent          = Color3.fromRGB(144, 0, 255),          -- Vibrant purple accent
    Text            = Color3.fromRGB(245, 245, 245),        -- Primary text (nearly white)
    TextSecondary   = Color3.fromRGB(200, 200, 200),        -- Secondary text color
    Button          = Color3.fromRGB(45, 45, 45),           -- Button base color
    ButtonHover     = Color3.fromRGB(65, 65, 65),           -- Button hover color
    Frame           = Color3.fromRGB(35, 35, 35),           -- Panels/sections background
}

-- Remove any previous instance of the UI
for i,v in next, game.CoreGui:GetChildren() do
    if v:IsA("ScreenGui") and v.Name == "Neverlose" then
        v:Destroy() 
    end
end

local themouse = game.Players.LocalPlayer:GetMouse()

local function Notify(tt, tx)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = tt,
        Text = tx,
        Duration = 5
    })
end

local function Dragify(frame, parent)
    parent = parent or frame

    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

local function round(num, bracket)
    bracket = bracket or 1
    local a = math.floor(num / bracket + (math.sign(num) * 0.5)) * bracket
    if a < 0 then
        a = a + bracket
    end
    return a
end

local function buttoneffect(options)
    pcall(function()
        options.entered.MouseEnter:Connect(function()
            if options.frame.TextColor3 ~= theme.Text then
                TweenService:Create(options.frame, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    TextColor3 = theme.Text
                }):Play()
            end
        end)
        options.entered.MouseLeave:Connect(function()
            if options.frame.TextColor3 ~= theme.TextSecondary and options.frame.TextColor3 ~= theme.Text then
                TweenService:Create(options.frame, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    TextColor3 = theme.TextSecondary
                }):Play()
            end
        end)
    end)
end

local function clickEffect(options)
    options.button.MouseButton1Click:Connect(function()
        local new = options.button.TextSize - tonumber(options.amount)
        local revert = new + tonumber(options.amount)
        TweenService:Create(options.button, TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {TextSize = new}):Play()
        wait(0.1)
        TweenService:Create(options.button, TweenInfo.new(0.1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {TextSize = revert}):Play()
    end)
end

function Library:Toggle(value)
    if game:GetService("CoreGui"):FindFirstChild("Neverlose") == nil then return end
    local enabled = (type(value) == "boolean" and value) or game:GetService("CoreGui"):FindFirstChild("Neverlose").Enabled
    game:GetService("CoreGui"):FindFirstChild("Neverlose").Enabled = not enabled
end

function Library:Window(options)
    options.text = options.text or "NEVERLOSE"

    local SG = Instance.new("ScreenGui")
    local Body = Instance.new("Frame")
    Dragify(Body, Body)
    local bodyCorner = Instance.new("UICorner")

    local SideBar = Instance.new("Frame")
    local sidebarCorner = Instance.new("UICorner")
    local sbLine = Instance.new("Frame")

    local TopBar = Instance.new("Frame")
    local tbLine = Instance.new("Frame")
    local Title = Instance.new("TextLabel")

    local allPages = Instance.new("Frame")
    local tabContainer = Instance.new("Frame")

    SG.Parent = game.CoreGui
    SG.Name = "Neverlose"

    Body.Name = "Body"
    Body.Parent = SG
    Body.AnchorPoint = Vector2.new(0.5, 0.5)
    Body.BackgroundColor3 = theme.Background
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0.4657, 0, 0.5, 0)
    Body.Size = UDim2.new(0, 658, 0, 516)

    bodyCorner.CornerRadius = UDim.new(0, 4)
    bodyCorner.Name = "bodyCorner"
    bodyCorner.Parent = Body

    SideBar.Name = "SideBar"
    SideBar.Parent = Body
    SideBar.BackgroundColor3 = theme.Sidebar
    SideBar.BorderSizePixel = 0
    SideBar.Size = UDim2.new(0, 187, 0, 516)

    sidebarCorner.CornerRadius = UDim.new(0, 4)
    sidebarCorner.Name = "sidebarCorner"
    sidebarCorner.Parent = SideBar

    sbLine.Name = "sbLine"
    sbLine.Parent = SideBar
    sbLine.BackgroundColor3 = theme.Accent
    sbLine.BorderSizePixel = 0
    sbLine.Position = UDim2.new(0.9949, 0, 0, 0)
    sbLine.Size = UDim2.new(0, 3, 0, 516)

    TopBar.Name = "TopBar"
    TopBar.Parent = Body
    TopBar.BackgroundColor3 = theme.Background
    TopBar.BackgroundTransparency = 1
    TopBar.BorderColor3 = theme.Accent
    TopBar.BorderSizePixel = 0
    TopBar.Position = UDim2.new(0.2517, 0, 0, 0)
    TopBar.Size = UDim2.new(0, 562, 0, 49)

    tbLine.Name = "tbLine"
    tbLine.Parent = TopBar
    tbLine.BackgroundColor3 = theme.Accent
    tbLine.BorderSizePixel = 0
    tbLine.Position = UDim2.new(0.04, 0, 1, 0)
    tbLine.Size = UDim2.new(0, 469, 0, 3)

    Title.Name = "Title"
    Title.Parent = SideBar
    Title.BackgroundTransparency = 1
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.0615, 0, 0.0213, 0)
    Title.Size = UDim2.new(0, 162, 0, 26)
    Title.Font = Enum.Font.ArialBold
    Title.Text = options.text
    Title.TextColor3 = theme.Text
    Title.TextSize = 28
    Title.TextWrapped = true

    allPages.Name = "allPages"
    allPages.Parent = Body
    allPages.BackgroundTransparency = 1
    allPages.BorderSizePixel = 0
    allPages.Position = UDim2.new(0.2951, 0, 0.1008, 0)
    allPages.Size = UDim2.new(0, 463, 0, 464)

    tabContainer.Name = "tabContainer"
    tabContainer.Parent = SideBar
    tabContainer.BackgroundTransparency = 1
    tabContainer.BorderSizePixel = 0
    tabContainer.Position = UDim2.new(0, 0, 0.1008, 0)
    tabContainer.Size = UDim2.new(0, 187, 0, 464)

    local tabsections = {}

    function tabsections:TabSection(options)
        options.text = options.text or "Tab Section"

        local tabLayout = Instance.new("UIListLayout")
        local tabSection = Instance.new("Frame")
        local tabSectionLabel = Instance.new("TextLabel")
        local tabSectionLayout = Instance.new("UIListLayout")

        tabLayout.Name = "tabLayout"
        tabLayout.Parent = tabContainer

        tabSection.Name = "tabSection"
        tabSection.Parent = tabContainer
        tabSection.BackgroundTransparency = 1
        tabSection.BorderSizePixel = 0
        tabSection.Size = UDim2.new(0, 189, 0, 22)

        local function ResizeTS(num)
            tabSection.Size = tabSection.Size + UDim2.new(0, 0, 0, num)
        end

        tabSectionLabel.Name = "tabSectionLabel"
        tabSectionLabel.Parent = tabSection
        tabSectionLabel.BackgroundTransparency = 1
        tabSectionLabel.BorderSizePixel = 0
        tabSectionLabel.Size = UDim2.new(0, 190, 0, 22)
        tabSectionLabel.Font = Enum.Font.Gotham
        tabSectionLabel.Text = "     " .. options.text
        tabSectionLabel.TextColor3 = theme.TextSecondary
        tabSectionLabel.TextSize = 17
        tabSectionLabel.TextXAlignment = Enum.TextXAlignment.Left

        tabSectionLayout.Name = "tabSectionLayout"
        tabSectionLayout.Parent = tabSection
        tabSectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        tabSectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabSectionLayout.Padding = UDim.new(0, 7)

        local tabs = {}

        function tabs:Tab(options)
            options.text = options.text or "New Tab"
            options.icon = options.icon or "rbxassetid://7999345313"

            local tabButton = Instance.new("TextButton")
            local tabButtonCorner = Instance.new("UICorner")
            local tabIcon = Instance.new("ImageLabel")

            local newPage = Instance.new("ScrollingFrame")
            local pageLayout = Instance.new("UIGridLayout")

            tabButton.Name = "tabButton"
            tabButton.Parent = tabSection
            tabButton.BackgroundColor3 = theme.Button
            tabButton.BorderSizePixel = 0
            tabButton.Size = UDim2.new(0, 165, 0, 30)
            tabButton.AutoButtonColor = false
            tabButton.Font = Enum.Font.GothamSemibold
            tabButton.Text = "         " .. options.text
            tabButton.TextColor3 = theme.Text
            tabButton.TextSize = 14
            tabButton.TextXAlignment = Enum.TextXAlignment.Left
            -- Make button visible by setting transparency to 0 and adding rounded corners:
            tabButton.BackgroundTransparency = 0
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = tabButton

            tabButton.MouseButton1Click:Connect(function()
                for i, v in next, allPages:GetChildren() do
                    v.Visible = false
                end

                newPage.Visible = true

                for i, v in next, SideBar:GetDescendants() do
                    if v:IsA("TextButton") then
                        TweenService:Create(v, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                            BackgroundTransparency = 1
                        }):Play()
                    end
                end

                TweenService:Create(tabButton, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    BackgroundTransparency = 0
                }):Play()
            end)

            tabButtonCorner.CornerRadius = UDim.new(0, 4)
            tabButtonCorner.Parent = tabButton

            tabIcon.Name = "tabIcon"
            tabIcon.Parent = tabButton
            tabIcon.BackgroundTransparency = 1
            tabIcon.BorderSizePixel = 0
            tabIcon.Position = UDim2.new(0.0409, 0, 0.1333, 0)
            tabIcon.Size = UDim2.new(0, 21, 0, 21)
            tabIcon.Image = options.icon
            tabIcon.ImageColor3 = theme.Accent

            newPage.Name = "newPage"
            newPage.Parent = allPages
            newPage.Visible = false
            newPage.BackgroundTransparency = 1
            newPage.BorderSizePixel = 0
            newPage.ClipsDescendants = false
            newPage.Position = UDim2.new(0.0216, 0, 0.0237, 0)
            newPage.Size = UDim2.new(0, 442, 0, 440)
            newPage.ScrollBarThickness = 4
            newPage.CanvasSize = UDim2.new(0, 0, 0, 0)

            pageLayout.Name = "pageLayout"
            pageLayout.Parent = newPage
            pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
            pageLayout.CellPadding = UDim2.new(0, 12, 0, 12)
            pageLayout.CellSize = UDim2.new(0, 215, 0, -10)
            pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                newPage.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y)
            end)

            ResizeTS(50)

            local sections = {}

            function sections:Section(options)
                options.text = options.text or "Section"

                local sectionFrame = Instance.new("Frame")
                local sectionLabel = Instance.new("TextLabel")
                local sectionFrameCorner = Instance.new("UICorner")
                local sectionLayout = Instance.new("UIListLayout")
                local sLine = Instance.new("TextLabel")
                local sectionSizeConstraint = Instance.new("UISizeConstraint")

                sectionFrame.Name = "sectionFrame"
                sectionFram
