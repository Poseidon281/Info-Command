ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterCommand(Config.InfoCommand, function(source, args)
    if args[1] then
        local target = tonumber(args[1])
        if args[1]:lower() == "me" then
            target = tonumber(source)
        end
        local xPlayer = ESX.GetPlayerFromId(source)
        local admingroup = xPlayer.getGroup()
        if target ~= nil and GetPlayerName(target) ~= nil and admingroup == 'owner' or 'admin' then

            local xTarget = ESX.GetPlayerFromId(target)

            local currentTime = os.date('%d-%m-%Y %H:%M:%S', os.time())

            local group = xTarget.getGroup()

            local geld = xTarget.getMoney()
            local accounts = xTarget.getAccounts()
            local accountsText = ""
            for i = 1, #accounts do
                accountsText = accountsText .. accounts[i].label .. ": " .. accounts[i].money .. "<br>"
            end

            local loadout = xTarget.getLoadout()
            local loadoutText = ""
            for i = 1, #loadout do
                loadoutText = loadoutText .. loadout[i].label .. ": " .. loadout[i].ammo .. "<br>"
            end

            local inventory = xTarget.getInventory(false)
            local inventoryText = ""
            for i = 1, #inventory do
                if inventory[i].count > 0 then
                    inventoryText = inventoryText .. inventory[i].label .. ": " .. inventory[i].count .. "<br>"
                end
            end

            local job = xTarget.getJob()
            local job_label = job.label or "unemployed"
            local job_grade_label = job.grade_label or "unemployed"
            local job_salary = ESX.Math.GroupDigits(job.grade_salary) or 0.0

            local name = Config.Server
            local msg = "<b>Name:</b> " .. GetPlayerName(target) .. "<br><b>Job:</b> " .. job_label .. " ( " .. job_grade_label .. " )<br><b>Salary:</b> " .. job_salary .. "<br><b>Accounts:</b><br>" .. accountsText .. "<br><b>Cash Geld:</b><br>" .. geld .. "<br><b>Loadout:</b><br>" .. loadoutText .. "<br><b>Inventory:</b><br>" .. inventoryText
            local infomsg = "\n\nNaam van Stafflid die het command heeft gebruikt: " .. GetPlayerName(source) .. "\n\nName: " .. GetPlayerName(target) .. "\nID: " .. target .. "\nJob: " .. job_label .. " ( " .. job_grade_label .. " )\nSalary:  " .. job_salary .. "\nUsergroup: " .. group .. "\nAccounts: " .. accountsText .. "\nCash Geld: " .. geld .. "\nLoadout:" .. loadoutText .. "\nInventory:" .. inventoryText
            local webhook = Config.Infowebhook
            local embed = {
                ["color"] = Config.Color,
                ["title"] = name,
                ["description"] = infomsg,
                ["footer"] = {
                    ["text"] = currentTime,
                },
                ["author"] = {
                    ["name"] = name,
                    ["icon_url"] = Config.AvatarURL
                }
            }

            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ embeds = { embed } }), { ['Content-Type'] = 'application/json' })
            Citizen.Wait(100)
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="bubble-message"<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 69, 219, 0.9); border-radius: 8px;"><i class="fas fa-user"></i> {0}:<br> ' .. msg .. '</div>', 
                args = { "Informatie over: " .. target }
            })
        else
            TriggerClientEvent('okokNotify:Alert', source, 'charinfo Command', 'Speler niet gevonden', 5000, 'error', playSound)
        end
    else
        TriggerClientEvent('okokNotify:Alert', source, 'charinfo Command', "Geen speler ID opgegeven", 5000, 'error', playSound)
    end
end, false) 
