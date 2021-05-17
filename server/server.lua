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
            table.insert(announces, {job = result[i]['job'], pic = result[i]['pic'], color = result[i]['color'], name = result[i]['name']})
        end
    end)
end

RegisterServerEvent("guille_anu:server:create")
AddEventHandler("guille_anu:server:create", function(job, pic, color, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "superadmin" then
        MySQL.Async.execute('INSERT INTO announces (job, pic, color, name) VALUES (@job, @pic, @color, @name)', {
            ['@job'] = job,
            ['@pic'] = pic, 
            ['@color'] = color,
            ['@name'] = name,
        })
    end
    Wait(5000)
    refresh()
end)

refresh()

ESX.RegisterServerCallback('guille_anu:getAnounce', function(source,cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    for i = 1, #announces, 1 do
        if announces[i]['job'] == xPlayer.job.name then
            cb(announces[i])
            break
        end
    end
end)

RegisterServerEvent("guille_anu:server:sendAnu")
AddEventHandler("guille_anu:server:sendAnu", function(pic, color, name, content)
    TriggerClientEvent("guille_an:server:syncAnounce", -1, pic, color, name, content)
end)
