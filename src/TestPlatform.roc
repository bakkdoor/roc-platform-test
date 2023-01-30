interface TestPlatform
    exposes [doStuff, doMoreStuff, doEvenMoreStuff]
    imports [pf.Task.{Task}]

doStuff : Str -> Task Str []
doStuff = \string ->
    Task.succeed string


doMoreStuff : Str -> Task Str []
doMoreStuff = \string ->
    Task.succeed (Str.concat string string)


doEvenMoreStuff : Nat -> Task Nat [ToLow Nat, ToHigh Nat]
doEvenMoreStuff = \num ->
    when num is
        0 ->
            Task.fail (ToLow num)

        x if x < 10 ->
            Task.succeed num

        _ ->
            Task.fail (ToHigh num)
