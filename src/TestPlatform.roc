interface TestPlatform
    exposes [doStuff, doMoreStuff]
    imports [pf.Task.{Task}]

doStuff : Str -> Task Str []
doStuff = \string ->
    Task.succeed string


doMoreStuff : Str -> Task Str []
doMoreStuff = \string ->
    Task.succeed (Str.concat string string)
