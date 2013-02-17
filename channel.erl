-module( channel ).
-export( [ start_link/1, init/1 ] ).

start_link( Channel ) ->
  gen_event:start_link( { local, Channel } ).

init( Channel ) ->
  process_flag( trap_exit, true ),
  { ok, Channel }.

