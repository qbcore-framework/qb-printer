local Translations = {
    error = {
        invalid_ext = "Thats not a valid extension, only",
        allowed_ext = "extension links are allowed.",

    },
    info = {
        use_printer = "Use Printer"

    },
    command = {
        spawn_printer = "Spawn a printer"
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
