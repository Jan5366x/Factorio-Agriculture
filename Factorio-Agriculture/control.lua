
script.on_event(defines.events.on_built_entity, built_entity_function)

function built_entity_function(event)
    game.print("A player built something on tick "..event.tick)
end