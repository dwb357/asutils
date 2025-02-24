# Logging

Flexible and powerful logging capabilities.

## ``LogWriter``

`LogWriter` implementations can be strung together to create powerful and flexible
logging, with a wide variety of standard and customized filtering, formatting, and,
reporting options.

### Basic Usage

1. Create a `LogWriter`:

    let logWriter = PrintLogWriter()

2. Log messages using the `LogWriter`:

    logWriter.trace("Entering function")

### Filtering

Messages to be logged can be filtered by using the `LogWriter.filter` function variants.

To filter only those messages with a level greater than `warning`:

    let logWriter = PrintLogWriter().filter(level: .warning)

Note that an "immutable builder" model is used, so `.filter` returns a new `LogWriter`
instance to be used in place of the original.

### Formatting

Messages can be logged with varying formatting options use the `LogWriter.format` function
variants.

``LogFormatter`` defines various "standard" predefined log formats.  To use one of these formats:

    let logWriter = PrintLogWriter().format(.full)

Again, note that an "immutable builder" model is used, so `.format` returns a new `LogWriter`
instance which should be used in place of the original.

Custom message formats can also be used:

    let logWriter = PrintLogWriter().format { record in
        "\(record.category ?? "")\(record.level): \(record.message)"
    }

## ``StaticLogger``

The `StaticLogger` protocol provides default implementations of logging throughout a
module referencing a singleton instance of ``LogWriter``.  The `LogWriter` itself can
be customized as required.

Example usage:

     enum Log: StaticLogger {
         nonisolated(unsafe) static var instance: LogWriter = PrintLogWriter()
         nonisolated(unsafe) static let category: String? = nil
     }

Once that's done, messages can be logged via `instance` using simple static methods. If `category`
is specified, it will be used as a default category for all messages logged using the `StaticLogger`.

     Log.trace("Reached checkpoint")

To log to both a file and the print console:

     Log.instance = SharedLogWriter(
         FileLogWriter("log"),
         PrintLogWriter()
     ).filter(minLevel: .warning)

`SharedLogWriter` and `filter` can also be combined to log different categories of messages
using different loggers:

     Log.instance = SharedLogWriter(
         FileLogWriter("log"),
         SystemLogWriter().filter(categories: "CORE")
     )

The format of logged messages can be set with the ``LogWriter.format`` function:

     Log.instance = SystemLogWriter().format(.simple)

As with filter, different loggers can use different formats:

     Log.instance = SharedLogWriter(
         FileLogWriter("log").format(.full),
         PrintLogWriter().format(.simple)
     )

