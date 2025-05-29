
config.load_autoconfig()

c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}'
}

c.url.default_page = 'https://google.com' 
c.url.start_pages = 'https://google.com'

config.set("colors.webpage.preferred_color_scheme", "dark")


#custom keybinds
config.bind('M', 'hint links spawn linkhand video {hint-url}')
config.bind('L', 'hint links spawn linkhand listen {hint-url}')
