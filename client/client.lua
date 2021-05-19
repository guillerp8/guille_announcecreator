ESX = nil 

Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0) 
    end 
end)

RegisterCommand(Config['createcommand'], function(source, args)
    ESX.TriggerServerCallback('guille_an:server:checkAdmin', function(result)
        if result then
            createAnnounce()
        else
            ESX.ShowNotification('No ~r~perms')
        end
    end)
end, false)

local job = nil
local foto = nil
local color = nil
local name = nil
local colorbar = nil

function createAnnounce()
    local elements = {}

    if job == nil then
        table.insert(elements, {label = "Job:", value = "job"})
    else
        table.insert(elements, {label = "Job: " ..job, value = "job"})
    end

    if foto == nil then
        table.insert(elements, {label = "Picture:", value = "pic"})
    else
        table.insert(elements, {label = "Picture: " ..foto, value = "pic"})
    end

    if color == nil then
        table.insert(elements, {label = "Color (rgb example: 1, 2, 3):", value = "color"})
    else
        table.insert(elements, {label = "Color: " ..color, value = "color"})
    end

    if name == nil then
        table.insert(elements, {label = "Name", value = "name"})
    else
        table.insert(elements, {label = "Name: " ..name, value = "name"})
    end

    if colorbar == nil then
        table.insert(elements, {label = "Bar color (rgb example: 1, 2, 3):", value = "colorbar"})
    else
        table.insert(elements, {label = "Bar color: " ..colorbar, value = "colorbar"}) 
    end

    if titlecolor == nil then
        table.insert(elements, {label = "Title text color (rgb example: 1, 2, 3): ", value = "titlecolor"})
    else
        table.insert(elements, {label = "Title text color: " ..titlecolor, value = "titlecolor"}) 
    end

    if job ~= nil and foto ~= nil and color ~= nil and name ~= nil and colorbar ~= nil and titlecolor ~= nil then
        SendNUIMessage({
            democolor = color;
            demopic = foto;
            democolorbar = colorbar;
            demotitlecolor = titlecolor;
            demoname = name;
        })
        table.insert(elements, {label = "Create", value = "create"})
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
            title = "Job name", 
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
            title = "Job picture", 
            align = "center", 
            },
            function(data2, menu2)
                foto = data2.value
                SendNUIMessage({
                    demopic = foto;
                })
                createAnnounce()
                menu2.close()
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif v == "color" then
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),"menu_create",
            { 
            title = "Job color", 
            align = "center", 
            },
            function(data2, menu2)
                color = data2.value
                createAnnounce()
                menu2.close()
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif v == "titlecolor" then
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),"menu_create",
            { 
            title = "Title color", 
            align = "center", 
            },
            function(data2, menu2)
                titlecolor = data2.value
                createAnnounce()
                menu2.close()
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif v == "colorbar" then
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),"menu_create",
            { 
            title = "Ad fringe color", 
            align = "center", 
            },
            function(data2, menu2)
                colorbar = data2.value
                createAnnounce()
                menu2.close()
            end, function(data2, menu2)
                menu2.close()
            end)
        elseif v == "name" then
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('dialog',GetCurrentResourceName(),"menu_create",
            { 
            title = "Label showed", 
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
            TriggerServerEvent("guille_anu:server:create", job, foto, color, name, colorbar, titlecolor)
            SendNUIMessage({
                restartdemo = true;
            })
            menu.close()
        end
    end, function(data, menu)
        SendNUIMessage({
            restartdemo = true;
        })
        menu.close() 
    end)
end

RegisterCommand(Config['adcommand'], function(source, args)
    local content = table.concat(args, ' ')
    ESX.TriggerServerCallback('guille_anu:getAnounce', function(result) 
        if result ~= nil then
            TriggerServerEvent("guille_anu:server:sendAnu", result.pic, result.color, result.name, content, result.colorbar, result.titlecolor)
        end
    end)
end, false)

RegisterNetEvent("guille_an:server:syncAnounce")
AddEventHandler("guille_an:server:syncAnounce", function(pic, color, name, content, colorbar, titlecolor)
    SendNUIMessage({
        pic = pic;
        color = color;
        name = name;
        content = content;
        colorbar = colorbar;
        titlecolor = titlecolor;
    })
end)
