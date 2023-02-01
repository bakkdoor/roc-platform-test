interface TaskUtil
    exposes [seqTasks]
    imports [pf.Task.{ Task }]


seqTasks : Task a err, List (Task a err) -> Task a err
seqTasks = \firstTask, remainingTasks ->
    remainingTasks
    |> List.walk firstTask (\currTask, nextTask ->
        _ <- Task.await currTask
        nextTask
    )
