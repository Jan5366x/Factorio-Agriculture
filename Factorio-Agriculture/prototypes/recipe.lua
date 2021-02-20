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
        name = "beef",
        enabled = true,
        ingredients =
        {
            {"cow", 1}
        },
        energy_required = 15,
        result = "beef"
    },
    {
        type = "recipe",
        name = "chicken-meat",
        enabled = true,
        ingredients =
        {
            {"chicken", 1}
        },
        energy_required = 15,
        result = "chicken-meat"
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
            {"cereals", 5}
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
            {"tomatoes", 1},
            {"sausage", 1}
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
            {"tomatoes", 1},
            {"sausage", 1},
            {"pineapple", 1}
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
            {"tomatoes", 1}
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
            {"tomatoes", 1},
            {"raw-fish", 1}
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
            {"cherries", 1},
            {"milk-can", 1},
            {"eggs", 1}
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
            {"apples", 1},
            {"milk-can", 1},
            {"eggs", 1}
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
        name = "baked-potatoes",
        enabled = true,
        ingredients =
        {
            {"potatoes", 1}
        },
        energy_required = 15,
        result = "baked-potatoes"
    },
    {
        type = "recipe",
        name = "goulash",
        enabled = true,
        ingredients =
        {
            {"beef", 1},
            {"paprika", 1},
            {"onions", 1},
            {"tomatoes", 3}
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
            {"tomatoes", 1}
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
    }
})