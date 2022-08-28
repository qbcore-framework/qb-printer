local Translations = {
    error = {
        invalid_ext = "Ce n'est pas une extension valide, seul",
        allowed_ext = "extensions sont autorisés.",

    },
    info = {
        use_printer = "Utiliser l'imprimante"

    },
    command = {
        spawn_printer = "Créer une imprimante"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
