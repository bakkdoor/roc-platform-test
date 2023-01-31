platform "rocozo"
    requires {} { main : Task {} [] }
    exposes [TestPlatform, List]
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.2.0/8tCohJeXMBUnjo_zdMq0jSaqdYoCWJkWazBd4wa8cQU.tar.br"
    }
    imports [pf.Task.{ Task }]
    provides [mainForHost]

mainForHost : Task {} [] as Fx
mainForHost = main
