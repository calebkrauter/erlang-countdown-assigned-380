-module(countdown).

-export([readTransmission/1]).

readTransmission(FileName) ->
    File = openFile(file:open(FileName, read)),
    readLines(io:parse_erl_exprs(File, ''), File).

openFile({ok, File}) ->
    File;
openFile({error, Reason}) ->
    erlang:error(Reason).

readLines({eof, _}, _) ->
    [];
readLines({ok, [{string, 1, Value}], _}, File) ->
    [Value | readLines(io:parse_erl_exprs(File, ''), File)].

% Assigned Functions %%%%%%%%%%%%%%%%%%%%%%%%

% Helpers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% we will add to our count. This may be achievable using tail recursion.
%
% 123
% |
% val
%
discoverBase ( N ) -> .

accumulateForMinRadix(CurRadix, LastRadix) when CurRadix > LastRadix ->
    CurRadix;
accumulateForMinRadix(_, LastRadix) ->
    LastRadix.

convertToDecFromAlphabet ( ) convertToDecFromAlphabet ( Val ) when ( Val > 9 and Val == a ) -> 10 ; convertToDecFromAlphabet ( Val ) -> 10 + ( Val - a ) .

% convertToDecFromAlphabet(Val) when (Val > a) -> convertToDecFromAlphabet(10);

% Helpers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
