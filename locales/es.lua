local Translations = {
    error = {
        invalid_ext = "Esa extensión no es válida, sólo",
        allowed_ext = "son las extensiones de enlaces permitidas.",
    },
    info = {
        use_printer = "Usar impresora"

    },
    command = {
        spawn_printer = "Generar una impresora"
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
