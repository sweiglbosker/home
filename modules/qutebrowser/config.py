config.unbind('k')
config.bind(',v', 'hint links spawn mpv {hint-url}')
# TODO: caret
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

c.fonts.default_family = 'monospace'
# c.fonts.prompts = 'sans'
c.fonts.default_size = '11pt'
c.hints.chars = 'arstneio'
c.hints.radius=0

c.keyhint.radius=0
c.completion.scrollbar.width=0
c.completion.show="always"
c.completion.shrink=True
c.content.autoplay=False
c.content.fullscreen.window=True
c.content.pdfjs=True
c.content.prefers_reduced_motion=True
c.downloads.location.directory="~/dl"
c.editor.command=["neovide", "{file}", "--", "-c", "normal {line}G{column0}l"]
c.prompt.filebrowser=False
c.prompt.radius=0
c.scrolling.bar="never"
c.scrolling.smooth=False
c.search.incremental=False
c.search.wrap=False
c.search.wrap_messages=False

# c.statusbar.show="in-mode"
c.statusbar.widgets = ["search_match", "url", "scroll"]

c.tabs.favicons.show = 'never'
c.tabs.indicator.width = 0
c.tabs.title.alignment = 'center'
c.tabs.last_close='ignore'
c.tabs.mousewheel_switching=False
c.tabs.show = 'multiple'
# c.tabs.tabs_are_windows = False
c.tabs.tabs_are_windows = True
c.tabs.title.format = "{audio}{index}:{current_title}"

c.url.default_page = "about:blank"
c.url.start_pages = "about:blank"
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}", 
    "nix": "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}",
    "void": "https://voidlinux.org/packages/?arch=x86_64&q={}",
    "wiki": "https://en.wikipedia.org/wiki/Special:Search?&search={}",
    "lean": "https://loogle.lean-lang.org/?q={}",
    "arxiv": "https://arxiv.org/search/?query={}&source=header&searchtype=all",
    "disc": "https://www.discogs.com/search?q={}",
    "rym": "https://rateyourmusic.com/search?searchterm={}&searchtype=",
}

c.window.title_format = "{audio} {current_title}"
