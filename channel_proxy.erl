-module( channel_proxy ).
-export( [ create_channel/1, destroy_channel/1, subscribe_client/2, unsubscribe_client/2 ] ).

create_channel( Channel ) ->
  channel_manager:create_channel( Channel ).

destroy_channel( Channel ) ->
  channel_manager:destroy_channel( Channel ).

subscribe_client( ClientRef, Channel ) ->
  % FIXME: Racecondition here!
  case whereis( Channel ) of
    undefined -> supervisor:start_child( channel_supervisor, [ Channel ] ) ;
    true      -> true
  end,
  gen_event:add_handler( Channel, { client, ClientRef }, [ Channel ] ).

unsubscribe_client( ClientRef, Channel ) ->
  gen_event:delete_handler( Channel, { client, ClientRef }, [ unsubscribed ] ),
  case gen_event:which_handlers( Channel ) of
    [] -> gen_event:stop( Channel ) ;
    true -> true
  end.

