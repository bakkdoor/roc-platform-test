app "TestApp"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.2.0/8tCohJeXMBUnjo_zdMq0jSaqdYoCWJkWazBd4wa8cQU.tar.br",
        tpf: "../src/main.roc"
    }
    imports [
        pf.Stdout, pf.Task.{ Task },
        tpf.TestPlatform.{doStuff, doMoreStuff}
    ]
    provides [main] to pf

main : Task {} []
main =
    a <- Task.await (doStuff "Text 1")
    b <- Task.await (doMoreStuff "Text 2")
    Stdout.line (Str.concat a b)
