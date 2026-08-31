local i18n = mwse.loadTranslations("Pirate.HUDEquipment")
local config = require("Pirate.HUDEquipment.config")
local common = require("Pirate.HUDEquipment.common")
local log = mwse.Logger.new()

local LINKS_LIST = {
    {
        text = i18n("mcm.Nexus"),
        url = " "
    },
    --{
        --text = i18n("mcm.FullRest"),
        --url = " "
    --},
    --{
        --text = i18n("mcm.TESAll"),
        --url = " "
    --},
}
local CREDITS_LIST = {
    {
        text = i18n("mcm.Pirate"),
        url = "https://next.nexusmods.com/profile/Pirate443?gameId=100",
    },
    {
        text = i18n("mcm.Virnetch"),
        url = "https://www.nexusmods.com/profile/Virnetch",
    },
}
local function addSideBar(component)
    component.sidebar:createCategory(i18n("mcm.modname")..i18n("mcm.version")..config.modVersion)
    component.sidebar:createInfo{ text = i18n("mcm.ModDescription") }

    local linksCategory = component.sidebar:createCategory(i18n("mcm.Links"))
    for _, link in ipairs(LINKS_LIST) do
        linksCategory:createHyperLink{ text = link.text, url = link.url }
        end
    local creditsCategory = component.sidebar:createCategory(i18n("mcm.Credits"))
    for _, credit in ipairs(CREDITS_LIST) do
        if credit.url then
            creditsCategory:createHyperLink{ text = credit.text, url = credit.url }
        else
            creditsCategory:createInfo{ text = credit.text }
        end
    end
end

local function registerMCM()
    local template = mwse.mcm.createTemplate{ name = i18n("mcm.modname"),
    --headerImagePath = "textures/headerImageName.dds"
    }
    template.onClose = function ()
        mwse.saveConfig(config.configPath, config.mcm)
        common.updateSlotSettings()
    end
    --template:saveOnClose(config.configPath, config.mcm)
    template:register()
        
    local page = template:createSideBarPage {
        label = i18n("mcm.generalSettings"),
        showReset = true,
        showDefaultSetting = true }
    addSideBar(page)

    local fillBarСat = page:createCategory{
        label = i18n("mcm.fillBarСat.label"),
        description = i18n("mcm.fillBarСat.desc"),
    }

    fillBarСat:createOnOffButton {
        label = i18n("mcm.weaponСharge.OnOff.label"),
        description = i18n("mcm.weaponСharge.OnOff.desc"),
        defaultSetting = config.mcmDefault.showOnlyForOnStrike,
        restartRequired = false,
        variable = mwse.mcm.createTableVariable{ id = "showOnlyForOnStrike", table = config.mcm }
    }

    fillBarСat:createOnOffButton {
        label = i18n("mcm.magicСharge.OnOff.label"),
        description = i18n("mcm.magicСharge.OnOff.desc"),
        defaultSetting = config.mcmDefault.magicСhargeColor,
        restartRequired = false,
        variable = mwse.mcm.createTableVariable{ id = "magicСhargeColor", table = config.mcm },
        callback = function()
            common.updateMagicСhargeColor()
        end
    }

    local category1 = page:createCategory{
        label = i18n("mcm.category1.label"),
        description = i18n("mcm.category1.desc"),
    }

    category1:createSlider{
        label = i18n("mcm.SloticonSize.label"),
        description = i18n("mcm.SloticonSize.desc"),
        defaultSetting = config.mcmDefault.SlotIconSize,
        restartRequired = false,
        max = 96,
        min = 20,
        step = 1,
        jump = 10,
        variable = mwse.mcm:createTableVariable{ id = "SlotIconSize", table = config.mcm },
        callback = function()
            common.updateSlotSettings()
        end
    }

    category1:createSlider{
        label = i18n("mcm.icon.BgAlpha.label") .. " %s%%",
        description = i18n("mcm.icon.BgAlpha.desc"),
        defaultSetting = config.mcmDefault.iconBackgroundAlpha,
        restartRequired = false,
        min = 0,
        max = 100,
        step = 1,
        jump = 10,
        variable = mwse.mcm.createTableVariable{ id = "iconBackgroundAlpha", table = config.mcm },
        callback = function()
            common.updateSlotSettings()
        end
    }

    category1:createOnOffButton {
        label = i18n("mcm.icon.BgTexture.label"),
        description = i18n("mcm.icon.BgTexture.desc"),
        defaultSetting = config.mcmDefault.iconBackgroundTexture,
        restartRequired = false,
        variable = mwse.mcm.createTableVariable{ id = "iconBackgroundTexture", table = config.mcm },
        callback = function()
            common.updateEnchIcon()
        end
    }

    local effectIconCategory = page:createCategory{
    label = i18n("mcm.effectIconCategory.label"),
    description = i18n("mcm.effectIconCategory.desc"),
    }

    effectIconCategory:createOnOffButton {
        label = i18n("mcm.effectIcon.Enchant.label"),
        description = i18n("mcm.effectIcon.Enchant.desc"),
        defaultSetting = config.mcmDefault.EnchantEffectIcons,
        restartRequired = false,
        variable = mwse.mcm.createTableVariable{ id = "EnchantEffectIcons", table = config.mcm },
        callback = function()
            common.updateEffectIcon()
        end
    }

    effectIconCategory:createDropdown {
        label = i18n("mcm.effectIcon.Style.label"),
        description = i18n("mcm.effectIcon.Style.desc"),
        defaultSetting = config.mcmDefault.effectIconStyle,
        options  = {
            { label = i18n("mcm.effectIcon.Style.icon"), value = "icon" },
            { label = i18n("mcm.effectIcon.Style.bigIcon"), value = "bigIcon" },
        },
        variable = mwse.mcm:createTableVariable {
            id    = "effectIconStyle",
            table = config.mcm
        },
        callback = function()
            common.updateEffectIcon()
        end
    }

    effectIconCategory:createSlider{
        label = i18n("mcm.effectIcon.Size.label") .. " %s%%",
        description = i18n("mcm.effectIcon.Size.desc"),
        defaultSetting = config.mcmDefault.effectIconSize,
        min = 0,
        max = 50,
        step = 1,
        jump = 5,
        variable = mwse.mcm.createTableVariable{id = "effectIconSize", table = config.mcm},
        callback = function()
            common.updateSlotSettings()
        end
    }

    effectIconCategory:createSlider{
        label = i18n("mcm.effectIcon.PosX.label") .. " %s",
        description = i18n("mcm.effectIcon.PosX.desc"),
        defaultSetting = config.mcmDefault.effectIconPositionX,
        min = 0,
        max = 100,
        step = 1,
        jump = 10,
        variable = mwse.mcm.createTableVariable{id = "effectIconPositionX", table = config.mcm},
        callback = function()
            common.updateSlotSettings()
        end
    }

    effectIconCategory:createSlider{
        label = i18n("mcm.effectIcon.PosY.label") .. " %s",
        description = i18n("mcm.effectIcon.PosY.desc"),
        defaultSetting = config.mcmDefault.effectIconPositionY,
        min = 0,
        max = 100,
        step = 1,
        jump = 10,
        variable = mwse.mcm.createTableVariable{id = "effectIconPositionY", table = config.mcm},
        callback = function()
            common.updateSlotSettings()
        end
    }

    --[[local miscSetting = page:createCategory{
    label = i18n("mcm.miscSetting.label"),
    description = i18n("mcm.miscSetting.desc"),
    }

    miscSetting:createLogLevelOptions{
        defaultSetting = config.mcmDefault.logLevel,
        variable = mwse.mcm.createTableVariable{id = "logLevel", table = config.mcm},
        callback = function(self)
            log.level = self.variable.value
        end
    }]]

end
event.register("modConfigReady", registerMCM)