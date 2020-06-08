-- Fluxus Library
-- Credit to its Respective Developer of this Library 
local sGui = Instance.new("ScreenGui")
sGui.Parent = game.CoreGui
sGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
sGui.Name = math.random(1, 99999999)
local uis = game:GetService("UserInputService")
local lib = {
    windows = 0;
}
local Mouse = game.Players.LocalPlayer:GetMouse()

lib.Options = {
    TextColor = Color3.fromRGB(255,255,255),
    Color1 = Color3.fromRGB(40,40,40),
    togON = Color3.fromRGB(47, 211, 47),
    togOFF = Color3.fromRGB(211, 47, 47);
}

local function getNextWindowPos()
	local biggest = 0;
	local ok = nil;
	for i,v in pairs(sGui:GetChildren()) do
		if v.Position.X.Offset>biggest then
			biggest = v.Position.X.Offset
			ok = v;
		end
	end
	if biggest == 0 then
		biggest = biggest + 5;
	else
		biggest = biggest + ok.Size.X.Offset + 5;
	end
	
	return biggest;
end

function lib:CreateWindow(title)
    lib.windows = lib.windows + 1;
    local Top = Instance.new("Frame", sGui)
    local Body = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Hide = Instance.new("ImageButton")
    local layout = Instance.new("UIListLayout", Body)
    local padding = Instance.new("UIPadding", Body)
    layout.Padding = UDim.new(0, 5)
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)
    padding.PaddingTop = UDim.new(0, 5)
    local instances = 0;
    local dragging = false;
    Top.Name = title
    Top.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
    Top.BorderSizePixel = 0
    Top.Active = true
    Top.Size = UDim2.new(0, 175, 0, 35)
    Top.Position = UDim2.new(0, getNextWindowPos() + 10, 0, 10)
    local dragging
	local dragInput
	local dragStart
	local startPos
	local function update(input)
		local delta = input.Position - dragStart
		Top:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), "Out", "Sine", 0.05, true)
	end
	Top.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Top.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	Top.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
    end)
    Body.Name = "Body"
    Body.Parent = Top
    Body.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0, 0, 1, 0)
    Body.ClipsDescendants = false
    Body.Size = UDim2.new(1, 0, 0, 5)
    
    Title.Name = "Title"
    Title.Parent = Top
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Font = "GothamSemibold"
    Title.Text = title or "new window"
    Title.TextSize = 18
    Title.TextColor3 = lib.Options.TextColor

    Hide.Name = "Hide"
    Hide.Parent = Top
    Hide.BackgroundTransparency = 1
    Hide.Size = UDim2.new(0, 20, 0, 20)
    Hide.Position = UDim2.new(1, -25, 0.5, -10)
    Hide.Image = "rbxassetid://4726772330"
    Hide.Rotation = 90
    Body.ClipsDescendants = true
    local pp;
    --local origsize;
    local open = true;
    Hide.MouseButton1Click:Connect(function()
        open = not open
        local a = game:GetService("TweenService"):Create(Hide, TweenInfo.new(0.2), {Rotation = (open and 90 or 0)})
        a:Play()
        local y = 0;
        for i, v in next, Body:GetChildren() do
            if (not v:IsA('UIListLayout')) and (not v:IsA("UIPadding")) then
                y = y + v.AbsoluteSize.Y;
            end
        end
        Body:TweenSize(open and UDim2.new(1, 0, 0, y+(5 * instances)+5) or UDim2.new(1, 0, 0, 0), "Out", "Sine", 0.2, true)
    end)
    local aaa = {}
    
    function aaa:Size()
        local y = 0;
        for i, v in next, Body:GetChildren() do
            if (not v:IsA('UIListLayout')) and(not v:IsA("UIPadding")) then
                y = y + v.AbsoluteSize.Y;
            end
        end 
        Body.Size = UDim2.new(1, 0, 0, y+(5 * instances)+5)
        pp = y;
    end

    function aaa:AddButton(title, callback)
        local Button = Instance.new("TextButton")
        Button.Name = "Button"
        Button.BackgroundTransparency = 1
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.ZIndex = 3
        Button.Font = "GothamSemibold"
        Button.Text = title
        Button.Parent = Body
        Button.TextSize = 14
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        instances = instances + 1
        local a = Instance.new("ImageLabel", Button)
        a.Position = UDim2.new(0.5, 0, 0.5, 0)
        a.Image = "rbxassetid://3570695787"
        a.Size = UDim2.new(1, 0, 1, 0)
        a.ZIndex = 1
        a.AnchorPoint = Vector2.new(0.5, 0.5)
        a.BackgroundTransparency = 1
        a.ImageTransparency = 0
        a.ImageColor3 = lib.Options.Color1
        a.ScaleType = "Slice"
        a.ClipsDescendants = true
        a.SliceCenter = Rect.new(100, 100, 100, 100)
        a.SliceScale = 0.05
        callback = callback or function() end
        self:Size()
        Button.MouseButton1Click:Connect(callback)
        
        Button.MouseEnter:Connect(function()
            a.ImageTransparency = 0.1;    
        end)
        Button.MouseLeave:Connect(function()
            a.ImageTransparency = 0;    
        end)
        Button.MouseButton1Down:Connect(function()
            --[[a.ImageTransparency = 0.3
            wait()
            a.ImageTransparency = 0]]
            local c = Instance.new("ImageLabel", a)
            c.BackgroundTransparency = 1
            c.Image = "rbxassetid://3570695787"
            c.ImageTransparency = 0.6
            c.Position = UDim2.new(0, (Mouse.X - c.AbsolutePosition.X), 0, (Mouse.Y - c.AbsolutePosition.Y))
            c.ScaleType = "Slice"
            c.SliceCenter = Rect.new(100, 100, 100, 100)
            c.SliceScale = 1
            local Size = 0
            if a.AbsoluteSize.X > a.AbsoluteSize.Y then
                Size = a.AbsoluteSize.X*1.5
            elseif a.AbsoluteSize.X < a.AbsoluteSize.Y then
                Size = a.AbsoluteSize.Y*1.5
            elseif a.AbsoluteSize.X == a.AbsoluteSize.Y then
                Size = a.AbsoluteSize.X*1.5
            end
            c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(.5, -Size/2, .5, -Size/2), "Out", "Linear", .5)
            Button.MouseButton1Up:Connect(function()
                while c.ImageTransparency ~= 1 do
                    wait()
                    c.ImageTransparency = c.ImageTransparency + 0.02
                    if c.ImageTransparency == 1 then c:Destroy() end
                end
            end)
        end)
    end

    function aaa:AddToggle(title, callback)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 35)
        label.BackgroundTransparency = 1
        label.TextColor3 = lib.Options.TextColor
        label.TextSize = 14
        label.Font = "GothamSemibold"
        label.Parent = Body
        label.TextXAlignment = "Left"
        label.Text = title
        instances = instances + 1
        local Button = Instance.new("TextButton")
        Button.Name = "Button"
        Button.BackgroundTransparency = 1
        Button.Size = UDim2.new(0, 25, 0, 25)
        Button.ZIndex = 3
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Position = UDim2.new(1, -25, 0.5, -13)
        Button.Text = ""
        Button.TextSize = 24
        Button.Font = "Garamond"
        Button.TextYAlignment = "Bottom"
        Button.TextTransparency = 0
        Button.Parent = label
        local a = Instance.new("ImageLabel", Button)
        a.Position = UDim2.new(0.5, 0, 0.5, 0)
        a.Image = "rbxassetid://3570695787"
        a.Size = UDim2.new(1, 0, 1, 0)
        a.ZIndex = 1
        a.AnchorPoint = Vector2.new(0.5, 0.5)
        a.BackgroundTransparency = 1
        a.ImageTransparency = 0
        a.ClipsDescendants = true
        a.ImageColor3 = lib.Options.Color1
        a.ScaleType = "Slice"
        a.SliceCenter = Rect.new(100, 100, 100, 100)
        a.SliceScale = 0.05
        a.ImageColor3 = lib.Options.Color1
        callback = callback or function() end
        self:Size()
        local tog = false;
        Button.MouseButton1Click:Connect(function()
            tog = not tog;
            callback()
            Button.Text = (tog and utf8.char(10005) or "")
            --a.ImageColor3 = (tog and lib.Options.togON or lib.Options.togOFF)
            --[[local b = game:GetService("TweenService"):Create(a, TweenInfo.new(0.2), {ImageColor3 = (tog and lib.Options.togON or lib.Options.togOFF)})
            local c = game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {TextTransparency = (tog and 0 or 1)})
            c:Play()
            b:Play()]]--
        end)
        
        Button.MouseEnter:Connect(function()
            a.ImageTransparency = 0.1;    
        end)
        Button.MouseLeave:Connect(function()
            a.ImageTransparency = 0;    
        end)
    end

    function aaa:AddSlider(title, min, max, startPoint, callback)
        instances = instances + 1
        local dragging = false;
        local label = Instance.new("TextLabel")
        local sliderFrame = Instance.new("ImageLabel")
        local slidingFrame = Instance.new("ImageLabel")
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, 0, 0, 35)
        label.BackgroundTransparency = 1
        label.TextColor3 = lib.Options.TextColor
        label.TextSize = 14
        label.Font = "GothamSemibold"
        label.Parent = Body
        label.TextXAlignment = "Left"
        label.Text = title
        sliderFrame.Name = "sliderFrame"
        sliderFrame.Parent = label
        sliderFrame.BackgroundTransparency = 1
        sliderFrame.Position = UDim2.new(1, -80, 0.5, -3)
        sliderFrame.Size = UDim2.new(0, 80, 0, 6)
        sliderFrame.Image = "rbxassetid://3570695787"
        sliderFrame.ImageColor3 = Color3.fromRGB(75, 75, 75)
        sliderFrame.ScaleType = "Slice"
        sliderFrame.SliceCenter = Rect.new(100, 100, 100, 100)
        slidingFrame.Name = "slidingFrame"
        slidingFrame.Parent = sliderFrame
        slidingFrame.BackgroundTransparency = 1
        slidingFrame.Position = UDim2.new((startPoint or 0)/max, -6, 0.5, -5)
        slidingFrame.Size = UDim2.new(0, 10, 0, 10)
        slidingFrame.Image = "rbxassetid://3570695787"
        slidingFrame.ScaleType = "Slice"
        slidingFrame.SliceCenter = Rect.new(100, 100, 100, 100)
        slidingFrame.ImageColor3 = Color3.fromRGB(255, 255, 255)
        local val = Instance.new("TextLabel", sliderFrame)
        val.BackgroundTransparency = 1
        val.Position = UDim2.new(0, 0, 1, 1)
        val.Size = UDim2.new(1, 0, 0, 10)
        val.Font = "GothamSemibold"
        val.TextColor3 = Color3.new(1, 1, 1)
        val.TextScaled = true
        val.TextTransparency = 1
        val.Text = tostring(startPoint and math.floor((startPoint / max) * (max - min) + min) or 0).."/"..tostring(max)
        self:Size()
        -- Dragging Function --
	    local function move(input)
	        local pos = UDim2.new(math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1), -6, 0.5, -5)
            slidingFrame:TweenPosition(pos, "Out", "Sine", 0.1, true);
            local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
            val.Text = tostring(value).."/"..tostring(max);
            callback(value)
	    end
	    slidingFrame.InputBegan:Connect(function(input)
	        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true;
                local b = game:GetService("TweenService"):Create(val, TweenInfo.new(0.2), {TextTransparency = 0})
                b:Play()
	        end
	    end)
	    slidingFrame.InputEnded:Connect(function(input)
	        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false;
                wait(1)
                local b = game:GetService("TweenService"):Create(val, TweenInfo.new(0.2), {TextTransparency = 1})
                b:Play()
	        end
	    end)
	    game:GetService("UserInputService").InputChanged:Connect(function(input)
	        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
	            move(input)
	        end
	    end)
	    -----------------------
    end
    return aaa
end
return lib;