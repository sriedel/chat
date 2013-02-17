-module( chat_main_supervisor ).
-behavior( supervisor ).
-export( [ start_link/0, start_link/1, init/1 ] ).

start_link() ->
  supervisor:start_link( { local, ?MODULE }, ?MODULE, [] ).

start_link( Args ) ->
  supervisor:start_link( { local, ?MODULE }, ?MODULE, Args ).

init( _Args ) ->
  { ok, { { one_for_one, 3, 10 },
          [ { message_router_supervisor,
              { message_router_supervisor, start_link, [] },
              permanent,
              infinity,
              supervisor,
              [ message_router_supervisor ] },
            { channel_manager_supervisor,
              { channel_manager_supervisor, start_link, [] },
              permanent,
              infinity,
              supervisor,
              [ channel_manager_supervisor ] }
          ] }
  }.
  
