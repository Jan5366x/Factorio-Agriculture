data:extend(
{
    {
        type = "technology",
        name = "plant-farm-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "plant-farm"
            },
            {
                type = "unlock-recipe",
                recipe = "hay-bale"
            },
            {
                type = "unlock-recipe",
                recipe = "straw-bale"
            },{
                type = "unlock-recipe",
                recipe = "baked-potato"
            },

        },
        unit =
        {
            count = 10,
            ingredients =
            {
                {"automation-science-pack", 2},
                {"logistic-science-pack", 1}
            },
            time = 30
        },
        prerequisites = {"landfill"},
        order = "c-a"
    },
    {
        type = "technology",
        name = "tree-farm-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "tree-farm"
            }
        },
        unit =
        {
            count = 200,
            ingredients =
            {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            },
            time = 5
        },
        prerequisites = {"landfill", "plant-farm-technology"},
        order = "c-a"
    },
    {
        type = "technology",
        name = "small-animal-farm-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "small-animal-farm"
            }, {
                type = "unlock-recipe",
                recipe = "chicken-growing"
            }
        },
        unit =
        {
            count = 10,
            ingredients =
            {
                {"automation-science-pack", 2},
                {"logistic-science-pack", 1}
            },
            time = 30
        },
        prerequisites = {"landfill", "concrete"},
        order = "c-a"
    },
    {
        type = "technology",
        name = "large-animal-farm-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "large-animal-farm"
            }, {
                type = "unlock-recipe",
                recipe = "cow-growing"
            }, {
                type = "unlock-recipe",
                recipe = "sausage"
            }
        },
        unit =
        {
            count = 200,
            ingredients =
            {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            },
            time = 5
        },
        prerequisites = {"landfill", "concrete", "small-animal-farm-technology"},
        order = "c-a"
    },
    {
        type = "technology",
        name = "biofuel-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "biofuel"
            }
        },
        unit =
        {
            count = 50,
            ingredients =
            {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 2}
            },
            time = 50
        },
        prerequisites = {"fluid-handling"},
        order = "c-a"
    },
    {
        type = "technology",
        name = "biofuel-processing-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "biofuel-refinement"
            }
        },
        unit =
        {
            count = 50,
            ingredients =
            {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 2}
            },
            time = 50
        },
        prerequisites = {"biofuel-technology", "advanced-oil-processing"},
        order = "c-a"
    },
    {
        type = "technology",
        name = "food-processing-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "mill"
            }, {
                type = "unlock-recipe",
                recipe = "flour"
            }, {
                type = "unlock-recipe",
                recipe = "dough"
            }, {
                type = "unlock-recipe",
                recipe = "salad"
            },{
                type = "unlock-recipe",
                recipe = "cheese"
            }
        },
        unit =
        {
            count = 50,
            ingredients =
            {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 2}
            },
            time = 50
        },
        prerequisites = {"automation-3", "plant-farm-technology", "small-animal-farm-technology"},
        order = "c-a"
    },
    {
        type = "technology",
        name = "advanced-food-processing-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "kitchen"
            }, {
                type = "unlock-recipe",
                recipe = "pizza-salami"
            }, {
                type = "unlock-recipe",
                recipe = "pizza-hawaii"
            }, {
                type = "unlock-recipe",
                recipe = "pizza-margarita"
            }, {
                type = "unlock-recipe",
                recipe = "pizza-tonno"
            }, {
                type = "unlock-recipe",
                recipe = "cake-cherry-pie"
            }, {
                type = "unlock-recipe",
                recipe = "cake-apple-pie"
            }, {
                type = "unlock-recipe",
                recipe = "goulash"
            }, {
                type = "unlock-recipe",
                recipe = "chicken-korma"
            }
        },
        unit =
        {
            count = 50,
            ingredients =
            {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 2}
            },
            time = 50
        },
        prerequisites = {"tree-farm-technology", "large-animal-farm-technology", "food-processing-technology"},
        order = "c-a"
    },
    {
        type = "technology",
        name = "space-delivery-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "satellite"
            }
        },
        unit =
        {
            count = 50,
            ingredients =
            {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 2}
            },
            time = 50
        },
        prerequisites = {"artillery", "food-processing-technology"},
        order = "c-a"
    },
    {
        type = "technology",
        name = "advanced-space-delivery-technology",
        icon_size = 128, icon_mipmaps = 4,
        icon = "__factorio-agriculture__/graphics/technology/placeholder.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "satellite"
            }
        },
        unit =
        {
            count = 50,
            ingredients =
            {
                {"automation-science-pack", 10},
                {"logistic-science-pack", 10},
                {"chemical-science-pack", 10},
                {"production-science-pack", 10},
                {"utility-science-pack", 10},
                {"space-science-pack", 1}
            },
            time = 50
        },
        prerequisites = {"space-delivery-technology", "rocket-control-unit", "advanced-food-processing-technology"},
        order = "c-a"
    }
}
)
