
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoPressGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")


local popupFrame = Instance.new("Frame")
popupFrame.Size = UDim2.new(0, 250, 0, 100)
popupFrame.Position = UDim2.new(0.5, -125, 0.5, -50)
popupFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
popupFrame.Active = true
popupFrame.Draggable = true
popupFrame.Parent = screenGui


local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 200, 0, 40)
textButton.Position = UDim2.new(0.5, -100, 0, 10)
textButton.Text = "Toggle AutoPress"
textButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
textButton.Parent = popupFrame


local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 200, 0, 40)
textLabel.Position = UDim2.new(0.5, -100, 0, 60)
textLabel.Text = "Current Letter: None"
textLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
textLabel.Parent = popupFrame


local autoPressEnabled = false
local sb = workspace:WaitForChild("SelectionBox")
local vim = game:GetService("VirtualInputManager")


textButton.MouseButton1Click:Connect(function()
    autoPressEnabled = not autoPressEnabled
    textButton.Text = autoPressEnabled and "AutoPress Enabled" or "AutoPress Disabled"
end)


game:GetService("RunService").RenderStepped:Connect(function()
    if autoPressEnabled then
        pcall(function()
            if sb.Adornee and sb.Adornee ~= workspace.Baseplate then
                local keyText = sb.Adornee:FindFirstChild("SurfaceGui") and sb.Adornee.SurfaceGui:FindFirstChild("TextLabel") and sb.Adornee.SurfaceGui.TextLabel.Text or " "
                local key = keyText ~= " " and keyText:upper() or "Space"
                textLabel.Text = "Current Letter: " .. key
                vim:SendKeyEvent(true, Enum.KeyCode[key], false, nil)
                wait()
                vim:SendKeyEvent(false, Enum.KeyCode[key], false, nil)
            else
                textLabel.Text = "Current Letter: None"
            end
        end)
    else
        textLabel.Text = "Current Letter: None"
    end
end)
