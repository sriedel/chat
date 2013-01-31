-module( message_receiver_supervisor ).
-export( [ start_link/1, init/1 ] ).
-behavior( supervisor ).

start_link( Args ) ->
  supervisor:start_link( {local, ?MODULE}, ?MODULE, Args ).

init(Args) ->
  { ok, { { one_for_one, 3, 10 },
          [ { message_receiver,
              { message_receiver, start_link, Args },
              permanent,
              1000,
              worker,
              [ message_receiver ] 
            } ] 
        } }.
