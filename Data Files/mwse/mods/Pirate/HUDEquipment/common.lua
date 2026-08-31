local config = require("Pirate.HUDEquipment.config")
local cf = require("Pirate.HUDEquipment.config").mcm
local common = {}
local chargeBlockId = tes3ui.registerID("hud_equipment:chargeBlock")
local chargeFillbarId = tes3ui.registerID("hud_equipment:chargeFillbar")
local spacerWeaponId = tes3ui.registerID("hud_equipment:spacerWeapon")
local spacerMagicId = tes3ui.registerID("hud_equipment:spacerMagic")
local bgWeaponId = tes3ui.registerID("hud_equipment:bg_weapon_icon")
local bgMagicId = tes3ui.registerID("hud_equipment:bg_magic_icon")
local effectWeaponID = tes3ui.registerID("hud_equipment:effect_weapon_icon")
local effectMagicID = tes3ui.registerID("hud_equipment:effect_magic_icon")
local multiMenu = nil
local weaponLayout = nil
local weaponBorder = nil
local weaponEnchantmentIcon = nil
local weaponIcon = nil
local weaponFill = nil
local chargeBlock = nil
local chargeFillbar = nil
local spacerWeapon = nil
local bgWeapon = nil
local magicLayout = nil
local magicBorder = nil
local magicEnchantmentIcon = nil
local magicIcon = nil
local magicFill = nil
local spacerMagic = nil
local bgMagic = nil
local effectWeaponIcon = nil
local effectMagicIcon = nil
local lastEquipped

local function getEquippedWeapon()
    return tes3.getEquippedItem({ 
        actor = tes3.player, 
        objectType = tes3.objectType.weapon, 
        enchanted = true 
    })
end


function common.updateEnchIcon()
    if not multiMenu then return end

    if cf.iconBackgroundTexture then
        -- Включено: показываем иконку
        local weapon = getEquippedWeapon()
        if weapon then
            weaponEnchantmentIcon.visible = true
        else
            weaponEnchantmentIcon.visible = false
        end
        local currentSpell = tes3.mobilePlayer.currentSpell
        if currentSpell.objectType == tes3.objectType.enchantment then
            magicEnchantmentIcon.visible = true
        end
    else
        -- Выключено: всегда скрываем
        weaponEnchantmentIcon.visible = false
        magicEnchantmentIcon.visible = false
    end

    multiMenu:updateLayout()
end

function common.updateMagicСhargeColor()
    if not multiMenu then return end

    if cf.magicСhargeColor then
        magicFill.children[1].color = tes3ui.getPalette("magic_color")
    else
        local currentSpell = tes3.mobilePlayer.currentSpell
        if currentSpell.id then
            magicFill.children[1].color = tes3ui.getPalette("magic_fill_color")
        end
    end
    multiMenu:updateLayout()
end

function common.updateEffectIcon()
    local weapon = getEquippedWeapon()
    if cf.EnchantEffectIcons and weapon and weapon.object.enchantment.effects[1] then
        effectWeaponIcon.contentPath = "Icons\\"..weapon.object.enchantment.effects[1].object[cf.effectIconStyle]
        effectWeaponIcon.visible = true
        effectWeaponIcon.scaleMode = true
    else
        effectWeaponIcon.visible = false
    end
    local currentSpell = tes3.mobilePlayer.currentSpell
    if cf.EnchantEffectIcons and currentSpell and currentSpell.objectType == tes3.objectType.enchantment and currentSpell.effects[1] then
        effectMagicIcon.contentPath = "Icons\\"..currentSpell.effects[1].object[cf.effectIconStyle]
        effectMagicIcon.visible = true
        effectMagicIcon.scaleMode = true
    else
        effectMagicIcon.visible = false
    end

    multiMenu:updateLayout()
end

function common.updateSlotSettings()
    if not multiMenu then return end

    -- Размеры иконок
    local barWidth = cf.SlotIconSize + config.BorderSize * 2
    local barHeight = math.ceil(cf.SlotIconSize * 3 / 16)
    local borderMin = cf.SlotIconSize + config.BorderSize * 2

    -- слот оружия

    --if weaponLayout then
        --weaponLayout.autoWidth = true
        --weaponLayout.autoHeight = true
    --end
    if weaponBorder then
        --weaponBorder.autoWidth = true
        --weaponBorder.autoHeight = true
        weaponBorder.minWidth = borderMin
        weaponBorder.minHeight = borderMin
    end
    if bgWeapon then
        bgWeapon.alpha = cf.iconBackgroundAlpha / 100
        bgWeapon.width = cf.SlotIconSize
        bgWeapon.height = cf.SlotIconSize
    end

    if weaponEnchantmentIcon then
        weaponEnchantmentIcon.scaleMode = true
        weaponEnchantmentIcon.width = cf.SlotIconSize
        weaponEnchantmentIcon.height = cf.SlotIconSize
    end
    if weaponIcon then
        weaponIcon.scaleMode = true
        weaponIcon.width = cf.SlotIconSize
        weaponIcon.height = cf.SlotIconSize
    end
    if weaponFill then
        weaponFill.width = barWidth
        weaponFill.height = barHeight
    end
    if chargeFillbar then
        chargeFillbar.children[1].color = tes3ui.getPalette("magic_color")
        chargeFillbar.width = barWidth
        chargeFillbar.height = barHeight
    end
    if spacerWeapon then
        spacerWeapon.width = barWidth
        spacerWeapon.height = barHeight
    end

    -- слот магии

    --if magicLayout then
        --magicLayout.autoWidth = true
        --magicLayout.autoHeight = true
    --end
    if magicBorder then
        --magicBorder.autoWidth = true
        --magicBorder.autoHeight = true
        magicBorder.minWidth = borderMin
        magicBorder.minHeight = borderMin
    end
    if bgMagic then
        bgMagic.alpha = cf.iconBackgroundAlpha / 100
        bgMagic.width = cf.SlotIconSize
        bgMagic.height = cf.SlotIconSize
    end
    if magicEnchantmentIcon then
        magicEnchantmentIcon.scaleMode = true
        magicEnchantmentIcon.width = cf.SlotIconSize
        magicEnchantmentIcon.height = cf.SlotIconSize
    end
    if magicIcon then
        magicIcon.scaleMode = true
        magicIcon.width = cf.SlotIconSize
        magicIcon.height = cf.SlotIconSize
    end
    if magicFill then
        --magicFill.children[1].color = tes3ui.getPalette("magic_color")
        magicFill.width = barWidth
        magicFill.height = barHeight
    end
    if spacerMagic then
        spacerMagic.width = barWidth
        spacerMagic.height = barHeight
    end

    if effectWeaponIcon then
        effectWeaponIcon.scaleMode = true
        --effectWeaponIcon.borderAllSides = config.BorderSize
        effectWeaponIcon.width = cf.SlotIconSize*(cf.effectIconSize/100)
        effectWeaponIcon.height = cf.SlotIconSize*(cf.effectIconSize/100)
        effectWeaponIcon.absolutePosAlignX = cf.effectIconPositionX/100
        effectWeaponIcon.absolutePosAlignY = cf.effectIconPositionY/100
    end

    if effectMagicIcon then
        effectMagicIcon.scaleMode = true
        --effectMagicIcon.borderAllSides = config.BorderSize
        effectMagicIcon.width = cf.SlotIconSize*(cf.effectIconSize/100)
        effectMagicIcon.height = cf.SlotIconSize*(cf.effectIconSize/100)
        effectMagicIcon.absolutePosAlignX = cf.effectIconPositionX/100
        effectMagicIcon.absolutePosAlignY = cf.effectIconPositionY/100
    end

    common.updateEnchIcon()
    common.updateEffectIcon()
    common.updateMagicСhargeColor()
    multiMenu:updateLayout()
end

local function createNewElement(e)
    if not e.newlyCreated then return end

    multiMenu = e.element
    weaponLayout = multiMenu:findChild(tes3ui.registerID("MenuMulti_weapon_layout"))
    weaponBorder = weaponLayout:findChild(tes3ui.registerID("MenuMulti_weapon_border"))
    weaponEnchantmentIcon = weaponBorder:findChild(tes3ui.registerID("MenuMulti_enchantment_icon"))
    weaponIcon = weaponBorder:findChild(tes3ui.registerID("MenuMulti_weapon_icon"))
    weaponFill = weaponLayout:findChild(tes3ui.registerID("MenuMulti_weapon_fill"))
    magicLayout = multiMenu:findChild(tes3ui.registerID("MenuMulti_magic_layout"))
    magicBorder = magicLayout:findChild(tes3ui.registerID("MenuMulti_magic_border"))
    magicEnchantmentIcon = magicBorder:findChild(tes3ui.registerID("MenuMulti_enchantment_icon"))
    magicIcon = magicBorder:findChild(tes3ui.registerID("MenuMulti_magic_icon"))
    magicFill = magicLayout:findChild(tes3ui.registerID("MenuMulti_magic_fill"))

    -- настройка прозрачности и размера для слота оружия
    weaponLayout.alpha = 0
    weaponLayout.autoWidth = true
    weaponLayout.autoHeight = true
    weaponBorder.autoWidth = true
    weaponBorder.autoHeight = true
    bgWeapon = weaponBorder:createRect{ id = bgWeaponId }
    bgWeapon.color = {0.0, 0.0, 0.0}
    bgWeapon.scaleMode = true
    bgWeapon.absolutePosAlignX = 0.5
    bgWeapon.absolutePosAlignY = 0.5
    weaponBorder:reorderChildren(0, bgWeapon, 1)
    -- шкала заряда для оружия с зачарованием "при ударе"
    chargeBlock = weaponLayout:createBlock{ id = chargeBlockId }
    chargeBlock.autoWidth = true
    chargeBlock.autoHeight = true
    chargeBlock.flowDirection = "top_to_bottom"
    chargeFillbar = chargeBlock:createFillBar{ id = chargeFillbarId }
    chargeFillbar.widget.fillColor = tes3ui.getPalette("magic_color")
    chargeFillbar.widget.showText = false
    -- иконка эффекта для зачарованного оружия
    effectWeaponIcon = weaponBorder:createImage { id = effectWeaponID }
    effectWeaponIcon.borderAllSides = config.BorderSize
    effectWeaponIcon.visible = false
    -- Невидимый блок для выравнивания по вертикали
    spacerWeapon = chargeBlock:createBlock({ id = spacerWeaponId })
    -- настройка прозрачности и размера для слота магии
    magicLayout.alpha = 0
    magicLayout.autoWidth = true
    magicLayout.autoHeight = true
    magicBorder.autoWidth = true
    magicBorder.autoHeight = true
    bgMagic = magicBorder:createRect{ id = bgMagicId }
    bgMagic.color = {0.0, 0.0, 0.0}
    bgMagic.scaleMode = true
    bgMagic.absolutePosAlignX = 0.5
    bgMagic.absolutePosAlignY = 0.5
    magicBorder:reorderChildren(0, bgMagic, 1)
    -- иконка эффекта для зачарованных предметов и свитков
    effectMagicIcon = magicBorder:createImage { id = effectMagicID }
    effectMagicIcon.borderAllSides = config.BorderSize
    effectMagicIcon.visible = false
    -- Невидимый блок для выравнивания по вертикали
    spacerMagic = magicLayout:createBlock({ id = spacerMagicId })

    common.updateSlotSettings()
end
event.register("uiActivated", createNewElement, { filter = "MenuMulti" })

local function update()
    if not tes3.player then return end
    if not multiMenu then return end

    local weapon = getEquippedWeapon()
    if weapon then
        local castType = weapon.object.enchantment.castType
        local showChargeFillbar = false

        if cf.showOnlyForOnStrike then
            showChargeFillbar = castType == tes3.enchantmentType.onStrike
        else
            showChargeFillbar = castType == tes3.enchantmentType.onStrike or castType == tes3.enchantmentType.onUse
        end

        if showChargeFillbar then
            lastEquipped = true
            if chargeFillbar then
                chargeFillbar.visible = true
                chargeFillbar.widget.max = weapon.object.enchantment.maxCharge
                chargeFillbar.widget.current = weapon.variables and weapon.variables.charge or weapon.object.enchantment.maxCharge
            end
            if spacerWeapon then
                spacerWeapon.visible = false
            end
        elseif lastEquipped then
            lastEquipped = false
            if chargeFillbar then
                chargeFillbar.visible = false
            end
            if spacerWeapon then
                spacerWeapon.visible = true
            end
        end
    else
        -- Нет зачарованного оружия
        if lastEquipped then
            lastEquipped = false
            if chargeFillbar then
                chargeFillbar.visible = false
            end
            if spacerWeapon then
                spacerWeapon.visible = true
            end
        end
    end
    -- обновление цвета шкалы заряда слота магии. без обновления каждый кадр не работает.
    if magicFill then
        if cf.magicСhargeColor then
        magicFill.children[1].color = tes3ui.getPalette("magic_color")
        end
    end
    -- скрытие фона для иконок зачарованных предметов. без обновления каждый кадр не работает.
    if not cf.iconBackgroundTexture then
        weaponEnchantmentIcon.visible = false
        magicEnchantmentIcon.visible = false
    end

common.updateEffectIcon()
end
event.register("enterFrame", update)

event.register("equipped", common.updateEffectIcon)
event.register("unequipped", common.updateEffectIcon)

event.register("loaded", function()
    --Reset when loaded
    lastEquipped = true
end)

return common