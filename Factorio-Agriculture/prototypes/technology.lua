data:extend(
{
    {
        type = "technology",
        name = "space-science-pack",
        icon_size = 256, icon_mipmaps = 4,
        icon = "__base__/graphics/technology/space-science-pack.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "satellite"
            }
        },
        unit =
        {
            count = 1,
            ingredients =
            {
                {"automation-science-pack", 1}
            },
            time = 30
        },
        prerequisites = {"rocket-silo", "electric-energy-accumulators", "solar-energy"},
        order = "c-a"
    }
}
)
