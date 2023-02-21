Config = {}

Config.Locations = {
    vector3(858.6556, -3203.5242, 5.9950)
}

Config.Rewards = { -- 6 or less, more than 7 may see unrealistic to users
    {
        label = 'Adder',
        hash = `adder`
    },
    {
        label = 'T20',
        hash = `t20`
    },
    {
        label = 'Autarch',
        hash = `autarch`
    },
    {
        label = 'Cheetah',
        hash = `cheetah`
    },
    {
        label = 'Krieger',
        hash = `krieger`
    },
    {
        label = 'Vagner',
        hash = `vagner`
    }
}

Config.Blip = { -- https://docs.fivem.net/docs/game-references/blips/
    Enabled = true,
    Id = 677,
    Color = 5,
    Scale = 1.0,
    Name = 'VIP Container',
}

Config.Marker = {
    Enabled = true,
    Type = 21,
    Color = { r = 240, g = 200, b = 80, a = 150 },
    Scale = { x = 1.0, y = 1.0, z = 1.0 },
    Rotate = true,
    DrawDistance = 30.0,
}

Config.ShowRoom = { -- don't change this unless you know what you are doing!
    position = vector3(-1267.0117, -3013.0791, -48.4902)
}