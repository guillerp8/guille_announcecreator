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

local announces = {}

function refresh()
    MySQL.Async.fetchAll("SELECT * FROM announces", {}, function(result)
        announces = {}
        for i = 1,#result, 1 do
            table.insert(announces, {job = result[i]['job'], pic = result[i]['pic'], color = result[i]['color'], name = result[i]['name'], colorbar = result[i]['colorbar'], titlecolor = result[i]['titlecolor']})
        end
    end)
end

RegisterServerEvent("guille_anu:server:create")
AddEventHandler("guille_anu:server:create", function(job, pic, color, name, colorbar, titlecolor)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "superadmin" then
        MySQL.Async.execute('INSERT INTO announces (job, pic, color, name, colorbar, titlecolor) VALUES (@job, @pic, @color, @name, @colorbar, @titlecolor)', {
            ['@job'] = job,
            ['@pic'] = pic, 
            ['@color'] = color,
            ['@name'] = name,
            ['@colorbar'] = colorbar,
            ['@titlecolor'] = titlecolor,
        })
    end
    xPlayer.showNotification('Creating the ~r~ad~w~, wait for it to be created')
    Wait(5000)
    refresh()
    xPlayer.showNotification('Job ad ~b~'..job ..'~w~ created correctly')
end)

RegisterCommand(Config['deletecommand'], function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local announce = false
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "superadmin" then
        local job = args[1]
        for i = 1, #announces, 1 do
            if announces[i]['job'] == job then
                announce = true
                MySQL.Async.execute('DELETE FROM announces WHERE job=@job ', {
                    ['@job'] = job,
                })
                xPlayer.showNotification('The ad for the job ~b~' ..job..'~w~ is being deleted...')
                Wait(5000)
                xPlayer.showNotification('The ad for the job ~b~' ..job..'~w~ has been deleted')
                refresh()
                break
            end
        end
        if not announce then
            xPlayer.showNotification('No ads created for the job ~r~' ..job)
        end
    end
end)

ESX.RegisterServerCallback('guille_anu:getAnounce', function(source,cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local announce = false
    for i = 1, #announces, 1 do
        if announces[i]['job'] == xPlayer.job.name then
            announce = true
            cb(announces[i])
            break
        end
    end
    if not announce then
        xPlayer.showNotification('There are no ads created for your job ' ..xPlayer.job.name)
    end
end)

RegisterServerEvent("guille_anu:server:sendAnu")
AddEventHandler("guille_anu:server:sendAnu", function(pic, color, name, content, colorbar, titlecolor)
    TriggerClientEvent("guille_an:server:syncAnounce", -1, pic, color, name, content, colorbar, titlecolor)
end)

MySQL.ready(function()
    print("^4[guille_announcecreator]^0 Refreshing announces")
    refresh()
    SetConvarServerInfo("guille_announcecreator", "Developed by guillerp")
    if GetCurrentResourceName() == resourceName then
		function checkVersion(error, latestVersion, headers)
			local currentVersion = Config['scriptversion']           
			if tonumber(currentVersion) < tonumber(latestVersion) then
				print(name .. " ^1is outdated.\nCurrent version: ^8" .. currentVersion .. "\nNewest version: ^2" .. latestVersion .. "\n^3Update^7: https://github.com/guillerp8/guille_announcecreator")
			elseif tonumber(currentVersion) > tonumber(latestVersion) then
				print(name .. " has skipped the latest version ^2" .. latestVersion .. ". Either Github is offline or the version file has been changed")
			else
				print(name .. " is updated.")
			end
		end
	
		PerformHttpRequest("https://raw.githubusercontent.com/guillerp8/jobcreatorversion/ma/announceversion", checkVersion, "GET")
	end
end)

-- https://github.com/Project-Entity/pe-hud/blob/main/server/version_sv.lua


local name = "^4[guille_announcecreator]^7"

AddEventHandler('onResourceStart', function(resourceName)
	if GetCurrentResourceName() == resourceName then
		function checkVersion(error, latestVersion, headers)
			local currentVersion = Config['scriptversion']           
			if tonumber(currentVersion) < tonumber(latestVersion) then
				print(name .. " ^1is outdated.\nCurrent version: ^8" .. currentVersion .. "\nNewest version: ^2" .. latestVersion .. "\n^3Update^7: https://github.com/guillerp8/guille_announcecreator")
			elseif tonumber(currentVersion) > tonumber(latestVersion) then
				print(name .. " has skipped the latest version ^2" .. latestVersion .. ". Either Github is offline or the version file has been changed")
			else
				print(name .. " is updated.")
			end
		end
	
		PerformHttpRequest("https://raw.githubusercontent.com/guillerp8/jobcreatorversion/ma/announceversion", checkVersion, "GET")
	end
end)

-- https://github.com/Project-Entity/pe-hud/blob/main/server/version_sv.lua