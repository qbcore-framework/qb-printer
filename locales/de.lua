local Translations = {
    error = {
        invalid_ext = "Das ist keine gültige Erweiterung, nur",
        allowed_ext = "Erweiterungs-Links sind erlaubt.",
    },
    info = {
        use_printer = "Drucker verwenden",
    },
    command = {
        spawn_printer = "Drucker spawnen",
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
