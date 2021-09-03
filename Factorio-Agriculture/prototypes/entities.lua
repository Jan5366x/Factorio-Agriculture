require ("util")
require ("__base__/prototypes/entity/pipecovers")

local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds      = require("__base__/prototypes/entity/sounds")

data:extend(
{
    {
        type = "assembling-machine",
        name = "small-animal-farm",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "small-animal-farm"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        fluid_boxes =
        {
            {
                production_type = "input",
                pipe_picture = assembler2pipepictures(),
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{ type="input", position = {-0.5, -2.5} }},
                secondary_draw_orders = { north = -1 }
            },
            off_when_no_fluid_recipe = false
        },
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 16),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"small-animal-growing"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
    {
        type = "assembling-machine",
        name = "small-animal-farm-field",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "small-animal-farm-field"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        collision_mask = {"object-layer"},
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/farm-field-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/hr-farm-field-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/farm-field-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 8),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/hr-farm-field-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 8),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"crafting", "basic-crafting", "advanced-crafting"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
    {
        type = "assembling-machine",
        name = "large-animal-farm",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "large-animal-farm"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        fluid_boxes =
        {
            {
                production_type = "input",
                pipe_picture = assembler2pipepictures(),
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{ type="input", position = {-0.5, -2.5} }},
                secondary_draw_orders = { north = -1 }
            },
            off_when_no_fluid_recipe = false
        },
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        alert_icon_shift = util.by_pixel(-3, -12),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 16),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"large-animal-growing"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
    {
        type = "assembling-machine",
        name = "large-animal-farm-field",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "large-animal-farm-field"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        collision_mask = {"object-layer"},
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/farm-field-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/hr-farm-field-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/farm-field-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 8),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/hr-farm-field-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 8),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"crafting", "basic-crafting", "advanced-crafting"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
    {
        type = "assembling-machine",
        name = "plant-farm",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "plant-farm"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        fluid_boxes =
        {
            {
                production_type = "input",
                pipe_picture = assembler2pipepictures(),
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{ type="input", position = {-0.5, -2.5} }},
                secondary_draw_orders = { north = -1 }
            },
            off_when_no_fluid_recipe = false
        },
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        alert_icon_shift = util.by_pixel(-3, -12),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 16),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"plant-growing"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
    {
        type = "assembling-machine",
        name = "plant-farm-field",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "plant-farm-field"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        collision_mask = {"object-layer"},
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/farm-field-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/hr-farm-field-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/farm-field-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 8),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/hr-farm-field-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 8),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"crafting", "basic-crafting", "advanced-crafting"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
    {
        type = "assembling-machine",
        name = "tree-farm",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "tree-farm"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        fluid_boxes =
        {
            {
                production_type = "input",
                pipe_picture = assembler2pipepictures(),
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{ type="input", position = {-0.5, -2.5} }},
                secondary_draw_orders = { north = -1 }
            },
            off_when_no_fluid_recipe = false
        },
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        alert_icon_shift = util.by_pixel(-3, -12),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 16),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"tree-growing"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
    {
        type = "assembling-machine",
        name = "tree-farm-field",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "tree-farm-field"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        collision_mask = {"object-layer"},
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/farm-field-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/hr-farm-field-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/farm-field-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 8),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-field-placeholder/hr-farm-field-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 8),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"crafting", "basic-crafting", "advanced-crafting"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
    {
        type = "assembling-machine",
        name = "mill",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "mill"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        alert_icon_shift = util.by_pixel(-3, -12),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 16),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"milling"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
    {
        type = "assembling-machine",
        name = "kitchen",
        icon = "__base__/graphics/icons/assembling-machine-1.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "kitchen"},
        max_health = 300,
        corpse = "assembling-machine-1-remnants",
        dying_explosion = "assembling-machine-1-explosion",
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        collision_box = {{-2.3, -2.3}, {2.3, 2.3}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = hit_effects.entity(),
        alert_icon_shift = util.by_pixel(-3, -12),
        animation =
        {
            layers =
            {
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder.png",
                    priority="high",
                    width = 157,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    shift = util.by_pixel(0, -16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder.png",
                        priority="high",
                        width = 313,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        shift = util.by_pixel(0, -16),
                        scale = 0.5
                    }
                },
                {
                    filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/farm-placeholder-shadow.png",
                    priority="high",
                    width = 173,
                    height = 173,
                    frame_count = 1,
                    line_length = 1,
                    repeat_count = 1,
                    draw_as_shadow = true,
                    shift = util.by_pixel(16, 16),
                    hr_version =
                    {
                        filename = "__factorio-agriculture__/graphics/entity/farm-placeholder/hr-farm-placeholder-shadow.png",
                        priority="high",
                        width = 345,
                        height = 345,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 1,
                        draw_as_shadow = true,
                        shift = util.by_pixel(16, 16),
                        scale = 0.5
                    }
                }
            }
        },
        crafting_categories = {"food-processing"},
        crafting_speed = 0.5,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 4
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        vehicle_impact_sound = sounds.generic_impact,
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/assembling-machine-t1-1.ogg",
                    volume = 0.5
                }
            },
            audible_distance_modifier = 0.5,
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    }
})