app "BuildFail"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.2.0/8tCohJeXMBUnjo_zdMq0jSaqdYoCWJkWazBd4wa8cQU.tar.br"
    }
    imports [
        pf.Stdout, pf.Task.{ Task }
    ]
    provides [main] to pf


main : Task {} []
main =
    _ <- Task.await (multiTaskList [
        Stdout.line "1",
        Stdout.line "2",
        Stdout.line "3",
    ])

    Stdout.line "4"


multiTaskList : List (Task a err) -> Task (List a) err
multiTaskList = \tasks ->
    when tasks is
        [] ->
            Task.succeed []

        [task] ->
            task
            |> Task.map (\value -> [value])

        [firstTask, ..] ->
            remainingTasks = List.drop tasks 1

            value <- Task.await firstTask

            remainingTasks
            |> multiTaskList
            |> Task.map (\values ->
                values
                |> List.prepend value
            )
