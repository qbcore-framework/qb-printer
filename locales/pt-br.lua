local Translations = {
    error = {
        invalid_ext = "Essa não é uma extensão válida, apenas",
        allowed_ext = "links de extensão são permitidos.",

    },
    info = {
        use_printer = "Usar Impressora"

    },
    command = {
        spawn_printer = "Spawn de uma impressora"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
