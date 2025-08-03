# ``DegreesMinutesSecondsFormatStyle``

@Metadata {
    @DocumentationExtension(mergeBehavior: append)
}

## Formatting

Generate a string representation of a coordinate in the ``CoordinateFormat/degreesMinutesSeconds`` coordinate format.

```swift
let coordinate = CLLocationCoordinate2D(latitude: 48.11638, longitude: -122.77527)

coordinate.formatted(.degreesMinutesSeconds)
// 48° 6' 59", -122° 46' 31"
```

> Tip: There are 60 minutes in a degree.

### Symbol Style

Examples of using ``SymbolStyle``.


```swift
coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.none))
// 48 6 59, -122 46 31

coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.simple))
// 48° 6' 59", -122° 46' 31"

coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.traditional))
// 48° 6′ 59″, -122° 46′ 31″
```

### Options

Examples of ``DisplayOptions``.

```swift
coordinate.formatted(.degreesMinutesSeconds.options(.compact))
// 48°6'59", -122°46'31"

coordinate.formatted(.degreesMinutesSeconds.options(.suffix))
// 48° 6' 59" N, 122° 46' 31" W

coordinate.formatted(.degreesMinutesSeconds.options([.compact, .suffix]))
// 48°6'59"N, 122°46'31"W
```

## Parsing

Initialize a coordinate by parsing a string using the ``CoordinateFormat/degreesMinutesSeconds`` coordinate format.

```swift
let style = CLLocationCoordinate2D.DegreesMinutesSecondsFormatStyle()

do {
    let coordinate = try CLLocationCoordinate2D("48° 6′ 59″ N, 122° 46′ 31″ W", parseStrategy: style.parseStrategy)
    print(coordinate) 
    // CLLocationCoordinate2D(latitude: 48.11638888888889, longitude: -122.77527777777777)
} catch {
    print(error.localizedDescription)
}

```

## See Also

- ``CoordinateFormat/degreesMinutesSeconds``
- ``SymbolStyle``
- ``DisplayOptions``



<!--- ``LocationFormatter/CoordinateFormat/decimalDegrees``-->
<!--- ``LocationFormatter/CoordinateFormat/degreesMinutesSeconds``-->
<!--- ``LocationFormatter/CoordinateFormat/utm``-->
<!--- ``LocationFormatter/DisplayOptions``-->
<!--- ``LocationFormatter/SymbolStyle``-->
