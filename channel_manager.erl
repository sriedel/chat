-module( channel_manager ).
-behavior( gen_server ).
-export( [ start_link/0, start_link/1, create_channel/1, destroy_channel/1 ] ).
-export( [ init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3 ] ).

start_link() ->
  gen_server:start_link( { global, ?MODULE }, ?MODULE, [], [] ).

start_link( Args ) ->
  gen_server:start_link( { global, ?MODULE }, ?MODULE, Args, [] ).

create_channel( Channel ) ->
  gen_server:call( { global, ?MODULE }, { create, Channel } ).

destroy_channel( Channel ) ->
  gen_server:call( { global, ?MODULE }, { destroy, Channel } ).

%% gen_server callbacks
init([]) ->
  { ok, [] }.

handle_call( {create, Channel}, _From, State ) ->
  supervisor:start_child( { global, message_router_supervisor }, [ Channel ] ),
  gen_event:add_handler( { global, Channel }, { message_router, Channel }, [ Channel ] ),
  { reply, { created, Channel }, State };

handle_call( { destroy, Channel }, _From, State ) ->
  gen_event:delete_handler( { global, Channel }, { message_router, Channel }, [] ),
  gen_event:stop( { global, Channel } ),
  { reply, { destroyed, Channel }, State }.

handle_cast( _Msg, State ) -> { noreply, State }.

handle_info( _Info, State ) -> { noreply, State }.

terminate( _Reason, _State ) -> ok.

code_change( _OldVersion, State, _Extra ) -> { ok, State }.

