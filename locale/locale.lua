Locale.Current = 'de'

-- ignore code below
local function setLocale()
    if IsDuplicityVersion() then
        Locale.Strings = Locale[Locale.Current].Server
    else
        Locale.Strings = Locale[Locale.Current].Client
    end
end

setLocale()