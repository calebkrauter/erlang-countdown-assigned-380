-module(countdown).

-export([readTransmission/1, discoverBase/1, howLongDoWeHave/1, getLengthOfList/2]).

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



% D represents the current digit from left to right.
% B represents the base we convert from.
% P represents the position from right to left of the current Digit.
% D1 * B^P + D2 * B^(P-1) ... D5 * B^(0)
% Get the smallest one.
% Recursively take remainder of the base10 value divided by 2 and store into a list.
% 
% TODO - find the smallest value in the list and convert to binary.
% TODO - currently it returns the last element in the list's calculation to the formula.
howLongDoWeHave(L) -> howLongDoWeHave(L, 0).
howLongDoWeHave([], Result) -> Result;
%               "abc"|[]     0                           []              "abc""abc"           "abc"  
%                                                           This is where the result of the calculation on the last element in the list is returned.
%                                                           This is where we need to determine the smallest of the list by accumulating to a new list the smallest value out of the values in the og list.
howLongDoWeHave([H | T], CurSmallest) -> howLongDoWeHave(T, getBaseTenOf(H, H, getLengthOfList(H, -1))).
%            a,  bc    abc     2          a             a *       base of abc is 13^2     +              bc  abc     1
%             b   c    abc     1          b            b *               abc is 13^1    +               c   abc     0
%             c   []   abc     0          c            c *               12^0  \
% my pos * pos is wrong. It should be left to power of pos
getBaseTenOf([], _, -1) -> 0;
getBaseTenOf([H | T], CurNum, Pos) when (H =< 57) -> (((H - 48) * math:pow(discoverBase(CurNum), Pos))) + getBaseTenOf(T, CurNum, Pos - 1);
getBaseTenOf([H | T], CurNum, Pos) when (H >= 97) -> (((H - 87) * math:pow(discoverBase(CurNum), Pos))) + getBaseTenOf(T, CurNum, Pos - 1).
%                a  bc
%                b   c
%   
% Get length works.             
getLengthOfList([H | T], Index) -> getLengthOfList(T, Index + 1);
getLengthOfList([], Index) -> Index.

% pow(Val, 1) -> Val; 
% pow(Val, Exponent) -> Val * pow(Val, Exponent - 1).
% Maybe tail recursion would help?
% pow(Val, Exponent, Acc) -> pow(Val, Exponent - 1, Acc * Val)

% Modify this to use for getting the smallest numerical valued element of a list.
%     getSmallest(CurBiggestRadix, PrevBase) when (CurBiggestRadix > PrevBase)-> CurBiggestRadix;
% getSmallest(CurBiggestRadix, PrevBase) when (CurBiggestRadix =< PrevBase)-> PrevBase;











% Pass in list N.
discoverBase ( N ) -> discoverBase(N, 0).
% Pass in the list N and the base starting at 0.
% 
discoverBase([H | T], PrevBase) when (H =< 57) -> discoverBase(T, getBigestRadix(H - 48 + 1, PrevBase));
                                           
discoverBase([H | T], PrevBase) when (H >= 97) -> discoverBase(T, getBigestRadix(H - 87 + 1, PrevBase));
discoverBase([], FinalRadix) -> FinalRadix.

getBigestRadix(CurBiggestRadix, PrevBase) when (CurBiggestRadix > PrevBase)-> CurBiggestRadix;
getBigestRadix(CurBiggestRadix, PrevBase) when (CurBiggestRadix =< PrevBase)-> PrevBase;

getBigestRadix([], PrevBase) -> PrevBase.

% convertToDecFromAlphabet ( ) convertToDecFromAlphabet ( Val ) when ( Val > 9 and Val == a ) -> 10 ; convertToDecFromAlphabet ( Val ) -> 10 + ( Val - a ) .

% convertToDecFromAlphabet(Val) when (Val > a) -> convertToDecFromAlphabet(10);

% Helpers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
