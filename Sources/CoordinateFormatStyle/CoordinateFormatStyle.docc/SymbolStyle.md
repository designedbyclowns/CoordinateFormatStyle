# SymbolStyle

Defines the characters used to annotate coordinate components.

## Overview

Text

## Examples

```swift
let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)

coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.canonical))
// 48° 52′ 36″ S, 123° 23′ 36″ W
coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.simple))
// 48° 52' 36" S, 123° 23' 36" W
coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.none))
// 48 52 36 S, 123 23 36 W

coordinate.formatted(.degreesDecimalMinutes.symbolStyle(.canonical))
// 48° 52.600′ S, 123° 23.600′ W
coordinate.formatted(.degreesDecimalMinutes.symbolStyle(.simple))
// 48° 52.600' S, 123° 23.600' W
coordinate.formatted(.degreesDecimalMinutes.symbolStyle(.none))
// 48 52.600 S, 123 23.600 W

coordinate.formatted(.decimalDegrees.symbolStyle(.canonical))
// 48.87667° S, 123.39333° W
coordinate.formatted(.decimalDegrees.symbolStyle(.simple))
// 48.87667° S, 123.39333° W
coordinate.formatted(.decimalDegrees.symbolStyle(.none))
// 48.87667 S, 123.39333 W
```

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
