# <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/FormatStyle/DecimalDegrees``

## Overview

The `DecimalDegrees` format style generates and parses string representations of coordinates using the Decimal Degrees format, also known as DD notation. Use this type to create DD representations of coordinates and create coordinates from text strings in DD format.

The DD format expresses latitude and longitude geographic coordinates as decimal fractions of a degree. It is commonly used on the world wide web and computer systems.

## Formatting coordinate values

Use the formatted() method to create a string representation of a `CLLocationCoordinate2D` value using the default `CLLocationCoordinate2D.FormatStyle.DecimalDegrees` configuration:

```swift
let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)
print(coordinate.formatted(.decimalDegrees))
// "48° 52′ 36″ S, 123° 23′ 36″ W"
"
```

## Creating a Degrees Minutes Seconds format style instance

```swift
let formatStyle = CLLocationCoordinate2D.FormatStyle.DecimalDegrees()
```

## Available Properties

Property       | Description                          
-------------- | ------------------------------------- 
`symbolStyle`  | Defines the characters used to annotate coordinate components.  
`ordinalStyle` | Specifies how to indicate the ordinal direction of the latitude and longitude.         
`compact`      | Remove spaces.          

## Examples

Instance modifier methods applied to an DNS format style customize the formatted output, as the following example illustrates.

```swift
let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)
print(coordinate.formatted(.decimalDegrees))
// "48° 52′ 36″ S, 123° 23′ 36″ W"
```

```swift
let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)
print(coordinate.formatted(.decimalDegrees.options([])))
// "-48° 52



// Decimal Degrees (DD).
///
/// A notation for expressing latitude and longitude geographic coordinates as
/// decimal fractions of a degree.
///
/// Commonly used on the web and computer systems.
///
///Examples:
/// ```
/// 48.87667° S, 123.39333° W
/// -48.87667°, 123.39333°
/// ```

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

### Creating a Decimal Degrees (DD) Format Style

- ``init(symbolStyle:ordinalStyle:compact:)``

### Modifying a Decimal Degrees (DD) Format Style

- ``symbolStyle``
- ``ordinalStyle``
- ``symbolStyle(_:)``
- ``ordinalStyle(_:)``

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
