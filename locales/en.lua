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

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
