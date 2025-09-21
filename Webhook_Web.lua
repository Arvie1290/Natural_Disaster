local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local WEBHOOK_URL = "MASUKIN URL WEBHOOK DISINI"

-- Bikin ServerID unik pas server start
local ServerID = HttpService:GenerateGUID(false)

Players.PlayerAdded:Connect(function(player)
    -- Data yang bisa diambil dari Roblox
    local info = {
        GameName = game.Name,
        PlaceID = tostring(game.PlaceId),
        Server = ServerID,
        DisplayName = player.DisplayName,
        UserName = player.Name,
        AccountAge = tostring(player.AccountAge) .. " hari",
        Gender = "❌ Tidak tersedia", -- Roblox gak kasih data ini
        Country = "❌ Tidak tersedia", -- Roblox gak kasih data ini
        JoinTime = os.date("!%d/%m/%Y, %H:%M UTC")
    }

    -- Buat JSON data untuk Discord
    local data = {
        username = "Game Logger",
        embeds = {{
            title = "🎮 Player Joining Your Game!",
            color = 3447003, -- biru
            fields = {
                { name = "Nama Game", value = info.GameName, inline = true },
                { name = "Place ID", value = info.PlaceID, inline = true },
                { name = "Server", value = info.Server, inline = true },
                { name = "Display Name", value = info.DisplayName, inline = true },
                { name = "Tag Name", value = info.UserName, inline = true },
                { name = "Age / Umur", value = info.AccountAge, inline = true },
                { name = "Gender", value = info.Gender, inline = true },
                { name = "Country / Negara", value = info.Country, inline = true },
                { name = "Dia Masuk Kapan", value = info.JoinTime, inline = false },
            }
        }}
    }

    -- Encode ke JSON
    local jsonData = HttpService:JSONEncode(data)

    -- Kirim POST ke webhook
    local success, response = pcall(function()
        return HttpService:PostAsync(WEBHOOK_URL, jsonData, Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("Webhook terkirim untuk " .. player.Name)
    else
        warn("Gagal kirim webhook:", response)
    end
end)
