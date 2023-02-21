Locale.de = {
    Server = {
        cheatMessage = 'Cheating erkannt',
        -- discord logs
        keyGenerated = 'Key%s generiert', -- %s=plural s or empty
        identifierSection = '**Spieler**: `%s`\n**Discord**: <@%s>\n**Identifier**\n```\n%s```\n', -- %s=player name, %s=discord id, %s=identifiers
        cheating = {
            title = 'Cheat Erkennung',
            description = '%s\n**Methode:** Event Trigger (%s)' -- %s=identifiers, %s=trigger
        },
        keyuse = {
            title = 'Key benutzt',
            description = '%s\n**Key:** `%s`' -- %s=identifiers, %s=key
        },
        reward = {
            title = 'Belohnung erhalten',
            description = '%s\n**Fahrzeug:** %s\n**Kennzeichen:** %s' -- %s=identifiers, %s=vehicle, %s=plate
        },
        communityLog = {
            title = 'Neuer Container Fund!',
            description = '**%s** hat in einem Container einen **%s** gefunden!' -- %s=player name, %s=vehicle
        },
    },
    Client = {
        openAction = '~HUD_COLOUR_YELLOW~~INPUT_CONTEXT~~w~ zum interagieren',
        showroomPlate = 'VIP',
        -- UI
        UI = {
            enterCode = {
                title = 'Code einlösen',
                description = 'Gib deine Code ein und gehe anschließend auf Einlösen',
                submit = 'Einlösen'
            },
            chooseContainer = {
                title = 'Container auswählen',
                description = 'Wähle einen Container aus und gehe anschließend auf Öffnen',
                submit = 'Öffnen'
            },
            reward = {
                title = 'Belohnung',
                description = 'Glückwunsch! Sieh dir deine Belohnung an und gehe auf Schließen',
                submit = 'Schließen'
            },
        }
    }
}