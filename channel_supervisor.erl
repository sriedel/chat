-module( channel_supervisor ).
-behavior( supervisor ).
-export( [ start_link/0, start_link/1, init/1 ] ).

start_link() ->
  supervisor:start_link( { local, ?MODULE }, ?MODULE, [] ).

start_link( Args ) ->
  supervisor:start_link( { local, ?MODULE }, ?MODULE, Args ).

init( Args ) ->
  { ok, { { simple_one_for_one, 3, 10 },
          [ { channel,
             { channel, start_link, Args },
             transient,
             1000,
             worker, 
             [ channel ] 
            } ]
        } }.
