-module( chat_main ).
-behavior( application ).
-export( [ start/2, stop/1 ] ).

start( _Type, _Args ) ->
  message_router_supervisor:start_link(),
  channel_manager_supervisor:start_link().

stop( _State ) ->
  ok.
