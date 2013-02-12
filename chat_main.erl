-module( chat_main ).
-behavior( application ).
-export( [ start/2, stop/1 ] ).

start( _Type, Args ) ->
  channel_manager_supervisor:start_link().

stop( _State ) ->
  ok.
