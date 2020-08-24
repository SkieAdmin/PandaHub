print("Panda-Exploit is Loaded - Developed from Panda Technology")
local PanaHilixLoader = Instance.new("ScreenGui")
local intro = Instance.new("ImageLabel")
local name = Instance.new("TextLabel")


PanaHilixLoader.Name = "PanaHilixLoader"
PanaHilixLoader.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

intro.Name = "intro"
intro.Parent = PanaHilixLoader
intro.AnchorPoint = Vector2.new(0.5, 0.5)
intro.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
intro.BackgroundTransparency = 1.000
intro.ClipsDescendants = true
intro.Position = UDim2.new(0.499690443, 0, 2, 0)
intro.Size = UDim2.new(0, 424, 0, 78)
intro.Image = "rbxassetid://3570695787"
intro.ImageColor3 = Color3.fromRGB(52, 144, 235)
intro.ScaleType = Enum.ScaleType.Slice
intro.SliceCenter = Rect.new(100, 100, 100, 100)
intro.SliceScale = 0.060

name.Name = "name"
name.Parent = intro
name.AnchorPoint = Vector2.new(0.5, 0)
name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
name.BackgroundTransparency = 1.000
name.Position = UDim2.new(0.5, 0, 0.307692319, 0)
name.Size = UDim2.new(0, 200, 0, 29)
name.Font = Enum.Font.SourceSansSemibold
name.Text = ""
name.TextColor3 = Color3.fromRGB(255, 255, 255)
name.TextSize = 25.000
name.TextWrapped = true


repeat wait() until game:IsLoaded() 
	
local intro_frame = intro
local txt = "Panda-Ex S+ Loaded"
	
local function TweenText(TextLabel,Text)
	local Letters = #Text
	for i = 1,Letters,1 do
	    wait(0.05)
		TextLabel.Text = string.sub(Text,1,i)
	end
end
	
wait(1)
intro_frame:TweenPosition(UDim2.new(0.5, 0,0.5, 0),"Out","Quad",.3,true,function()
	wait(.2)
	TweenText(intro_frame.name,txt)
	wait(2.5)
	intro_frame:TweenPosition(UDim2.new(0.5, 0,2, 0),"Out","Quad",.5,true)
	wait(.6)
	PanaHilixLoader:Destroy()
end)
wait(5)
-- Gui to Lua
-- Version: 3

-- Instances:

local PandaLogo = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")

--Properties:

PandaLogo.Name = "PandaLogo"
PandaLogo.Parent = game.CoreGui
PandaLogo.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PandaLogo.ResetOnSpawn = false

Frame.Parent = PandaLogo
Frame.BackgroundColor3 = Color3.new(0.0588235, 0.686275, 0.94902)
Frame.BackgroundTransparency = 0.60000002384186
Frame.Position = UDim2.new(0, 0, 0.943073988, 0)
Frame.Size = UDim2.new(0, 240, 0, 45)

ImageLabel.Parent = Frame
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(9.53674316e-07, 0, 0, 0)
ImageLabel.Size = UDim2.new(0, 46, 0, 42)
ImageLabel.Image = "http://www.roblox.com/asset/?id=5179834402"

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.191666663, 0, 0.244444445, 0)
TextLabel.Size = UDim2.new(0, 165, 0, 20)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Powered by Panda Technology"
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14
TextLabel.TextWrapped = true
