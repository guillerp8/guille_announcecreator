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

    ESX.UI.Menu.Open('default',GetCurrentResourceName(), "creator_menu",
    { 
    title = "Menu de creación de anuncio", 
    align = "bottom-right", 
    elements = elements 
    }, function(data, menu)
        local v = data.current.value

        if v == "job" then

        elseif v == "pic" then

        elseif v == "color" then

        elseif v == "name" then

        end
    end, function(data, menu) 
        menu.close() 
    end)
end