interface TestPlatform
    exposes [checkNum]
    imports [pf.Task.{ Task }]


checkNum : Nat -> Task Nat [ToLow Nat, ToHigh Nat]
checkNum = \num ->
    when num is
        0 ->
            Task.fail (ToLow num)

        x if x < 10 ->
            Task.succeed num

        _ ->
            Task.fail (ToHigh num)
