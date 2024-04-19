-module(countdown).

-export([readTransmission/1]).

readTransmission(FileName) ->
    File = openFile(file:open(FileName, read)),
    readLines(io:parse_erl_exprs(File, ''), File).

openFile({ok, File}) -> File;
openFile({error, Reason}) -> erlang:error(Reason).

readLines({eof, _}, _) -> [];
readLines({ok, [{string, 1, Value}], _}, File) ->
    [Value | readLines(io:parse_erl_exprs(File, ''), File)].

% Assigned Functions %%%%%%%%%%%%%%%%%%%%%%%%



% Helpers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
