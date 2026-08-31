local config = {}
config.modVersion = "1.0"
config.configPath = "HUD_Equipment"
config.BorderSize = 2
config.mcmDefault = {
    logLevel = 3,
    showOnlyForOnStrike = true,
    magicСhargeColor = true,
    SlotIconSize = 32,
    iconBackgroundAlpha = 60,
    iconBackgroundTexture = true,
    EnchantEffectIcons = false,
    effectIconStyle = "bigIcon",       -- "Icon" или "bigIcon"
    effectIconSize = 40,
    effectIconPositionX = 95,
    effectIconPositionY = 5,
    }
config.mcm = mwse.loadConfig(config.configPath, config.mcmDefault)
return config