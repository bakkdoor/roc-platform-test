app "TestApp"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.2.0/8tCohJeXMBUnjo_zdMq0jSaqdYoCWJkWazBd4wa8cQU.tar.br",
        tpf: "../src/main.roc"
    }
    imports [
        pf.Stdout, pf.Task.{ Task },
        tpf.TestPlatform.{ checkNum }
    ]
    provides [main] to pf


main : Task {} []
main =
    _ <- (checkNum 0) |> printResult |> Task.await
    _ <- (checkNum 5) |> printResult |> Task.await
    _ <- (checkNum 10) |> printResult |> Task.await
    (checkNum 20) |> printResult


printResult = \task ->
    result <- Task.attempt task
    when result is
        Ok val ->
            Stdout.line (Str.concat "Valid value given: " (Num.toStr val))
        Err (ToLow val) ->
            Stdout.line (Str.concat "Too low value given: " (Num.toStr val))
        Err (ToHigh val) ->
            Stdout.line (Str.concat "Too high value given: " (Num.toStr val))
