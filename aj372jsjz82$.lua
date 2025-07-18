local P=game:GetService("Players")
local T=game:GetService("TweenService")
local U=game:GetService("UserInputService")
local Tp=game:GetService("TeleportService")
local H=game:GetService("HttpService")
local plr=P.LocalPlayer
local guiRoot=plr:WaitForChild("PlayerGui")
local allowed={["XxcrisxX3258"]=true,["jffjfjtjjjru"]=true,["User3"]=true}

if not allowed[plr.Name] then
 local g=Instance.new("ScreenGui",guiRoot)
 g.Name="AccessDenied"
 local f=Instance.new("Frame",g)
 f.Size=UDim2.new(0,400,0,150)
 f.AnchorPoint=Vector2.new(0.5,0.5)
 f.Position=UDim2.new(0.5,0,0.5,0)
 f.BackgroundColor3=Color3.new(0,0,0)
 f.BorderSizePixel=0
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,20)
 local t=Instance.new("TextLabel",f)
 t.Size=UDim2.new(1,-20,1,-20)
 t.Position=UDim2.new(0,10,0,10)
 t.BackgroundTransparency=1
 t.TextColor3=Color3.new(1,0,0)
 t.TextScaled=true
 t.Font=Enum.Font.GothamBold
 t.Text="Acceso denegado.\nNo tienes permiso para usar este script."
 t.TextWrapped=true
 return
end

local gui=Instance.new("ScreenGui",guiRoot)
gui.Name="SabScriptGUI"
gui.ResetOnSpawn=false

local af=Instance.new("Frame",gui)
af.Size=UDim2.new(0,450,0,180)
af.AnchorPoint=Vector2.new(0.5,0.5)
af.Position=UDim2.new(0.5,0,0.5,0)
af.BackgroundColor3=Color3.new(0,0,0)
af.BorderSizePixel=0
Instance.new("UICorner",af).CornerRadius=UDim.new(0,20)

local at=Instance.new("TextLabel",af)
at.Size=UDim2.new(0.9,0,0,80)
at.Position=UDim2.new(0.05,0,0,20)
at.BackgroundTransparency=1
at.Text="Bienvenido a AJAX-Hub.\n⚠ Estas usando el modo gratis del script."
at.TextColor3=Color3.new(1,1,1)
at.TextScaled=true
at.Font=Enum.Font.GothamBold
at.TextWrapped=true

local cb=Instance.new("TextButton",af)
cb.Size=UDim2.new(0,150,0,40)
cb.Position=UDim2.new(0.5,0,1,-60)
cb.AnchorPoint=Vector2.new(0.5,0.5)
cb.BackgroundColor3=Color3.fromRGB(0,200,0)
cb.TextColor3=Color3.new(1,1,1)
cb.Font=Enum.Font.GothamBold
cb.Text="Continuar"
cb.TextScaled=true
Instance.new("UICorner",cb).CornerRadius=UDim.new(0,10)

local snd=Instance.new("Sound",af)
snd.SoundId="rbxassetid://15666462"
snd.Volume=0.7

local lf=Instance.new("Frame",gui)
lf.Size=UDim2.new(0,350,0,200)
lf.AnchorPoint=Vector2.new(0.5,0.5)
lf.Position=UDim2.new(0.5,0,0.5,0)
lf.BackgroundColor3=Color3.new(0,0,0)
lf.BorderSizePixel=0
lf.Visible=false
Instance.new("UICorner",lf).CornerRadius=UDim.new(0,15)

local ll=Instance.new("TextLabel",lf)
ll.Size=UDim2.new(1,-40,0,40)
ll.Position=UDim2.new(0.5,0,0.5,-15)
ll.AnchorPoint=Vector2.new(0.5,0.5)
ll.BackgroundTransparency=1
ll.TextColor3=Color3.new(1,1,1)
ll.TextScaled=true
ll.Font=Enum.Font.GothamBold
ll.Text="Cargando script"

local ft=Instance.new("TextLabel",lf)
ft.Size=UDim2.new(1,-40,0,20)
ft.Position=UDim2.new(0.5,0,0.9,0)
ft.AnchorPoint=Vector2.new(0.5,0.5)
ft.BackgroundTransparency=1
ft.TextColor3=Color3.new(1,1,1)
ft.TextSize=14
ft.Font=Enum.Font.Gotham
ft.Text="Tarda unos segundos!"

local ld=Instance.new("TextLabel",lf)
ld.Size=UDim2.new(1,-40,0,50)
ld.Position=UDim2.new(0.5,0,0.5,0)
ld.AnchorPoint=Vector2.new(0.5,0.5)
ld.BackgroundTransparency=1
ld.TextColor3=Color3.new(1,1,1)
ld.TextScaled=true
ld.Font=Enum.Font.GothamBold
ld.Visible=false
ld.TextTransparency=1

local mb=Instance.new("TextLabel",lf)
mb.Size=UDim2.new(1,-40,0,30)
mb.Position=UDim2.new(0.5,0,0.75,0)
mb.AnchorPoint=Vector2.new(0.5,0.5)
mb.BackgroundTransparency=1
mb.TextColor3=Color3.new(1,1,1)
mb.TextScaled=true
mb.Font=Enum.Font.Gotham
mb.Visible=false
mb.TextTransparency=1

local dots,maxDots,runDots=0,3,true
spawn(function()
 while runDots do
  dots=(dots+1)%(maxDots+1)
  ll.Text="Cargando script"..string.rep(".",dots)
  wait(0.5)
 end
end)

local ajax=Instance.new("Frame",gui)
ajax.Size=UDim2.new(0,400,0,350)
ajax.AnchorPoint=Vector2.new(0.5,0.5)
ajax.Position=UDim2.new(0.5,0,0.5,0)
ajax.BackgroundColor3=Color3.new(0,0,0)
ajax.BorderSizePixel=0
ajax.Visible=false
ajax.Active=true
Instance.new("UICorner",ajax).CornerRadius=UDim.new(0,20)

local drag=false
local di,ds,sPos
local function update(i)
 local delta=i.Position-ds
 ajax.Position=UDim2.new(sPos.X.Scale,sPos.X.Offset+delta.X,sPos.Y.Scale,sPos.Y.Offset+delta.Y)
end

ajax.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
  drag=true
  ds=i.Position
  sPos=ajax.Position
  i.Changed:Connect(function()
   if i.UserInputState==Enum.UserInputState.End then drag=false end
  end)
 end
end)

ajax.InputChanged:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then di=i end
end)

U.InputChanged:Connect(function(i)
 if i==di and drag then update(i) end
end)

local title=Instance.new("TextLabel",ajax)
title.Size=UDim2.new(1,0,0,50)
title.Position=UDim2.new(0,0,0,10)
title.BackgroundTransparency=1
title.Text="AJAX Hub"
title.TextColor3=Color3.new(1,1,1)
title.TextScaled=true
title.Font=Enum.Font.GothamBold

local close=Instance.new("TextButton",ajax)
close.Size=UDim2.new(0,30,0,30)
close.Position=UDim2.new(1,-40,0,10)
close.Text="X"
close.BackgroundColor3=Color3.fromRGB(180,30,30)
close.TextColor3=Color3.new(1,1,1)
close.Font=Enum.Font.GothamBold
close.TextScaled=true
Instance.new("UICorner",close).CornerRadius=UDim.new(0,10)

local min=Instance.new("TextButton",ajax)
min.Size=UDim2.new(0,30,0,30)
min.Position=UDim2.new(1,-80,0,10)
min.Text="-"
min.BackgroundColor3=Color3.fromRGB(30,30,30)
min.TextColor3=Color3.new(1,1,1)
min.Font=Enum.Font.GothamBold
min.TextScaled=true
Instance.new("UICorner",min).CornerRadius=UDim.new(0,10)

local minBox=Instance.new("TextButton",gui)
minBox.Size=UDim2.new(0,40,0,40)
minBox.Position=UDim2.new(0,20,0.5,0)
minBox.BackgroundColor3=Color3.new(0,0,0)
minBox.TextColor3=Color3.new(1,1,1)
minBox.Text="A"
minBox.Font=Enum.Font.GothamBold
minBox.TextScaled=true
minBox.Visible=false
Instance.new("UICorner",minBox).CornerRadius=UDim.new(0,10)

local cBox=Instance.new("Frame",gui)
cBox.Size=UDim2.new(0,300,0,150)
cBox.AnchorPoint=Vector2.new(0.5,0.5)
cBox.Position=UDim2.new(0.5,0,0.5,0)
cBox.BackgroundColor3=Color3.new(0,0,0)
cBox.Visible=false
Instance.new("UICorner",cBox).CornerRadius=UDim.new(0,12)

local cLabel=Instance.new("TextLabel",cBox)
cLabel.Size=UDim2.new(1,-20,0.6,0)
cLabel.Position=UDim2.new(0.5,0,0.1,0)
cLabel.AnchorPoint=Vector2.new(0.5,0)
cLabel.Text="¿Estás seguro de que quieres cerrar?"
cLabel.TextColor3=Color3.new(1,1,1)
cLabel.Font=Enum.Font.Gotham
cLabel.TextScaled=true
cLabel.BackgroundTransparency=1

local yBtn=Instance.new("TextButton",cBox)
yBtn.Size=UDim2.new(0.4,0,0.25,0)
yBtn.Position=UDim2.new(0.1,0,0.7,0)
yBtn.BackgroundColor3=Color3.fromRGB(0,200,0)
yBtn.Text="Sí"
yBtn.TextColor3=Color3.new(1,1,1)
yBtn.Font=Enum.Font.GothamBold
yBtn.TextScaled=true
Instance.new("UICorner",yBtn).CornerRadius=UDim.new(0,8)

local nBtn=Instance.new("TextButton",cBox)
nBtn.Size=UDim2.new(0.4,0,0.25,0)
nBtn.Position=UDim2.new(0.5,0,0.7,0)
nBtn.BackgroundColor3=Color3.fromRGB(180,30,30)
nBtn.Text="No"
nBtn.TextColor3=Color3.new(1,1,1)
nBtn.Font=Enum.Font.GothamBold
nBtn.TextScaled=true
Instance.new("UICorner",nBtn).CornerRadius=UDim.new(0,8)

close.MouseButton1Click:Connect(function()
 ajax.Visible=false
 cBox.Visible=true
end)

yBtn.MouseButton1Click:Connect(function()
 gui:Destroy()
end)

nBtn.MouseButton1Click:Connect(function()
 cBox.Visible=false
 ajax.Visible=true
end)

min.MouseButton1Click:Connect(function()
 ajax.Visible=false
 minBox.Visible=true
end)

minBox.MouseButton1Click:Connect(function()
 ajax.Visible=true
 minBox.Visible=false
end)

local espBtn=Instance.new("TextButton",ajax)
espBtn.Size=UDim2.new(0,200,0,40)
espBtn.Position=UDim2.new(0,20,0,80)
espBtn.Text="ESP Usuarios"
espBtn.BackgroundColor3=Color3.fromRGB(40,40,40)
espBtn.TextColor3=Color3.new(1,1,1)
espBtn.Font=Enum.Font.GothamBold
espBtn.TextScaled=true
Instance.new("UICorner",espBtn).CornerRadius=UDim.new(0,10)

local espStatus=Instance.new("TextLabel",ajax)
espStatus.Size=UDim2.new(0,20,0,40)
espStatus.Position=UDim2.new(0,230,0,80)
espStatus.BackgroundTransparency=1
espStatus.Text="🔴"
espStatus.TextScaled=true
espStatus.Font=Enum.Font.GothamBold

local espOn=false
local espObjects,nameTags={},{}
local function toggleESP(s)
 for _,v in pairs(espObjects) do v:Destroy() end
 for _,v in pairs(nameTags) do v:Destroy() end
 table.clear(espObjects)
 table.clear(nameTags)
 if s then
  for _,p in pairs(P:GetPlayers()) do
   if p~=plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
    local hrp=p.Character.HumanoidRootPart
    local b=Instance.new("BoxHandleAdornment")
    b.Size=Vector3.new(4,6,2)
    b.Adornee=hrp
    b.AlwaysOnTop=true
    b.ZIndex=10
    b.Color3=Color3.new(0,1,0)
    b.Transparency=0.3
    b.Parent=hrp
    table.insert(espObjects,b)
    local tag=Instance.new("BillboardGui",p.Character)
    tag.Size=UDim2.new(0,100,0,30)
    tag.Adornee=hrp
    tag.AlwaysOnTop=true
    local lbl=Instance.new("TextLabel",tag)
    lbl.Size=UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency=1
    lbl.Text=p.Name
    lbl.TextColor3=Color3.new(0,1,0)
    lbl.TextScaled=true
    lbl.Font=Enum.Font.GothamBold
    table.insert(nameTags,tag)
   end
  end
 end
 espStatus.Text = s and "🟢" or "🔴"
end

espBtn.MouseButton1Click:Connect(function()
 espOn = not espOn
 toggleESP(espOn)
end)

local speedBtn=Instance.new("TextButton",ajax)
speedBtn.Size=UDim2.new(0,200,0,40)
speedBtn.Position=UDim2.new(0,20,0,140)
speedBtn.Text="Script Speed Boost"
speedBtn.BackgroundColor3=Color3.fromRGB(40,40,40)
speedBtn.TextColor3=Color3.new(1,1,1)
speedBtn.Font=Enum.Font.GothamBold
speedBtn.TextScaled=true
Instance.new("UICorner",speedBtn).CornerRadius=UDim.new(0,10)

speedBtn.MouseButton1Click:Connect(function()
 local s,e=pcall(function()
  loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-cframe-speed-31062"))()
 end)
 if not s then warn("Falló el script de Speed Boost: ",e) end
end)

local serverHopBtn=Instance.new("TextButton",ajax)
serverHopBtn.Size=UDim2.new(0,200,0,40)
serverHopBtn.Position=UDim2.new(0,20,0,200)
serverHopBtn.Text="Server Hop 🔄"
serverHopBtn.BackgroundColor3=Color3.fromRGB(40,40,40)
serverHopBtn.TextColor3=Color3.new(1,1,1)
serverHopBtn.Font=Enum.Font.GothamBold
serverHopBtn.TextScaled=true
Instance.new("UICorner",serverHopBtn).CornerRadius=UDim.new(0,10)

serverHopBtn.MouseButton1Click:Connect(function()
 local pId=game.PlaceId
 local s,r=pcall(function()
  return H:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..pId.."/servers/Public?sortOrder=Asc&limit=100"))
 end)
 if s and r and r.data then
  for _,sv in pairs(r.data) do
   if sv.playing<sv.maxPlayers then
    Tp:TeleportToPlaceInstance(pId,sv.id)
    break
   end
  end
 else warn("No se pudo obtener servidores para Server Hop.") end
end)

cb.MouseButton1Click:Connect(function()
 snd:Play()
 af.Visible=false
 lf.Visible=true
 wait(5)
 runDots=false
 ll.Visible=false
 ft.Visible=false
 ld.Text="Cargado!"
 ld.Visible=true
 mb.Text="Hecho por: top | imademyselfapromise"
 mb.Visible=true
 wait(2)
 lf.Visible=false
 ajax.Visible=true
end)
