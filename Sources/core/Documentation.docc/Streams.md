# Stream Handling

Utilities to simplify dealing with `InputStream` and `OutputStream`
but also abstractions of other classes that need to be opened and/or
closed when used.

## Opening and Closing Streams

``HasOpen``, ``HasClose``, and ``HasOpenAndClose`` can be used in conjunction
with the various `use` implementations to guarantee that streams are opened
and closed when used.

- ``HasOpen``, ``HasOpen/use(_:)`` - automatically open streams when used
- ``HasClose``, ``HasClose/use(_:)`` - automatically close streams when used
- ``HasOpenAndClose``, ``HasOpenAndClose/use(_:)`` - automatically open and close 
streams when used

## Writing to Streams

- ``Foundation/OutputStream/write(_:)`` - to write `Data` to a stream.
- ``Foundation/OutputStream/write(_:using:allowLossyConversion:)`` - to write a `String` to a stream.
- ``Foundation/OutputStream/write(_:)`` - to write an `Encodable` item to a stream.
