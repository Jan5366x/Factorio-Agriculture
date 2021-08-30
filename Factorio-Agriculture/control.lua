
script.on_load(function()
    script.on_event(defines.events.on_built_entity, entity_built_function)
    script.on_event(defines.events.on_entity_died, entity_died_function)
end)

function entity_built_function(event)
    local entity = event.created_entity
    local name = entity.name

    messagePlayer(event.player_index, "Built! hmm whats that?" .. entity.name .. " : " .. entity.type)
    if name == "small-animal-farm" or name == "large-animal-farm" or  name == "plant-farm" or name == "tree-farm" then
        new_farm(event)
    elseif name == "tree-farm-field" or name == "plant-farm-field" or name == "small-animal-farm-field" or name == "large-animal-farm-field" then
        new_field(event)
    end
end

function entity_died_function(event)
    local entity = event.entity
    local name = entity.name

    messagePlayer(event.player_index, "Died! hmm whats that?" .. entity.name .. " : " .. entity.type)

    if name == "small-animal-farm" or name == "large-animal-farm" or  name == "plant-farm" or name == "tree-farm" then
        remove_farm(event)
    elseif name == "tree-farm-field" or name == "plant-farm-field" or name == "small-animal-farm-field" or name == "large-animal-farm-field" then
        remove_field(event)
    end
end

function new_farm(event)
    local entity = event.created_entity
    messagePlayer(event.player_index,"Built! YEAY!" .. entity.name .. " : " .. entity.type)
end

function new_field(event)
    local entity = event.created_entity
    messagePlayer(event.player_index,"Built! YEAY!" .. entity.name .. " : " .. entity.type)
end

function remove_farm(event)
    local entity = event.entity
    messagePlayer(event.player_index,"Died! SAD!" .. entity.name .. " : " .. entity.type)
end

function remove_field(event)
    local entity = event.entity
    messagePlayer(event.player_index,"Died! SAD!" .. entity.name .. " : " .. entity.type)
end

function messagePlayer(player_index, message)
    if not player_index == nil then
        local player = game.get_player(player_index)
        if not player == nil then
            player.print(message)
        end
    end
end