# ``DegreesDecimalMinutesFormatStyle``

@Metadata {
    @DocumentationExtension(mergeBehavior: append)
}

## Formatting

Generate a string representation of a coordinate in the ``CoordinateFormat/degreesDecimalMinutes`` coordinate format.

```swift
let coordinate = CLLocationCoordinate2D(latitude: 48.11638, longitude: -122.77527)

coordinate.formatted(.degreesDecimalMinutes)
// 48° 06.983', -122° 46.516'
```

> Tip: There are 60 minutes in a degree.

### Symbol Style

Examples of using ``SymbolStyle``.


```swift
coordinate.formatted(.degreesDecimalMinutes.symbolStyle(.none))
// 48 06.983, -122 46.516

coordinate.formatted(.degreesDecimalMinutes.symbolStyle(.simple))
// 48° 06.983', -122° 46.516'

coordinate.formatted(.degreesDecimalMinutes.symbolStyle(.traditional))
// 48° 06.983′, -122° 46.516′
```

### Options

Examples of ``DisplayOptions``.

```swift
coordinate.formatted(.degreesDecimalMinutes.options(.compact))
// 48°06.983', -122°46.516'

coordinate.formatted(.degreesDecimalMinutes.options(.suffix))
// 48° 06.983' N, 122° 46.516' W

coordinate.formatted(.degreesDecimalMinutes.options([.compact, .suffix]))
// 48°06.983'N, 122°46.516'W
```



## Parsing

Initialize a coordinate by parsing a string using the ``CoordinateFormat/degreesDecimalMinutes`` coordinate format.

```swift
let style = CLLocationCoordinate2D.DegreesDecimalMinutesFormatStyle()

do {
let coordinate = try CLLocationCoordinate2D("48° 06.983′, -122° 46.516′" , parseStrategy: style.parseStrategy)
    print(coordinate) 
    // CLLocationCoordinate2D(latitude: 48.11638333333333, longitude: -122.77526666666667)
} catch {
    print(error.localizedDescription)
}

```

## See Also

- ``CoordinateFormat/degreesDecimalMinutes``
- ``SymbolStyle``
- ``DisplayOptions``



<!--- ``LocationFormatter/CoordinateFormat/decimalDegrees``-->
<!--- ``LocationFormatter/CoordinateFormat/degreesMinutesSeconds``-->
<!--- ``LocationFormatter/CoordinateFormat/utm``-->
<!--- ``LocationFormatter/DisplayOptions``-->
<!--- ``LocationFormatter/SymbolStyle``-->
