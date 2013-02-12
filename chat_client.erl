-module( chat_client ).
-behavior( application ).
-export( [ start/2, stop/1 ] ).

start( _Type, Args ) ->
  { main_node, MainNode } = lists:keyfind( main_node, 1, Args ),
  pong = net_adm:ping( MainNode ), %% connect to main node

  { supervisor_args, SupervisorArgs } = lists:keyfind( supervisor_args, 1, Args ),
  message_proxy_supervisor:start_link( SupervisorArgs ).

stop( _State ) ->
  ok.

