RegisterNetEvent('wx_steal:showNotif')
AddEventHandler('wx_steal:showNotif',function (pid)
	TriggerClientEvent('ox_lib:notify', pid, {
		description = "You are being searched..."
	})
end)
