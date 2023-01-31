app "TestApp"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.2.0/8tCohJeXMBUnjo_zdMq0jSaqdYoCWJkWazBd4wa8cQU.tar.br"
    }
    imports [
        pf.Stdout, pf.Task.{ Task }
    ]
    provides [main] to pf


main : Task {} []
main =
    _ <- Task.await (
        _ <- Task.await (Stdout.line "1")
        _ <- Task.await (Stdout.line "2")
        Stdout.line "3"
    )

    Stdout.line "4"
