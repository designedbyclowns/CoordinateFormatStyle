[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdesignedbyclowns%2FCoordinateFormatStyle%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/designedbyclowns/CoordinateFormatStyle)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdesignedbyclowns%2FCoordinateFormatStyle%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/designedbyclowns/CoordinateFormatStyle)

# CoordinateFormatStyle

Foundation `FormatStyle` and `ParseStrategy` conformances for `CLLocationCoordinate2D`. Format and parse coordinates as Decimal Degrees (DD), Degrees Decimal Minutes (DDM), Degrees Minutes Seconds (DMS), `geo:` URI, or UTM — using the same `.formatted(...)` API you already use for dates and numbers.

## Requirements

- Swift 6.2
- macOS 13+, iOS 16+, watchOS 9+, tvOS 16+

## Installation

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/designedbyclowns/CoordinateFormatStyle.git", from: "1.0.0"),
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["CoordinateFormatStyle"]
    ),
]
```

Or, in Xcode: **File → Add Package Dependencies…** and enter the repository URL.

## Formatting

```swift
import CoreLocation
import CoordinateFormatStyle

let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)

coordinate.formatted(.decimalDegrees)
// 48.87667° S, 123.39333° W

coordinate.formatted(.degreesDecimalMinutes)
// 48° 52.600′ S, 123° 23.600′ W

coordinate.formatted(.degreesMinutesSeconds)
// 48° 52′ 36″ S, 123° 23′ 36″ W

coordinate.formatted(.utm)
// 10F 471160m E 4586180m N

coordinate.formatted(.geoURI)
// geo:-48.876667,-123.393333;crs=wgs84
```

Calling `formatted()` with no arguments uses Degrees Minutes Seconds with canonical symbols and an N/S/E/W suffix.

### Customizing output

Each format style is configured with chainable modifiers.

```swift
// Signed decimals, no hemisphere letters, canonical typography
coordinate.formatted(
    .decimalDegrees
        .ordinalStyle(.signed)
        .symbolStyle(.canonical)
)
// -48.87667°, -123.39333°

// Compact UTM (no spaces between number and units)
coordinate.formatted(.utm.compact(true))
// 10F 471160mE 4586180mN

// geo: URI without the CRS parameter
coordinate.formatted(.geoURI.includeCRS(false))
// geo:-48.876667,-123.393333
```

Available modifiers:

| Modifier              | Applies to             | Values                                  |
|-----------------------|------------------------|-----------------------------------------|
| `symbolStyle(_:)`     | DD, DDM, DMS           | `.none`, `.simple` (`° ' "`), `.canonical` (`° ′ ″`) |
| `ordinalStyle(_:)`    | DD, DDM, DMS           | `.signed`, `.suffix`                    |
| `compact(_:)`         | DD, DDM, DMS, UTM      | `Bool`                                  |
| `includeCRS(_:)`      | GeoURI                 | `Bool`                                  |

If a coordinate is invalid (`CLLocationCoordinate2DIsValid` returns `false`), formatting returns an empty string.

## Parsing

Every format style has a matching parse strategy. Initialize a coordinate from a string with the standard Foundation API:

```swift
let coordinate = try CLLocationCoordinate2D(
    "48° 52′ 36″ S, 123° 23′ 36″ W",
    parseStrategy: .degreesMinutesSeconds
)
```

The available strategies are `.decimalDegrees`, `.degreesDecimalMinutes`, `.degreesMinutesSeconds`, `.geoURI`, and `.utm`. Parsers accept either a comma- or space-separated latitude/longitude pair, and by default match hemisphere letters case-insensitively.

Parse failures throw a `ParsingError`:

```swift
public enum ParsingError: Error, LocalizedError, Equatable {
    case conflict                                    // prefix and suffix disagree (e.g. "N 48° S")
    case invalidCoordinate                           // CLLocationCoordinate2DIsValid returned false
    case invalidDirection                            // hemisphere letter wrong for this axis
    case invalidRangeDegrees                         // |lat| > 90 or |lon| > 180
    case invalidRangeMinutes
    case invalidRangeSeconds
    case invalidZone                                 // UTM zone out of 1...60
    case invalidLatitudeBand                         // UTM band not in C…X (excluding I, O)
    case noMatch                                     // string did not match the expected format
    case notFound(name: String)
    case unsupportedCoordinateReferenceSystem(crs: String)
}
```

## Supported formats

- **Decimal Degrees (DD)** — `48.87667° S, 123.39333° W`
- **Degrees Decimal Minutes (DDM)** — `48° 52.600′ S, 123° 23.600′ W`
- **Degrees Minutes Seconds (DMS)** — `48° 52′ 36″ S, 123° 23′ 36″ W`
- **[`geo:` URI](https://geouri.org)** — `geo:-48.876667,-123.393333;crs=wgs84`
- **[Universal Transverse Mercator (UTM)](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system)** — `10F 471160m E 4586180m N`

A `CoordinateFormat` enum is also provided for cases where you need to refer to a format by value (e.g. persisting a user's display preference).

## Documentation

The package ships a DocC catalog. Build it with:

```bash
swift package generate-documentation
```

## License

Released into the public domain under [The Unlicense](LICENSE).
