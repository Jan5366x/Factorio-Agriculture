# Factorio-Agriculture Mod

## WIP
Mod is in early work in progress phase!

Anything is subject to change!

# Content List
*Check csv files under Assets/inventory for the mod content*

## Recommended JetBrains IDEA Plugins
- EmmyLua
- Factorio LUA API (requires EmmyLua)
- CodeGlance (source code minimap)

# Build

You can use a JetBrains IDEA RunConfiguration or direct commands

( Requires Java 16 https://jdk.java.net/16/ )

```shell
java Build.java
```

Start arguments
- `-localdeploy` copy files to the factorio mod folder
- `-launch` launch the game (requires `-localdeploy`)

Example:
```shell
java Build.java -localdeploy -launch 
```
