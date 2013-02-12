{ application, chat_main, 
  [ { description, "The main/core chat server" },
    { vsn, "1.0" },
    { modules, [ channel_manager, channel_manager_supervisor,
                 message_router, message_router_supervisor ] },
    { registered, [ channel_manager ] },
    { applications, [ kernel, stdlib ] },
    { mod, { chat_main, [] } },
    { start_phases, [] } 
  ]
}.
