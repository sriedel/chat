-module( message_router ).
-behavior( gen_event ).
-export( [ create_channel/1, destroy_channel/1, subscribe_client/2, unsubscribe_client/2] ).
-export( [ init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2, code_change/3 ] ).

create_channel( ChannelName ) ->
  gen_event:start( { global, ChannelName } ).

destroy_channel( ChannelName ) ->
  gen_event:stop( { global, ChannelName } ).

subscribe_client( ClientRef, ChannelName ) ->
  gen_event:add_handler( ChannelName, { client, ClientRef }, [ChannelName] ).

unsubscribe_client( ClientRef, ChannelName ) ->
  gen_event:delete_handler( ChannelName, { client, ClientRef }, [] ).

%% gen_event callbacks
init([ChannelName]) -> 
  {ok, [ChannelName]}.

handle_event( {message, Channel, MessageRef, Message}, State) -> 
  gen_server:abcast( nodes(), message_proxy, { message, Channel, MessageRef, Message } ),
  {ok, State}.

handle_call(_Request, State) -> 
  Reply = [],
  {ok, Reply, State}.

handle_info(_Info, State) -> 
  {ok, State}.

terminate( _Reason, _State) -> 
  ok.

code_change(_OldVsn, State, _Extra) -> 
  {ok, State}.
