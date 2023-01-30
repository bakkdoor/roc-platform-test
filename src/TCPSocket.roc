interface TCPSocket
    exposes [TCPSocket, TCPSocketError, connect, close, send, receive, receiveAll]
    imports []

TCPSocketError : [
    TCPInvalidHost Str,
    TCPInvalidPort Nat,
    TCPConnectionFailed Str,
]

# TODO:
TCPSocketHandle: Str

TCPSocket : {
    socketHandle: TCPSocketHandle
}

Host : Str
Port : Nat

connect : Host, Port -> TCPSocket

send : Str -> TCPSocket

receive : Nat -> Str

close : TCPSocket -> TCPSocket

receiveAll : TCPSocket -> Str
