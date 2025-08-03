# ``UTMFormatStyle``

## Overview

A format representing a coordinate using the [Universal Transverse Mercator (UTM)](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) coordinate system.

## Formatting

Generate a string representation of a coordinate in the UTM coordinate format.

```swift
let coordinate = CLLocationCoordinate2D(latitude: 48.11638, longitude: -122.77527)

coordinate.formatted(.utm) 
// 10U 516726m E 5329260m N

coordinate.formatted(.utm.options(.compact))
// 10U 516726m 5329260m

coordinate.formatted(.utm.options(.suffix)))
// 10U 516726m E 5329260m N

coordinate.formatted(.utm.options([.compact, .suffix])))
// 10U 516726mE 5329260mN

```

## Parsing

Initialize a coordinate by parsing a string using the Decimal Degrees coordinate format style.

```swift
let style = UTMFormatStyle()

do {
    let coordinate = try CLLocationCoordinate2D("48.11638° N, 122.77527° W", parseStrategy: style.parseStrategy)
    print(coordinate) 
    // CLLocationCoordinate2D(latitude: 48.116380622937946, longitude: -122.77527139988439)
} catch {
    print(error.localizedDescription)
}

```

## See Also

- ``CoordinateFormat/utm``
- ``SymbolStyle``
- ``DisplayOptions``
