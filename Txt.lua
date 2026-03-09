local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleButton = Instance.new("ImageButton")
local MusicButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local Sound = Instance.new("Sound")

-- Cấu hình ID của bạn
local ICON_ID = "rbxassetid://100723301472598"
local MUSIC_ID = "rbxassetid://110919391228823"

-- Cài đặt ScreenGui
ScreenGui.Name = "HiruMenu"
ScreenGui.Parent = game.CoreGui -- Hoặc PlayerGui nếu chạy trong Studio
ScreenGui.ResetOnSpawn = false

-- Nút mở Menu (Icon)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Image = ICON_ID

-- Menu chính (Mặc định ẩn)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

-- Bo góc cho Menu
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim unit.new(0, 10)
UICorner.Parent = MainFrame

-- Tiêu đề
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "HiruScript Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1

-- Nút Phát Nhạc
MusicButton.Parent = MainFrame
MusicButton.Position = UDim2.new(0.1, 0, 0.3, 0)
MusicButton.Size = UDim2.new(0.8, 0, 0, 30)
MusicButton.Text = "🎵 Phát Nhạc"
MusicButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MusicButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Nút Đóng
CloseButton.Parent = MainFrame
CloseButton.Position = UDim2.new(0.1, 0, 0.6, 0)
CloseButton.Size = UDim2.new(0.8, 0, 0, 30)
CloseButton.Text = "❌ Đóng Menu"
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Cài đặt âm thanh
Sound.Parent = MainFrame
Sound.SoundId = MUSIC_ID
Sound.Volume = 1
Sound.Looped = true

-- Chức năng đóng/mở
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Chức năng phát nhạc
local isPlaying = false
MusicButton.MouseButton1Click:Connect(function()
    if not isPlaying then
        Sound:Play()
        MusicButton.Text = "🐿 Stop Nhạc"
        isPlaying = true
    else
        Sound:Stop()
        MusicButton.Text = "🎵 Phát Nhạc"
        isPlaying = false
    end
end)

-- Cho phép kéo Menu (Draggable)
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
