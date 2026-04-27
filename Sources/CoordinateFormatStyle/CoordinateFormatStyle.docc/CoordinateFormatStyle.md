# ``CoordinateFormatStyle``

Coordinate formatting and parsing helpers for CLLocationCoordinate2D.

## Overview

This package provides format styles and parse strategies to convert `CLLocationCoordinate2D` values to and from textual representations.

### Formatting Coordinates

A coordinate can be formatted using a variety of ``CoordinateFormat`` types.

```swift
let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)

coordinate.formatted(.decimalDegrees)
// 48.87667° S, 123.39333° W

coordinate.formatted(.degreesDecimalMinutes)
// 48° 52.600′ S, 123° 23.600′ W

coordinate.formatted(.degreesMinutesSeconds)
// 48° 52′ 36″ S, 123° 23′ 36″ W

coordinate.formatted(.utm)
// 10F 471160mE 4586180mN

coordinate.formatted(.geoURI)
// geo:-48.876667,-123.393333;crs=wgs84
```

## Topics

### Format Styles

- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/FormatStyle/DecimalDegrees``
- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/FormatStyle/DegreesDecimalMinutes``
- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/FormatStyle/DegreesMinutesSeconds``
- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/FormatStyle/GeoUri``
- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/FormatStyle/UTM``

### Parse Strategies

- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/ParseStrategy/DecimalDegrees``
- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/ParseStrategy/DegreesDecimalMinutes``
- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/ParseStrategy/DegreesMinutesSeconds``
- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/ParseStrategy/GeoUri``
- ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/ParseStrategy/UTM``

### Coordinate Format

- ``CoordinateFormat``

- ``CoordinateFormat/decimalDegrees``
- ``CoordinateFormat/degreesDecimalMinutes``
- ``CoordinateFormat/degreesMinutesSeconds``
- ``CoordinateFormat/geoURI``
- ``CoordinateFormat/utm``
