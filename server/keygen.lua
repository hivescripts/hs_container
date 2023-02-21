-- key format: key_xxxxxxxxxxxxxxxxxxxx
local lowerCaseChars = 'abcdefghijklmnopqrstuvwxyz'
local upperCaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
local numbers = '0123456789'

function generateSequence()
    local sequence = 'key_'

    local sets = {
        lowerCaseChars,
        upperCaseChars,
        numbers
    }

    for i = 1, 20 do
        local charType = math.random(1, 3)
        local charSet = sets[charType]
        local charIndex = math.random(1, #charSet)

        sequence = sequence .. charSet:sub(charIndex, charIndex)
    end
    return sequence
end