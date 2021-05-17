ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

ESX.RegisterServerCallback('guille_an:server:checkAdmin', function(source,cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "superadmin" then
        cb(true)
    else
        cb(false)
    end
end)