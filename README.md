# qb-printer
Printer For QB-Core

* ATTENTION: To have this working correctly you MUST change shared.lua as follows: `Search for "printerdocument" and make ["unique"] = true` otherwise documents WILL STACK and You'll be able to see only latest.

* Config for the Key to use the printer added....Didn't make it a KeyBind since it's not really gonna be used a lot.
* Config for Text shown when closeby a printer.
* Config table for valid extensions added.
* Added an error notification if url doesn't end with a valid extension from the table on the config file.
* To change DEFAULT printerdocument's image navigate to qb-inventory/server/main.lua:1549 and change `info.url = "https://cdn.discordapp.com/attachments/645995539208470549/707609551733522482/image0.png"` default URL there.
