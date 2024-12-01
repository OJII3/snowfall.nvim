# Snowfall.nvim

Snowfall is a simple plugin that adds a snowfall effect to your neovim terminal. Works on Kitty Terminal.

https://github.com/user-attachments/assets/0d5fa515-562f-4a06-9468-ca3a1fce72ed

## Installation

With Lazy.nvim:

```lua
{
    "ojii3/snowfall.nvim",
    dependencies = { "3rd/image.nvim" },
    config = true,
}
```

## Usage

By default, the snowfall effect is started on startup. You can also start it manually with the following command:

```
:SnowfallStart
```

To stop the snowfall effect, use the following command:

```
:SnowfallStop
```

## Configuration

Default configuration:

```lua
opts = {
    snowflake = {
        path = utils.get_plugin_resource("./assets/nix.png"), -- Absolute path to the custom image
        width = 2,
        height = 2,
    },
    startup = true, -- Start snowfall on startup
    count = 20, -- Number of snowflakes in the screen
    update_interval = 100, -- Update interval in milliseconds
}
```

## TODO

- [ ] Documentation in vim help format
- [ ] Type Annotations
