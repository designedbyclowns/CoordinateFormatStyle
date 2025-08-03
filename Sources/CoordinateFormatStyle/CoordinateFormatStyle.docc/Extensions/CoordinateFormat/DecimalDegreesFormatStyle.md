# ``DecimalDegreesFormatStyle``

@Metadata {
    @DocumentationExtension(mergeBehavior: append)
}


## Formatting

Generate a string representation of a coordinate in the Decimal Degrees coordinate format.

```swift
let coordinate = CLLocationCoordinate2D(latitude: 48.11638, longitude: -122.77527)

coordinate.formatted(.decimalDegrees) 
// 48.11638°, -122.77527°

coordinate.formatted(.decimalDegrees.symbolStyle(.none)) 
// 48.11638, -122.77527

coordinate.formatted(.decimalDegrees.symbolStyle(.simple)) 
// 48.11638°, -122.77527°

coordinate.formatted(.decimalDegrees.options(.suffix)) 
// 48.11638° N, 122.77527° W

coordinate.formatted(.decimalDegrees.options(.compact)) 
// 48.11638°N, 122.77527°W

```

## Parsing

Initialize a coordinate by parsing a string using the Decimal Degrees coordinate format style.

```swift
let style = DecimalDegreesFormatStyle()

do {
    let coordinate = try CLLocationCoordinate2D("48.11638° N, 122.77527° W", parseStrategy: style.parseStrategy)
    print(coordinate) 
    // CLLocationCoordinate2D(latitude: 48.11638, longitude: -122.77527)
} catch {
    print(error.localizedDescription)
}

```



## See Also

- ``CoordinateFormat/decimalDegrees``
- ``SymbolStyle``
- ``DisplayOptions``

<!--- ``LocationFormatter/CoordinateFormat/degreesDecimalMinutes``-->
<!--- ``LocationFormatter/CoordinateFormat/degreesMinutesSeconds``-->
<!--- ``LocationFormatter/CoordinateFormat/utm``-->
<!--- ``LocationFormatter/DisplayOptions``-->
<!--- ``LocationFormatter/SymbolStyle``-->
