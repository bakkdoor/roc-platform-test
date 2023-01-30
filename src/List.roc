interface TestPlatform
    exposes [range, rangeAcc, quickSort, doSort]
    imports [pf.Task.{ Task }]

range : Nat, Nat -> List Nat
range = \min, max ->
    rangeAcc min max (List.withCapacity (max - min))

rangeAcc : Nat, Nat, List Nat -> List Nat
rangeAcc = \min, max, acc ->
    if min > max then
        acc
    else
        rangeAcc (min + 1) max (acc |> List.append min)

quickSort : List (Num a) -> List (Num a)
quickSort = \list ->
    when list is
        [] ->
            []

        [x] ->
            [x]

        [pivot, ..] ->
            left =
                list |> List.keepIf (\x -> x < pivot)
            right =
                list |> List.keepIf (\x -> x > pivot)

            List.withCapacity (List.len list)
            |> List.concat(left |> quickSort)
            |> List.append pivot
            |> List.concat(right |> quickSort)

doSort : Nat -> List (List Nat)
doSort = \max ->
    range 1 max
    |> List.reverse
    |> List.map \n ->
        range 1 n
        |> List.reverse
        |> quickSort
