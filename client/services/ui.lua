-- The Vue-based HUD (ui/ folder) that shows player info/PVP toggle/locale
-- switch. Opened via the Config.UI.command chat command or Config.UI.hotkey
-- keybind (registered in UIAPI.Setup, called from client/main.lua).
--
-- Data (character economy/XP, PVP state, locales) lives in feather-core and
-- is reached through the framework's cross-resource export, not duplicated
-- here -- see client/imports.lua (`Feather = exports['feather-core'].initiate()`).
UIAPI = {}
UIState = false

-- Shows/hides the HUD, sending it a fresh snapshot of the active character,
-- XP config, PVP state, and locale strings each time it opens.
function UIAPI.ToggleUI()
    print('ToggleUI Called')
    ActiveCharacter = Feather.RPC.CallAsync("GetCharacter", {})
    if ActiveCharacter == nil or ActiveCharacter == {} then
        print("No active character found")
        return
    end

    print('Character is active. Open UI')

    UIState = not UIState
    SendNUIMessage({
        type = 'toggle',
        visible = UIState,
        player = ActiveCharacter,
        config = {
            xp = Feather.Config.XP
        },
        pvp = Feather.PVP.active,
        locale = Feather.Locale.translations
    })
end

RegisterNUICallback('updatestate', function(args, nuicb)
    UIState = args.state
    SetNuiFocus(UIState, UIState)
    nuicb('ok')
    print('Menu Close')
end)

RegisterNUICallback('updatelocale', function(args, nuicb)
    ActiveCharacter = Feather.RPC.CallAsync("UpdatePlayerLang", args.locale, function() end)
    -- (CORE-17) Keep LocalesAPI's client-side language cache in sync
    -- immediately instead of leaving it stale until the next spawn. Synced
    -- from the server's response (what it actually persisted) rather than
    -- args.locale directly, since UpdatePlayerLang silently rejects unknown
    -- languages and leaves the character's lang unchanged in that case.
    if ActiveCharacter then
        Feather.Locale.SetClientLang(ActiveCharacter.lang)
    end
    nuicb('ok')
end)

RegisterNUICallback('togglepvp', function(args, nuicb)
    Feather.PVP:togglePVP()
    nuicb('ok')
end)

function UIAPI.Setup()
    Feather.Command.Register(Config.UI.command, Config.UI.suggestion, function()
        print('Menu Command Issued')
        UIAPI.ToggleUI()
    end)

    Feather.Keys:RegisterListener(Config.UI.hotkey, function()
        print('Page Up Pressed')
        UIAPI.ToggleUI()
    end)
end
