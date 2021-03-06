data:extend(
{
    {
        type = "fluid",
        name = "biofuel",
        default_temperature = 25,
        heat_capacity = "0.1KJ",
        base_color = {r=0.34, g=0.34, b=0.1},
        flow_color = {r=0.7, g=0.7, b=0.7},
        icon = "__factorio-agriculture__/graphics/item/placeholder.png",
        icon_size = 64, icon_mipmaps = 4,
        order = "a[fluid]-a[biofuel]"
    },
    {
        type = "fluid",
        name = "biogas",
        default_temperature = 45,
        max_temperature = 65,
        heat_capacity = "0.1KJ",
        base_color = {r=0.34, g=0.34, b=0.1},
        flow_color = {r=0.7, g=0.7, b=0.7},
        icon = "__factorio-agriculture__/graphics/item/placeholder.png",
        icon_size = 64, icon_mipmaps = 4,
        order = "a[fluid]-a[biogas]",
        gas_temperature = 45,
        auto_barrel = false
    }
})
