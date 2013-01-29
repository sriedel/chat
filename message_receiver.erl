-module( message_receiver ).
-behavior( gen_server ).
-export( [ start_link/1, message/1 ] ).
-export( [ init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3 ] ).

%% interface methods
start_link( GlobalChannelHandler ) ->
  gen_server:start_link( {local, ?MODULE}, ?MODULE, [ GlobalChannelHandler ], [] ).

message( Message ) ->
  gen_server:call( ?MODULE, { message, Message } ).

%% gen_server callbacks
init([ChannelHandler]) ->
  { ok, ChannelHandler }.

handle_call( {message, Message}, _From, ChannelHandler ) ->
  gen_event:notify( ChannelHandler, { message, Message } ),
  { reply, message, ChannelHandler }.

handle_cast( _Msg, State ) -> { noreply, State }.

handle_info( _Info, State ) -> { noreply, State }.

terminate( _Reason, _State ) -> ok.

code_change( _OldVersion, State, _Extra ) -> { ok, State }.

