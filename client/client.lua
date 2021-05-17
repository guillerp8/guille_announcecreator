ESX = nil 

Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0) 
    end 
end)

RegisterCommand("createannounce", function(source, args)
    ESX.TriggerServerCallback('guille_an:server:checkAdmin', function(result)
        if result then
            createAnnounce()   
        else
            ESX.ShowNotification('No eres administrador')
        end
    end)
end, false)

local job = nil
local foto = nil
local color = nil
local name = nil

function createAnnounce()
    local elements = {}

    if job == nil then
        table.insert(elements, {label = "Job", value = "job"})
    else
        table.insert(elements, {label = "Job: " ..job, value = "job"})
    end

    if foto == nil then
        table.insert(elements, {label = "Foto", value = "pic"})
    else
        table.insert(elements, {label = "Foto: " ..foto, value = "pic"})
    end

    if color == nil then
        table.insert(elements, {label = "Color", value = "color"})
    else
        table.insert(elements, {label = "Color: " ..color, value = "color"})
    end

    if name == nil then
        table.insert(elements, {label = "Nombre", value = "name"})
    else
        table.insert(elements, {label = "Nombre: " ..name, value = "name"})
        
    end

    if job ~= nil and foto ~= nil and color ~= nil and name ~= nil then
        table.insert(elements, {label = "Crear", value = "create"})
    end

    ESX.UI.Menu.Open('default',GetCurrentResourceName(), "creator_menu",
    { 
    title = "Menu de creación de anuncio", 
    align = "bottom-right", 
    elements = elements 
    }, function(data, menu)
        local v = data.current.value

        if v == "job" then
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),"menu_create",
            { 
            title = "Nombre del job", 
            align = "center", 
            },
            function(data2, menu2)
                job = data2.value
                createAnnounce()
                menu2.close()
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif v == "pic" then
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),"menu_create",
            { 
            title = "Pic del job", 
            align = "center", 
            },
            function(data2, menu2)
                foto = data2.value
                createAnnounce()
                menu2.close()
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif v == "color" then
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),"menu_create",
            { 
            title = "Color del job", 
            align = "center", 
            },
            function(data2, menu2)
                color = data2.value
                createAnnounce()
                menu2.close()
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif v == "name" then
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),"menu_create",
            { 
            title = "Nombre del trabajo", 
            align = "center", 
            },
            function(data2, menu2)
                name = data2.value
                createAnnounce()
                menu2.close()
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif v == "create" then
            TriggerServerEvent("guille_anu:server:create", job, foto, color, name)
            menu.close() 
        end
    end, function(data, menu) 
        menu.close() 
    end)
end

RegisterCommand("anuncio", function(source, args)
    ESX.TriggerServerCallback('guille_anu:getAnounce', function(result)
        TriggerServerEvent("guille_anu:server:sendAnu", result.pic, result.color, result.name)
    end)
end, false)

RegisterNetEvent("guille_an:server:syncAnounce")
AddEventHandler("guille_an:server:syncAnounce", function(pic, color, name)
    SendNUIMessage({
        pic = pic;
        color = color;
        name = name;
    })
end)
