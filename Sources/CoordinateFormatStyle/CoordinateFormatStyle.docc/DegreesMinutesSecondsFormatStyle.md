# ``CoordinateFormatStyle/_LocationEssentials/CLLocationCoordinate2D/FormatStyle/DegreesMinutesSeconds``

## Overview

The `DegreesMinutesSeconds` style generates and parses string representations of coordinates using the Degrees Minutes Seconds format, also known as DMS notation. Use this type to create DMS representations of coordinates and create coordinates from text strings in DMS format. 

The DMS format uses uses traditional [sexagesimal](https://en.wikipedia.org/wiki/Sexagesimal) unit subdivisions: one degree is divided into 60 minutes (of arc), and one minute into 60 seconds (of arc). These subdivisions, also called the _arc minute_ and _arc second_, are represented by a single prime (′) and double prime (″) respectively. For example, 40.1875° = 40° 11′ 15″. Additional precision can be provided using decimal fractions of an arc second.

## Formatting coordinate values

Use the formatted() method to create a string representation of a `CLLocationCoordinate2D` value using the default `CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds` configuration:

```swift
let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)
print(coordinate.formatted(.degreesMinutesSeconds))
// "48° 52′ 36″ S, 123° 23′ 36″ W"
"
```

## Creating a Degrees Minutes Seconds format style instance

```swift
let formatStyle = CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds()
```

## Available Properties

Property       | Description                          
-------------- | ------------------------------------- 
`symbolStyle`  | Defines the characters used to annotate coordinate components.  
`ordinalStyle` | Specifies how to indicate the ordinal direction of the latitude and longitude.         
`compact`      | Remove spaces.           


## Examples

Instance modifier methods applied to an DMS format style customize the formatted output, as the following example illustrates.


```swift
let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)

coordinate.formatted(.degreesMinutesSeconds)
// 48° 52′ 36″ S, 123° 23′ 36″ W
coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.canonical))
// 48° 52′ 36″ S, 123° 23′ 36″ W
coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.simple))
// 48° 52' 36" S, 123° 23' 36" W
coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.none))
// 48 52 36 S, 123 23 36 W
coordinate.formatted(.degreesMinutesSeconds.ordinalStyle(.suffix))
// 48° 52′ 36″ S, 123° 23′ 36″ W
coordinate.formatted(.degreesMinutesSeconds.ordinalStyle(.signed))
// -48° 52′ 36″, -123° 23′ 36″
coordinate.formatted(.degreesMinutesSeconds.compact(true))
// 48°52′36″S, 123°23′36″W
```

Use the static factory property `FormatStyle/degreesMinutesSeconds` to create an instance of `CLLocationCoordinate2D/FormatStyle/DegreesMinutesSeconds`. Then apply instance modifier methods to customize the format, as in the example below.

```swift
let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)
let formatted = coordinate.formatted(.degreesMinutesSeconds
    .symbolStyle(.simple)
    .ordinalStyle(.signed)
    .compact(true)
) // -48°52'36", -123°23'36"
```

## Topics

### Creating a Degrees Minutes Seconds (DMS) Format Style

- ``init(symbolStyle:ordinalStyle:compact:)``

### Modifying a Degrees Minutes Seconds (DMS) Format Style

- ``symbolStyle``
- ``ordinalStyle``
- ``symbolStyle(_:)``
- ``ordinalStyle(_:)``

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
