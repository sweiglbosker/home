config.unbind('k')
config.bind(',v', 'hint links spawn mpv {hint-url}')
config.bind('m', 'scroll left')
config.bind('n', 'scroll down')
config.bind('e', 'scroll up')
config.bind('i', 'scroll right')
config.bind('M', 'back')
config.bind('N', 'tab-prev')
config.bind('E', 'tab-next')
config.bind('I', 'forward')

config.bind('j', 'search-next')
config.bind('J', 'search-prev')
config.bind('l', 'mode-enter insert')

c.tabs.show = 'never'
c.tabs.tabs_are_windows = True
c.tabs.last_close = 'close'
c.fonts.default_family = 'BerkeleyMonoPatched Nerd Font Propo'
c.fonts.default_size: '13pt'
c.hints.chars = 'arstneio'
c.tabs.favicons.show = 'never'
c.tabs.indicator.width = 0
c.tabs.title.alignment = 'center'
