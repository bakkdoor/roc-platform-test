app "BuildFail2"
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
        multiTask [
            Stdout.line "1",
            Stdout.line "2",
            Stdout.line "3",
        ]
        |> Task.onFail (\_ ->
            Stdout.line "FAIL!"
        )
    )

    Stdout.line "4"



# multiTask : List (Task a err) -> Task a [NoTasksGiven]err
multiTask = \tasks ->
    when tasks is
        [] ->
            Task.fail NoTasksGiven

        [task] ->
            task

        [firstTask, ..] ->
            remainingTasks = List.drop tasks 1

            remainingTasks
            |> List.walk firstTask (\currTask, nextTask ->
                _ <- Task.await currTask
                nextTask
            )
