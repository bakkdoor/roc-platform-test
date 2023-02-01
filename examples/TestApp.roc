app "TestApp"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.2.0/8tCohJeXMBUnjo_zdMq0jSaqdYoCWJkWazBd4wa8cQU.tar.br",
        tpf: "../src/main.roc"
    }
    imports [
        pf.Stdout, pf.Task.{ Task },
        tpf.TaskUtil.{ seqTasks }
    ]
    provides [main] to pf


main : Task {} []
main =
    Stdout.line "1"
    |> seqTasks [
        Stdout.line "2",
        Stdout.line "3",
        Stdout.line "4"
    ]
