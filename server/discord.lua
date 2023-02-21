function KeyGenLog(keys)
    local keysText = '**Keys**\n```\n'
    for _, key in pairs(keys) do
        keysText = keysText .. key .. '\n'
    end
    keysText = keysText .. '```'
    BasicDiscordLog(Locale.Strings.keyGenerated:format(#keys == 1 and '' or 's'), keysText, 1834767)
end

function LogCheater(source, trigger)
    BasicDiscordLog(Locale.Strings.cheating.title, Locale.Strings.cheating.description:format(IdentifierSection(source), trigger), 16726285)
end

function LogKeyUse(source, key)
    BasicDiscordLog(Locale.Strings.keyuse.title, Locale.Strings.keyuse.description:format(IdentifierSection(source), key), 16775941)
end

function LogWonCar(source, car, plate)
    BasicDiscordLog(Locale.Strings.reward.title, Locale.Strings.reward.description:format(IdentifierSection(source), car, plate), 16775941)
end

function LogCommunityMessage(source, label)
    BasicDiscordLog(Locale.Strings.communityLog.title, Locale.Strings.communityLog.description:format(GetPlayerName(source), label), 40447, 2)
end

function IdentifierSection(source)
    local Idenitfier = GetPlayerIdentifiers(source)
    local Discord
    for _, Identifier in pairs(Idenitfier) do
        if string.find(Identifier, 'discord:') then
            Discord = Identifier:sub(9)
            break
        end
    end

    local IdentifierText = ''
    for _, Identifier in pairs(Idenitfier) do
        if string.find(Identifier, 'ip:') and not Locale.LogIPs then
            goto continue
        end

        IdentifierText = IdentifierText .. Identifier .. '\n'

        ::continue::
    end

    Result = Locale.Strings.identifierSection:format(GetPlayerName(source), Discord, IdentifierText)

    return Result
end

function BasicDiscordLog(title, description, color, type)
    local embed = {
        {
            ['color'] = color,
            ['title'] = title,
            ['description'] = description,
            ['footer'] = {
                ['text'] = 'hs_container',
            },
            ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%S'),
        }
    }

    PerformHttpRequest(type == 2 and ServerConfig.Webhook or ServerConfig.CommunityWebhook, function(err, body, headers) end, 'POST', json.encode({
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end