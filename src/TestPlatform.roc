interface TestPlatform
    exposes [checkNum, max, min, abs, greatestDistanceVec3, graphDBConnect, GraphDBConnectInfo]
    imports [pf.Task.{ Task }, TCPSocket.{ TCPSocket }]


checkNum : Nat -> Task Nat [ToLow Nat, ToHigh Nat]
checkNum = \num ->
    when num is
        0 ->
            Task.fail (ToLow num)

        x if x < 10 ->
            Task.succeed num

        _ ->
            Task.fail (ToHigh num)



max : Num a, Num a -> Num a
max = \a, b ->
    if a > b then
        a
    else
        b

min : Num a, Num a -> Num a
min = \a, b ->
    if a < b then
        a
    else
        b

abs : Num a -> Num a
abs = \a ->
    if a < 0 then
        -a
    else
        a

Vec3 : { x: F32, y: F32, z: F32 }

greatestDistanceVec3 : Vec3, Vec3 -> F32
greatestDistanceVec3 = \a, b ->
    x = abs (a.x - b.x)
    y = abs (a.y - b.y)
    z = abs (a.z - b.z)

    max x (max y z)

GraphDBConnectInfo : { host: Str, port: Nat, user: Str, password: Str, database: Str}

DBConnection : {
    host: Str,
    port: Nat,
    user: Str,
    password: Str,
    database: Str,
    connection: TCPSocket
}

DBConnectionError : [
    InvalidHost Str,
    InvalidPort Nat,
    InvalidUser Str,
    InvalidPassword Str,
    InvalidDatabase Str,
    ConnectionFailed Str,
]

graphDBConnect : GraphDBConnectInfo -> Task DBConnection DBConnectionError
graphDBConnect = \info ->
    Task.succeed {
        host: info.host,
        port: info.port,
        user: info.user,
        password: info.password,
        database: info.database,
        connection: TCPSocket.connect info.host info.port
    }
