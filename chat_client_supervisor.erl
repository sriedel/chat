-module( chat_client_supervisor ).
-behavior( supervisor ).
-export( [ start_link/0, start_link/1, init/1 ] ).

start_link() ->
  supervisor:start_link( { local, ?MODULE }, ?MODULE, [] ).

start_link( Args ) ->
  supervisor:start_link( { local, ?MODULE }, ?MODULE, Args ).

init( Args ) ->
  { ok, { { one_for_one, 3, 10 },
          [ { message_proxy_supervisor,
              { message_proxy_supervisor, start_link, Args },
              permanent,
              infinity,
              supervisor,
              [ message_proxy_supervisor ] },
           { channel_supervisor,
             { channel_supervisor, start_link, [] },
             permanent,
             infinity,
             supervisor,
             [ channel_supervisor ] }
         ]
        } }.
