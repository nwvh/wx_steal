
-- Function that returns if player can be searched
local function canOpenTarget(ped) -- https://github.com/overextended/ox_inventory/blob/46462a02d61b86cbe1d2e81670d35d3635d165d1/client.lua#L69C1-L77C4
	return IsPedFatallyInjured(ped)
    or IsPedDeadOrDying(ped)
	or IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3)
	or IsPedCuffed(ped)
	or IsEntityPlayingAnim(ped, 'mp_arresting', 'idle', 3)
	or IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_base', 3)
	or IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_enter', 3)
	or IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3)
end

-- [ Options table for the target ]
local options = {
	{
		name = 'wx_steal:main',
		distance = 2,
		icon = wx.Options.targetIcon,
		label = wx.Options.targetText,

        -- You may uncomment this function to automatically hide the target if player cannot be searched (is not dead etc...)

		-- canInteract = function (entity)
		-- 	canOpenTarget(entity)
		-- 	return false
		-- end,

		onSelect = function (data)
            if canOpenTarget(data.entity) then
				TriggerServerEvent('wx_steal:showNotif',GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
                -- [ Check if progress bar is enabled ]
                if wx.Progress then
                    if lib.progressBar({
                        duration = wx.ProgressLength,
                        label = wx.Options.progressText,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                            move = true,
                            combat = true,
                        },
                        anim = {
                            dict = 'anim@gangops@facility@servers@bodysearch@',
                            clip = 'player_search'
                        },

                    }) then
                        -- [ OX Inventory export used to open nearby player's inventory ]
                        exports.ox_inventory:openNearbyInventory()
                    else
                        -- [ If player cancels the progress bar ]
                        lib.notify({
                            title = wx.Options.notifyTitle,
                            description = wx.Options.notifyCancelled,
                            type = 'error',
                            position = 'top'
                        })
                    end
                else
                    exports.ox_inventory:openNearbyInventory()
                end
            else
                -- [ If player cannot be searched throw an error ]
                lib.notify({
                    title = wx.Options.notifyTitle,
                    description = wx.Options.notifyUnavailable,
                    type = 'error',
                    position = 'top'
                })
            end
		end
	},
}

-- [ Apply the options for all players ]
exports.ox_target:addGlobalPlayer(options)
