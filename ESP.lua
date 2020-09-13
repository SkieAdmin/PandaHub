local Synapse = syn and true or false
local Panda = PANDA_LOADED and true or false

if Synapse or Panda then
-- Script Here
local OwlESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SkieAdmin/PandaHub/master/OwlESP.lua"))();

local players = game:GetService("Players");
local runService = game:GetService("RunService");
local localPlayer = players.LocalPlayer;
local tracking = {};

local remove = table.remove;
local fromRGB = Color3.fromRGB;

function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end
counter = 0
local espColor = fromRGB(255,0,0);
local teamCheck = false;

local function characterRemoving(char)
    for i, v in next, tracking do
        if v.char == char then
            v:remove();
            remove(tracking, i);
        end;
    end;
end;

local function characterAdded(plr)
    local char = plr.Character;
    char:WaitForChild("HumanoidRootPart"); char:WaitForChild("Head");
    tracking[#tracking + 1] = OwlESP.new({
        plr = plr,
        espBoxVisible = true,
        tracerVisible = true,
        text = plr.Name,
        teamCheck = teamCheck,
        espColor = espColor,
    });
end;

for i, v in next, players:GetPlayers() do
    if v ~= localPlayer then
        local char = v.Character;
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Head") then
            tracking[#tracking + 1] = OwlESP.new({
                plr = v,
                espBoxVisible = true,
                tracerVisible = true,
                text = v.Name,
                teamCheck = teamCheck,
                espColor = espColor
            });
        end;
        v.CharacterAdded:Connect(function()
            characterAdded(v);
        end);
        v.CharacterRemoving:Connect(characterRemoving);
    end;
end;

local function playerAdded(plr)
    plr.CharacterAdded:Connect(function()
        characterAdded(plr);
    end);
    plr.CharacterRemoving:Connect(characterRemoving);
end;

players.PlayerAdded:Connect(playerAdded);

runService.RenderStepped:Connect(function()
    for i, v in next, tracking do
        v:update();
    end;
end);
-- Script Here
else
warn("[ Panda Information ] - Exploit Unsupported [ Unidentified Exploit ]")
game.StarterGui:SetCore("SendNotification", {
Title = "Error"; -- the title (ofc)
Text = "This Exploit isn't Compatible to this Script"; 
})
end
