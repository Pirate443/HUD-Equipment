local i18n = mwse.loadTranslations("Pirate.HUDEquipment")
local config = require("Pirate.HUDEquipment.config")
local common = require("Pirate.HUDEquipment.common")
local log = mwse.Logger.new{
    modName = i18n("mcm.modname"),
    level   = config.mcm.logLevel
}
require("Pirate.HUDEquipment.mcm")
------------

------------
local function initialized()

    log:info("Version: "..config.modVersion.." Initialized!")
end event.register("initialized", initialized)