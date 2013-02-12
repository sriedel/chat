{ application, chat_client, 
  [ { description, "The client chat server" },
    { vsn, "1.0" },
    { modules, [ channel_proxy, client,
                 message_proxy, message_proxy_supervisor ] },
    { registered, [ message_proxy ] },
    { applications, [ kernel, stdlib ] },
    { mod, { chat_client, [ { main_node, main@monolith },
                            { supervisor_args, [] } ] } },
    { start_phases, [] } 
  ]
}.