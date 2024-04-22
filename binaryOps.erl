-module(binaryOps).
-export([binNegate/1]).

binNegate(BinL) -> binNegate(BinL, 0, false).
binNegate([], _, _) -> [];
binNegate([H | T], IncrementWhenFirstFlipTo1, _) when (H =:= 0) -> ['1' | binNegate(T, IncrementWhenFirstFlipTo1, true)];
binNegate([H | T], IncrementWhenFirstFlipTo1, false) when (H =:= 1) -> binNegate(T, IncrementWhenFirstFlipTo1, false);
binNegate([H | T], IncrementWhenFirstFlipTo1, true) when (H =:= 1) -> ['0' | binNegate(T, IncrementWhenFirstFlipTo1, true)].