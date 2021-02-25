data:extend(
{
    {
        type = "recipe",
        name = "biofuel",
        category = "chemistry",
        enabled = true,
        energy_required = 2,
        ingredients =
        {
            {type="fluid", name="water", amount=30},
            {type="item", name="corn", amount=10}
        },
        results=
        {
            {type="fluid", name="biofuel", amount=10}
        },
        main_product= "",
        icon = "__base__/graphics/icons/fluid/heavy-oil-cracking.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "fluid-recipes",
        order = "b[fluid-chemistry]-a[heavy-oil-cracking]",
        crafting_machine_tint =
        {
            primary = {r = 1.000, g = 0.642, b = 0.261, a = 1.000}, -- #ffa342ff
            secondary = {r = 1.000, g = 0.722, b = 0.376, a = 1.000}, -- #ffb85fff
            tertiary = {r = 0.854, g = 0.659, b = 0.576, a = 1.000}, -- #d9a892ff
            quaternary = {r = 1.000, g = 0.494, b = 0.271, a = 1.000}, -- #ff7e45ff
        }
    },
    {
        type = "recipe",
        name = "biofuel-refinement",
        category = "oil-processing",
        enabled = true,
        energy_required = 5,
        ingredients =
        {
            {type="fluid", name="water", amount=50},
            {type="fluid", name="biofuel", amount=100}
        },
        results=
        {
            {type="fluid", name="light-oil", amount=45},
        },
        icon = "__base__/graphics/icons/fluid/advanced-oil-processing.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "fluid-recipes",
        order = "a[oil-processing]-b[biofuel-refinement]"
    },
    {
        type = "recipe",
        name = "small-animal-farm",
        enabled = true,
        ingredients =
        {
            {"iron-plate", 3},
            {"copper-plate", 3}
        },
        energy_required = 15,
        result = "small-animal-farm"
    },
    {
        type = "recipe",
        name = "large-animal-farm",
        enabled = true,
        ingredients =
        {
            {"iron-plate", 6},
            {"copper-plate", 6}
        },
        energy_required = 15,
        result = "large-animal-farm"
    },
    {
        type = "recipe",
        name = "plant-farm",
        enabled = true,
        ingredients =
        {
            {"iron-plate", 3},
            {"copper-plate", 3}
        },
        energy_required = 15,
        result = "plant-farm"
    },
    {
        type = "recipe",
        name = "tree-farm",
        enabled = true,
        ingredients =
        {
            {"iron-plate", 3},
            {"copper-plate", 3}
        },
        energy_required = 15,
        result = "tree-farm"
    },
    {
        type = "recipe",
        name = "mill",
        enabled = true,
        ingredients =
        {
            {"wood", 8},
            {"stone-brick", 3}
        },
        energy_required = 15,
        result = "mill"
    },
    {
        type = "recipe",
        name = "kitchen",
        enabled = true,
        ingredients =
        {
            {"iron-plate", 3},
            {"copper-plate", 1},
            {"stone-brick", 2}
        },
        energy_required = 15,
        result = "kitchen"
    },
    {
        type = "recipe",
        name = "cow-growing",
        icon = "__factorio-agriculture__/graphics/icons/placeholder.png",
        icon_size = 64, icon_mipmaps = 4,
        enabled = true,
        subgroup = "large-animal-growing",
        ingredients =
        {
            {"hay-bale", 2},
            {"straw-bale", 1}
        },
        energy_required = 15,
        results =
        {
            {
                name = "beef",
                amount = 2
            },
            {
                name = "milk-can",
                amount = 5
            }
        }
    },
    {
        type = "recipe",
        name = "chicken-growing",
        icon = "__factorio-agriculture__/graphics/icons/placeholder.png",
        icon_size = 64, icon_mipmaps = 4,
        enabled = true,
        subgroup = "small-animal-growing",
        ingredients =
        {
            {"wheat", 5}
        },
        energy_required = 15,
        results =
        {
            {
                name = "chicken-meat",
                amount = 2
            },
            {
                name = "egg",
                amount = 10
            }
        }
    },
    {
        type = "recipe",
        name = "hay-bale",
        enabled = true,
        ingredients =
        {
            {"hay", 8}
        },
        energy_required = 15,
        result = "hay-bale"
    },
    {
        type = "recipe",
        name = "straw-bale",
        enabled = true,
        ingredients =
        {
            {"straw", 8}
        },
        energy_required = 15,
        result = "straw-bale"
    },
    {
        type = "recipe",
        name = "flour",
        enabled = true,
        ingredients =
        {
            {"wheat", 5}
        },
        energy_required = 15,
        result = "flour"
    },
    {
        type = "recipe",
        name = "dough",
        enabled = true,
        ingredients =
        {
            {"flour", 8}
        },
        energy_required = 15,
        result = "dough"
    },
    {
        type = "recipe",
        name = "pizza-salami",
        enabled = true,
        ingredients =
        {
            {"dough", 1},
            {"tomato", 1},
            {"sausage", 1},
            {"cheese", 1}
        },
        energy_required = 15,
        result = "pizza-salami"
    },
    {
        type = "recipe",
        name = "pizza-hawaii",
        enabled = true,
        ingredients =
        {
            {"dough", 1},
            {"tomato", 1},
            {"sausage", 1},
            {"pineapple", 1},
            {"cheese", 1}
        },
        energy_required = 15,
        result = "pizza-hawaii"
    },
    {
        type = "recipe",
        name = "pizza-margarita",
        enabled = true,
        ingredients =
        {
            {"dough", 1},
            {"tomato", 1},
            {"cheese", 1}
        },
        energy_required = 15,
        result = "pizza-margarita"
    },
    {
        type = "recipe",
        name = "pizza-tonno",
        enabled = true,
        ingredients =
        {
            {"dough", 1},
            {"tomato", 1},
            {"raw-fish", 1},
            {"cheese", 1}
        },
        energy_required = 15,
        result = "pizza-tonno"
    },
    {
        type = "recipe",
        name = "cake-cherry-pie",
        enabled = true,
        ingredients =
        {
            {"flour", 2},
            {"cherry", 1},
            {"milk-can", 1},
            {"egg", 1}
        },
        energy_required = 15,
        result = "cake-cherry-pie"
    },
    {
        type = "recipe",
        name = "cake-apple-pie",
        enabled = true,
        ingredients =
        {
            {"flour", 2},
            {"apple", 1},
            {"milk-can", 1},
            {"egg", 1}
        },
        energy_required = 15,
        result = "cake-apple-pie"
    },
    {
        type = "recipe",
        name = "sausage",
        enabled = true,
        ingredients =
        {
            {"beef", 3}
        },
        energy_required = 15,
        result = "sausage"
    },
    {
        type = "recipe",
        name = "baked-potato",
        enabled = true,
        ingredients =
        {
            {"potato", 1}
        },
        energy_required = 15,
        result = "baked-potato"
    },
    {
        type = "recipe",
        name = "goulash",
        enabled = true,
        ingredients =
        {
            {"beef", 1},
            {"paprika", 1},
            {"onion", 1},
            {"tomato", 3}
        },
        energy_required = 15,
        result = "goulash"
    },
    {
        type = "recipe",
        name = "salad",
        enabled = true,
        ingredients =
        {
            {"lettuce-head", 1},
            {"tomato", 1}
        },
        energy_required = 15,
        result = "salad"
    },
    {
        type = "recipe",
        name = "chicken-korma",
        enabled = true,
        ingredients =
        {
            {"chicken-meat", 1},
            {"spice-mixture", 1}
        },
        energy_required = 15,
        result = "chicken-korma"
    },
    {
        type = "recipe",
        name = "bread",
        enabled = true,
        ingredients =
        {
            {"dough", 2}
        },
        energy_required = 15,
        result = "sausage"
    },
    {
        type = "recipe",
        name = "cheese",
        enabled = true,
        ingredients =
        {
            {"milk-can", 4}
        },
        energy_required = 15,
        result = "cheese"
    }
})