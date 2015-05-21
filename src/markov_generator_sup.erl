%%%-------------------------------------------------------------------
%% @doc markov top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(markov_generator_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
        RestartStrategy = one_for_all,
        MaxRestarts = 1000,
        MaxSecondsBetweenRestarts = 3600,

        SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

        Restart = permanent,
        Shutdown = 2000,
        Type = worker,

        Child = {markov_generator, {markov_generator, start_link, []},
                          Restart, Shutdown, Type, [markov_generator]},

        {ok, {SupFlags, [Child]}}.
%%====================================================================
%% Internal functions
%%====================================================================
