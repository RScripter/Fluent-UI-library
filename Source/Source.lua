-- Create a ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the UI library table
local uiLibrary = {}
uiLibrary.tabs = {}
uiLibrary.currentTab = nil
uiLibrary.screenGui = screenGui
uiLibrary.isVisible = true

-- Function to create a window
function uiLibrary:MakeWindow(windowInfo)
    local windowName = windowInfo.Name

    -- Create the title label above the main frame
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.75, 0, 0.1, 0) -- Match main frame width
    titleLabel.Position = UDim2.new(0.25, 0, 0.05, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleLabel.BackgroundTransparency = 0.5
    titleLabel.Text = windowName
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.TextSize = 14
    titleLabel.BorderSizePixel = 2
    titleLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Parent = screenGui

    -- Create the tabs label above the tabs frame
    local tabsLabel = Instance.new("TextLabel")
    tabsLabel.Size = UDim2.new(0.2, 0, 0.1, 0)
    tabsLabel.Position = UDim2.new(0.025, 0, 0.15, 0)
    tabsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tabsLabel.BackgroundTransparency = 0.5
    tabsLabel.Text = "Tabs"
    tabsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabsLabel.TextScaled = true
    tabsLabel.TextSize = 14
    tabsLabel.BorderSizePixel = 2
    tabsLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
    tabsLabel.Parent = screenGui

    -- Create the main Scrolling Frame
    local mainFrame = Instance.new("ScrollingFrame")
    mainFrame.Size = UDim2.new(0.75, 0, 0.7, 0) -- Adjusted width to fit within the window
    mainFrame.Position = UDim2.new(0.25, 0, 0.15, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.5
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
    mainFrame.ScrollBarThickness = 10
    mainFrame.Parent = screenGui

    -- Create the Scrolling Frame on the left side (Tabs Frame)
    local leftFrame = Instance.new("ScrollingFrame")
    leftFrame.Size = UDim2.new(0.2, 0, 0.7, 0) -- Adjusted to match the height of mainFrame
    leftFrame.Position = UDim2.new(0.025, 0, 0.15, 0) -- Adjusted to align with tabsLabel
    leftFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    leftFrame.BackgroundTransparency = 0.5
    leftFrame.BorderSizePixel = 2
    leftFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    leftFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Adjusted for proper UIListLayout functionality
    leftFrame.ScrollBarThickness = 10
    leftFrame.Parent = screenGui

    -- Create UIListLayout for the leftFrame
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = leftFrame
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Store references for future use
    uiLibrary.leftFrame = leftFrame
    uiLibrary.mainFrame = mainFrame

    return {mainFrame = mainFrame, leftFrame = leftFrame}
end

-- Function to add a new tab
function uiLibrary:addTab(tabInfo)
    local tabName = tabInfo.Name

    -- Create the tab button
    local newTabButton = Instance.new("TextButton")
    newTabButton.Size = UDim2.new(1, 0, 0.1, 0)
    newTabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    newTabButton.BackgroundTransparency = 0.5
    newTabButton.Text = tabName
    newTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    newTabButton.TextScaled = true
    newTabButton.TextSize = 14
    newTabButton.TextStrokeTransparency = 0
    newTabButton.BorderSizePixel = 2
    newTabButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
    newTabButton.Parent = self.leftFrame

    -- Create a frame for the tab content
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.ScrollBarThickness = 10
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.Parent = self.mainFrame

    -- Add UIListLayout for proper positioning
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = tabContent
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Show the content when the tab is clicked
    newTabButton.MouseButton1Click:Connect(function()
        if uiLibrary.currentTab then
            uiLibrary.currentTab.Visible = false
        end
        tabContent.Visible = true
        uiLibrary.currentTab = tabContent
    end)

    -- Hide the tab content initially
    tabContent.Visible = false

    -- Store the tab content
    uiLibrary.tabs[tabName] = tabContent
end

-- Function to add a button to a tab
function uiLibrary:addButton(buttonInfo)
    local tabName = buttonInfo.TabName
    local buttonName = buttonInfo.Name
    local buttonFunction = buttonInfo.Function
    
    local tabContent = uiLibrary.tabs[tabName]
    if not tabContent then
        warn("Tab not found: " .. tabName)
        return
    end

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0.1, 0) -- Size similar to tab buttons
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.BackgroundTransparency = 0.5
    button.Text = buttonName
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.TextSize = 14
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = tabContent

    -- Update tab content size
    tabContent.CanvasSize = UDim2.new(0, 0, 0, tabContent.UIListLayout.AbsoluteContentSize.Y)
    
    button.MouseButton1Click:Connect(buttonFunction)

    -- Ensure CanvasSize updates when new elements are added
    tabContent.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.CanvasSize = UDim2.new(0, 0, 0, tabContent.UIListLayout.AbsoluteContentSize.Y)
    end)
end

-- Function to add a label to a tab
function uiLibrary:addLabel(labelInfo)
    local tabName = labelInfo.TabName
    local labelName = labelInfo.Name
    
    local tabContent = uiLibrary.tabs[tabName]
    if not tabContent then
        warn("Tab not found: " .. tabName)
        return
    end

    -- Create a TextLabel for the tab
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0.1, 0) -- Size similar to tab buttons
    label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    label.BackgroundTransparency = 0.5
    label.Text = labelName
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.TextSize = 14
    label.BorderSizePixel = 2
    label.BorderColor3 = Color3.fromRGB(255, 255, 255)
    label.Parent = tabContent

    -- Update tab content size
    tabContent.CanvasSize = UDim2.new(0, 0, 0, tabContent.UIListLayout.AbsoluteContentSize.Y)
    
    -- Ensure CanvasSize updates when new elements are added
    tabContent.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.CanvasSize = UDim2.new(0, 0, 0, tabContent.UIListLayout.AbsoluteContentSize.Y)
    end)
end

return uiLibrary
