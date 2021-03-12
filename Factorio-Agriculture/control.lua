
script.on_load(function()
    script.on_event(defines.events.on_built_entity, built_entity_function)
end)


function built_entity_function(event)
    local player = game.get_player(event.player_index)
    player.print("Built! YEAY!")
end