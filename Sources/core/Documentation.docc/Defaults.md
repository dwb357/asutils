# Providing Defaults for Testing

``Provided`` can be used to provide default values, primarily for testing purposes.

## Implementations

Default implementations are provided for:

- `Date()`
- `UUID()`

## Usage

A new provider can be set for a ``Provided`` class by simple assignment:

```
    Date.provider = { Date(0) }
```

The next available value for a ``Provided`` class is similarly accessed via the `provided` property.

```
    print("\(Date.provided)")
```
