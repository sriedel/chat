-module( channel_router ).
-export( [ create_channel/1, destroy_channel/1, subscribe_client/2, unsubscribe_client/2] ).

create_channel( ChannelName ) ->
  gen_event:start( { local, ChannelName } ).

destroy_channel( ChannelName ) ->
  gen_event:stop( { local, ChannelName } ).

subscribe_client( ClientRef, ChannelName ) ->
  gen_event:add_handler( ChannelName, { client, ClientRef }, [ChannelName] ).

unsubscribe_client( ClientRef, ChannelName ) ->
  gen_event:delete_handler( ChannelName, { client, ClientRef }, [] ).
