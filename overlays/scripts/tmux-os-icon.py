import platform

icons = {
    'linux': '',
    'darwin': '',
    'default': '',
}

current_platform = platform.system().lower()
print(icons.get(current_platform, icons['default']))
