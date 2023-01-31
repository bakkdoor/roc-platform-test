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


splitIntoChunks : List a, Nat -> List (List a)
splitIntoChunks = \list, chunkSize ->
    count = List.len list

    when chunkSize is
        0 -> []
        cs if count < cs ->
            when list is
                [] -> []
                _ -> [list]
        _ ->
            List.withCapacity (
                count
                |> Num.toFrac
                |> Num.div (chunkSize |> Num.toFrac)
                |> Num.ceiling
            )
            |> List.append (
                list
                |> List.takeFirst chunkSize
            )
            |> List.concat (
                list
                |> List.drop chunkSize
                |> splitIntoChunks chunkSize
            )


flatten : List (List a) -> List a
flatten = \list ->
    flattenAcc list []

flattenAcc : List (List a), List a -> List a
flattenAcc = \list, acc ->
    when list is
        [] ->
            acc
        [head, ..] ->
            tail =
                List.drop list 1
            newAcc =
                ((List.len acc) + (List.len head))
                |> List.withCapacity
                |> List.concat acc
                |> List.concat head

            flattenAcc tail newAcc

