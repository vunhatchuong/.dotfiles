# Nvim

## Add additional languages

Available languages are under [lang folder](./lua/plugins/lang/).

To enable these languages, create a file called `lang.lua` in [core](./lua/core/)
with this code

```bash
return {
    { import = "plugins.lang.go" },
    { import = "plugins.lang.python" },
}
```
Some [languages](./lua/plugins/mason.lua) are included by default like `http`,`lua`.
