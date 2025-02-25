local engine = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()
local ts = game:GetService("TweenService")
local win = engine:Window("FTF Cheat")
local main = win:Server("Flee the Fuckility","")
local debug = win:Server("Debug","")
local esp = main:Channel("ESP")
local plr = main:Channel("Player")
local ui = main:Channel("UI")
local abo = main:Channel("About")
local mt = {t="Alpha",v="1.0",b="10"}

abo:Label("UI Library: DiscordLib")
abo:Label("Made by sankx_SK")
abo:Label("Version: "..mt.t.." "..mt.v.." | Build "..mt.b)

function tween(a,b,c)task.spawn(function()ts:Create(a,b,c):Play()end)end

function pchighlightcolor(high,color)
    if color == Color3.fromRGB(40,127,71) then
        task.spawn(function()
            high.FillColor = Color3.new(1,0,0)
            local TWINFPCESP = TweenInfo.new(5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
            tween(high,TWINFPCESP,{FillTransparency=1})
            task.wait(TWINFPCESP.Time/2)
            tween(high,TWINFPCESP,{OutlineTransparency=1})
            task.wait(TWINFPCESP.Time+(TWINFPCESP.Time/2))
            high.Enabled = false
        end)
    else
        high.FillColor = color
    end
end
function exithighlightcolor(high,rot)
    if rot.Y ~= 0 then
        high.FillColor = Color3.new(1,0,0)
    end
end

local pcespon
local pcesplights = {}
local exiton
local exitlights = {}
local hammeron
local hammerlight
function PCesp(bool)
    if bool then
        pcespon = coroutine.create(function()
            for i, v in workspace:GetDescendants() do
                if v:IsA("Model") and v.Name == "ComputerTable" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",v)
                        table.insert(pcesplights,light)
                        task.wait(1)
                        local screen = v:FindFirstChild("Screen")
                        if screen then
                            pchighlightcolor(light,screen.Color)
                            screen:GetPropertyChangedSignal("Color"):Connect(function()
                                pchighlightcolor(light,screen.Color)
                            end)
                        end
                    end)
                end 
            end
            workspace.DescendantAdded:Connect(function(ins)
                if ins:IsA("Model") and ins.Name == "ComputerTable" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",ins)
                        table.insert(pcesplights,light)
                        task.wait(1)
                        local screen = ins:FindFirstChild("Screen")
                        if screen then
                            pchighlightcolor(light,screen.Color)
                            screen:GetPropertyChangedSignal("Color"):Connect(function()
                                pchighlightcolor(light,screen.Color)
                            end)
                        end
                    end)
                end 
            end)
        end)
        coroutine.resume(pcespon)
    else
        coroutine.close(pcespon)
        for i, v in pcesplights do
            if v:IsA("Highlight") then
                v:Destroy()
            end
        end
    end
end
function EXITesp(bool)
    if bool then
        exiton = coroutine.create(function()
            for i, v in workspace:GetDescendants() do
                if v:IsA("Model") and v.Name == "ExitDoor" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",v)
                        table.insert(exitlights,light)
                        light.FillColor = Color3.new(1,1,0)
                    end)
                end 
            end
            workspace.DescendantAdded:Connect(function(ins)
                if ins:IsA("Model") and ins.Name == "ExitDoor" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",ins)
                        table.insert(exitlights,light)
                        light.FillColor = Color3.new(1,1,0)
                    end)
                end 
            end)
        end)
        coroutine.resume(exiton)
    else
        coroutine.close(exiton)
        for i, v in exitlights do
            if v:IsA("Highlight") then
                v:Destroy()
            end
        end
    end
end
function BEASTesp(bool)
    if bool then
        hammeron = coroutine.create(function()
            for i, v in workspace:GetDescendants() do
                if v:IsA("Model") and v.Name == "Hammer" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",v.Parent)
                        hammerlight=light
                        light.FillColor = Color3.new(1,0.5,0)
                        v.Destroying:Connect(function()
                            light:Destroy()
                        end)
                    end)
                end 
            end
            workspace.DescendantAdded:Connect(function(ins)
                if ins:IsA("Model") and ins.Name == "Hammer" then
                    task.spawn(function()
                        local light = Instance.new("Highlight",ins.Parent)
                        hammerlight=light
                        light.FillColor = Color3.new(1,0.5,0)
                        ins.Destroying:Connect(function()
                            light:Destroy()
                        end)
                    end)
                end 
            end)
        end)
        coroutine.resume(hammeron)
    else
        coroutine.close(hammeron)
        if hammerlight:IsA("Highlight") then
            hammerlight:Destroy()
        end
    end
end

local PCswitch = esp:Toggle("Computer",false,function(b)PCesp(b)end)
local EXITswitch = esp:Toggle("Exit",false,function(b)EXITesp(b)end)
local BEASTswitch = esp:Toggle("Beast",false,function(b)BEASTesp(b)end)
