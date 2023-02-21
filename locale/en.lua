Locale.en = {
    Server = {
        cheatMessage = 'Cheat prevention',
        -- discord logs
        keyGenerated = 'Key%s generated', -- %s=plural s or empty
        identifierSection = '**Player**: `%s`\n**Discord**: <@%s>\n**Identifier**\n```\n%s```\n', -- %s=player name, %s=discord id, %s=identifiers
        cheating = {
            title = 'Cheat prevention',
            description = '%s\n**Method:** Event Trigger (%s)' -- %s=identifiers, %s=trigger
        },
        keyuse = {
            title = 'Key used',
            description = '%s\n**Key:** `%s`' -- %s=identifiers, %s=key
        },
        reward = {
            title = 'Reward received',
            description = '%s\n**Vehicle:** %s\n**Plate:** %s' -- %s=identifiers, %s=vehicle, %s=plate
        },
        communityLog = {
            title = 'A new container got opend!',
            description = '**%s** found a **%s** in a container!' -- %s=player name, %s=vehicle
        },
    },
    Client = {
        openAction = '~HUD_COLOUR_YELLOW~~INPUT_CONTEXT~~w~ to use',
        showroomPlate = 'VIP',
        -- UI
        UI = {
            enterCode = {
                title = 'Enter code',
                description = 'Enter the code and press Next',
                submit = 'Next'
            },
            chooseContainer = {
                title = 'Choose container',
                description = 'Choose a container and press Open',
                submit = 'Open'
            },
            reward = {
                title = 'Reward',
                description = 'You just found a new vehicle! You can get it in your garage',
                submit = 'Close'
            },
        }
    }
}