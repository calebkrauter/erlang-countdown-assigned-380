-module(countdown).

-export([readTransmission/1, discoverBase/1]).

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
% 87 is our offset to ensure that alphabetical characters are represented in up to base 35
% a = 97 if Val >= 97 then evaluate Val - 87. 
% 
% Get first atom and check if it is bigger than our biggested accumulated base. If it is then update accumulated base.
% Accumulate with formula to check base. Formula is CurBase^(n-1) + C * CurBase^(n-2) + ... 
% When the formula equals the original value, then evalute to the base.
% 
% 8> cd("C:/Users/Kraut/Documents/Workspace/erlang-countdown-assigned-380").
% c:/Users/Kraut/Documents/Workspace/erlang-countdown-assigned-380
% ok
% 9> c(countdown).
% 


% Pass in list N.
discoverBase ( N ) -> discoverBase(N, 0).
% Pass in the list N and the base starting at 0.
% 
% 
% 
% discoverBase([], _) -> [];
discoverBase([H | T], PrevBase) when (H =< 57) -> discoverBase(T, getBigestRadix(H - 48 + 1, PrevBase));
                                           
discoverBase([H | T], PrevBase) when (H >= 97) -> discoverBase(T, getBigestRadix(H - 87 + 1, PrevBase));
discoverBase([], FinalRadix) -> FinalRadix.

getBigestRadix(CurBiggestRadix, PrevBase) when (CurBiggestRadix > PrevBase)-> CurBiggestRadix;
getBigestRadix(CurBiggestRadix, PrevBase) when (CurBiggestRadix =< PrevBase)-> PrevBase;

getBigestRadix([], PrevBase) -> PrevBase.

% convertToDecFromAlphabet ( ) convertToDecFromAlphabet ( Val ) when ( Val > 9 and Val == a ) -> 10 ; convertToDecFromAlphabet ( Val ) -> 10 + ( Val - a ) .

% convertToDecFromAlphabet(Val) when (Val > a) -> convertToDecFromAlphabet(10);

% Helpers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
