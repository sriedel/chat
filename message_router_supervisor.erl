-module( message_router_supervisor ).
-export( [ start_link/0, start_link/1, init/1 ] ).
-behavior( supervisor ).

start_link() ->
  supervisor:start_link( { global, ?MODULE}, ?MODULE, [] ).

start_link( Args ) ->
  supervisor:start_link( {global, ?MODULE}, ?MODULE, Args ).

init(_Args) ->
  { ok, { { simple_one_for_one, 3, 10 },
          [ { message_router,
              { message_router, start_link, [] },
              transient,
              1000,
              worker,
              [ message_router ] 
            } ] 
        } }.
