if (not getgenv().WLKey) then return warn("Missing key!") end

script_key = getgenv().WLKey

if (not game:IsLoaded()) then
    game.Loaded:Wait()
end

local CheckCompatibility = function(Table)
    local executor = tostring(identifyexecutor())
    if Table["All"] then return true end
    
    if table.find(Table, executor) then
        return true
    end
    
    cloneref(game:GetService("Players")).LocalPlayer:Kick("Executor not compatible with MTX Client.")
end

local LoadScript = function(Source, Script)
    return loadstring(game:HttpGet(Source..Script..".lua"), Script)()
end

local GetGameInformation = function()
    for Id, Information in pairs(getgenv().MTXClient_LoaderSettings.Games) do
        if tostring(game.PlaceId) == Id then
            return Information
        end
    end
    
    cloneref(game:GetService("Players")).LocalPlayer:Kick("This game is not supported by MTX Client.")
    return false
end

getgenv().MTXClient_LoaderSettings = {
    ["Source"] = "https://raw.githubusercontent.com/MTXClient/MTX-Client/main/",
    ["Games"] = {
        ["2788229376"] = {Name = "Da Hood", Script = "Games/DH"},
    },

    ["Executors"] = {
         ["All"] = true,
         ["NX 1.0"] = true,
         ["Solara"] = true,
    },
};

-- // Checker
do
    CheckCompatibility(MTXClient_LoaderSettings.Executors)
    MTXClient_LoaderSettings.Game = GetGameInformation()
    if MTXClient_LoaderSettings.Game then LoadScript(MTXClient_LoaderSettings.Source, MTXClient_LoaderSettings.Game.Script) else
    print("Join Game Supported Please!")
  end
end
