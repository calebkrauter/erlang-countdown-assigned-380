-module(countdown).

-export([readTransmission/1, discoverBase/1, howLongDoWeHave/1, getLengthOfList/2, getSmallestOfTheBaseTenValues/2, convertToBinary/1, generateBinaryConverter/1]).

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

% Path for testing.
% cd("C:/Users/Kraut/Documents/Workspace/erlang-countdown-assigned-380").


% D1 * B^P + D2 * B^(P-1) ... D5 * B^(0)

% for testing
% 20> countdown:howLongDoWeHave(["abc", "12321", "789", "1face", "z1"]).
% [1,0,0,1,1,1,0,1,1]
howLongDoWeHave(L) -> howLongDoWeHave(L, 0, []).
howLongDoWeHave([], Result, ResultList) -> convertToBinary(trunc(getSmallestOfTheBaseTenValues(getHeadOfList(ResultList), ResultList)));
howLongDoWeHave([H | T], CurSmallest, ListOfBaseTen) -> howLongDoWeHave(T, getBaseTenOf(H, H, getLengthOfList(H, -1)), accumListOfBaseTen(getBaseTenOf(H, H, getLengthOfList(H, -1)), ListOfBaseTen)).

getBaseTenOf([], _, -1) -> 0;
getBaseTenOf([H | T], CurNum, Pos) when (H =< 57) -> (((H - 48) * math:pow(discoverBase(CurNum), Pos))) + getBaseTenOf(T, CurNum, Pos - 1);
getBaseTenOf([H | T], CurNum, Pos) when (H >= 97) -> (((H - 87) * math:pow(discoverBase(CurNum), Pos))) + getBaseTenOf(T, CurNum, Pos - 1).

getBaseTenOfWithKnownRadix([], _, -1) -> 0;
getBaseTenOfWithKnownRadix([H | T], Radix, Pos) when (H =< 57) -> (((H - 48) * math:pow((Radix), Pos))) + getBaseTenOfWithKnownRadix(T, Radix, Pos - 1);
getBaseTenOfWithKnownRadix([H | T], Radix, Pos) when (H >= 97) -> (((H - 87) * math:pow((Radix), Pos))) + getBaseTenOfWithKnownRadix(T, Radix, Pos - 1).

getLengthOfList([H | T], Index) -> getLengthOfList(T, Index + 1);
getLengthOfList([], Index) -> Index.
 
accumListOfBaseTen(CurBaseTenVal, CurListOfBaseTen) -> accumListOfBaseTen([CurBaseTenVal | CurListOfBaseTen]).
accumListOfBaseTen(NewList) -> NewList.

% start with first value, compare with the next values until there is a smaller value, then update value with the smaller one and continue.
getSmallestOfTheBaseTenValues(SmallestVal, [H | T]) when (SmallestVal =< H)-> getSmallestOfTheBaseTenValues(SmallestVal, T);
getSmallestOfTheBaseTenValues(SmallestVal, [H | T]) -> getSmallestOfTheBaseTenValues(H, T);
getSmallestOfTheBaseTenValues(SmallestVal, []) -> SmallestVal.

getHeadOfList([H | _]) -> H.

convertToBinary(0) -> [];
convertToBinary(SmallestBaseTenValue) -> [SmallestBaseTenValue rem 2 | convertToBinary(SmallestBaseTenValue div 2)].

discoverBase ( N ) -> discoverBase(N, 0).
discoverBase([H | T], PrevBase) when (H =< 57) -> discoverBase(T, getBigestRadix(H - 48 + 1, PrevBase));                                          
discoverBase([H | T], PrevBase) when (H >= 97) -> discoverBase(T, getBigestRadix(H - 87 + 1, PrevBase));
discoverBase([], FinalRadix) -> FinalRadix.

getBigestRadix(CurBiggestRadix, PrevBase) when (CurBiggestRadix > PrevBase)-> CurBiggestRadix;
getBigestRadix(CurBiggestRadix, PrevBase) when (CurBiggestRadix =< PrevBase)-> PrevBase;
getBigestRadix([], PrevBase) -> PrevBase.


%  For generateBinaryConverter Do the following.
% Take a value with an unknown radix
% 
% Convert with radix to base 10. Convert to binary
%  getBaseTenOf(H, H, getLengthOfList(H, -1))
generateBinaryConverter(R) -> fun(N) -> convertToBinary(trunc(getBaseTenOfWithKnownRadix(N, R, getLengthOfList(N, -1)))) end.