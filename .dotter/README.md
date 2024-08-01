# Setup Dotter

[Dotter](https://github.com/SuperCuber/dotter) is a simple dotfile manager and templater.

## Windows

Create a `local.toml` file in the `.dotter` directory with the following content:

```toml
includes = [".dotter/include/windows.toml"]
packages = ["windows"]
```

## Linux

Create a `local.toml` file in the `.dotter` directory with the following content:

```toml
includes = [".dotter/include/windows.toml"]
packages = ["linux"]
```
