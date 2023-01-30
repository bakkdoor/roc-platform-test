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
        10 ->
            Task.fail (ToHigh num)
        _ ->
            if num < 10 then
                Task.succeed num
            else
                Task.fail (ToHigh num)
