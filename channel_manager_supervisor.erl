-module( channel_manager_supervisor ).
-behavior( supervisor ).
-export( [ start_link/0, start_link/1, init/1 ] ).

start_link() ->
  supervisor:start_link( { global, ?MODULE }, ?MODULE, [] ).

start_link( Args ) ->
  supervisor:start_link( { global, ?MODULE }, ?MODULE, Args ).

init( Args ) ->
  { ok, { { one_for_one, 3, 10 },
          [ { channel_manager,
              { channel_manager, start_link, Args },
              permanent,
              1000,
              worker,
              [ channel_manager ] 
            } ] 
        } }.
