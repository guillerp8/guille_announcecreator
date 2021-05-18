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
    xPlayer.showNotification('Creando el ~r~anuncio~w~, espera a que este creado')
    Wait(5000)
    refresh()
    xPlayer.showNotification('Anuncio para el job ~b~' ..job.. '~w~ creado correctamente')
end)

RegisterCommand("deleteannounce", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "superadmin" then
        local job = args[1]
        for i = 1, #announces, 1 do
            if announces[i]['job'] == job then
                announce = true
                MySQL.Async.execute('DELETE FROM announces WHERE job=@job ', {
                    ['@job'] = job,
                })
                xPlayer.showNotification('El anuncio del job ~b~' ..job..'~w~ se esta borrando...')
                Wait(5000)
                xPlayer.showNotification('El anuncio del job ~b~' ..job..'~w~ ha sido borrado')
                refresh()
                break
            end
        end
        if not announce then
            xPlayer.showNotification('No hay anuncios creados para ' ..job)
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
        xPlayer.showNotification('No hay anuncios creados para tu job ' ..xPlayer.job.name)
    end
end)

RegisterServerEvent("guille_anu:server:sendAnu")
AddEventHandler("guille_anu:server:sendAnu", function(pic, color, name, content)
    TriggerClientEvent("guille_an:server:syncAnounce", -1, pic, color, name, content)
end)

MySQL.ready(function()
    print("^4[guille_announcecreator]^0 Refreshing announces")
    refresh()
end)
