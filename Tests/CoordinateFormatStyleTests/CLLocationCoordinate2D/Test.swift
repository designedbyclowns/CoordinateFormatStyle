import CoreLocation
import Testing
@testable import CoordinateFormatStyle

struct Test {

    @Test func examples() throws {
        let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)
        
//        let x = coordinate.formatted(.decimalDegrees.ordinalStyle(.signed))
//        #expect(x == "48.87667° S, 123.39333° W")
        
//        let foo = Date.ISO8601FormatStyle()
        
//        let xxx = Decimal.FormatStyle.Percent
//        let parsed = try CLLocationCoordinate2D.ParseStrategy.DecimalDegrees().parse("48.87667° S, 123.39333° W")
//        
//        #expect(parsed.isApproximatelyEqual(to: coordinate, absoluteTolerance: 0.001))
        

        let parsed = try CLLocationCoordinate2D("48.87667° S, 123.39333° W", parseStrategy: .decimalDegrees)
        
        #expect(parsed.isApproximatelyEqual(to: coordinate, absoluteTolerance: 0.001))
        
        //        coordinate.formatted(.decimalDegrees)
//        let formatStyle = CLLocationCoordinate2D.FormatStyle.DecimalDegrees()
//        
//        let s = coordinate.formatted(formatStyle)
//        
//        #expect(s == "foo")
        
        let formatted = coordinate.formatted(.degreesMinutesSeconds.ordinalStyle(.signed))
        #expect(formatted == "-48° 52′ 36″, -123° 23′ 36″")
        
        let style = CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds()
        let xyz = style.format(coordinate)
        #expect(xyz == "48° 52′ 36″ S, 123° 23′ 36″ W")
        
        #expect(coordinate.formatted(style) == "48° 52′ 36″ S, 123° 23′ 36″ W")
        
//        let coord = CLLocationCoordinate2D.pointNemo
        
        let coord = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)
        print(coord.formatted(.degreesMinutesSeconds
            .symbolStyle(.simple)
            .ordinalStyle(.signed)
            .compact(true)
        )
              )
        print("^^^")
        // -48°52'36", -123°23'36"
        
        print(coord.formatted(.decimalDegrees))
        // 48.87667° S, 123.39333° W
        print(coord.formatted(.decimalDegrees.ordinalStyle(.signed)))
        // -48.87667°, -123.39333°
        
        print(coord.formatted(.decimalDegrees.symbolStyle(.canonical)))
        print(coord.formatted(.decimalDegrees.symbolStyle(.simple)))
        print(coord.formatted(.decimalDegrees.symbolStyle(.none)))

        
        print(coord.formatted(.degreesDecimalMinutes))
        // 48° 52.600′ S, 123° 23.600′ W
        print(coord.formatted(.degreesDecimalMinutes.ordinalStyle(.signed)))
        // 48° 52.600′ S, 123° 23.600′ W
        print(coord.formatted(.degreesDecimalMinutes.ordinalStyle(.signed).symbolStyle(.canonical)))
        // 48° 52.600′ S, 123° 23.600′ W
        print(coord.formatted(.degreesDecimalMinutes.ordinalStyle(.signed).symbolStyle(.simple)))
        // -48° 52.600', -123° 23.600'
        print(coord.formatted(.degreesDecimalMinutes.ordinalStyle(.signed).symbolStyle(.none)))
        // -48 52.600, -123 23.600
        print(coord.formatted(.degreesDecimalMinutes.ordinalStyle(.signed).symbolStyle(.canonical).compact(true)))
        // -48°52.600′, -123°23.600′
        print(coord.formatted(.degreesDecimalMinutes.ordinalStyle(.suffix).symbolStyle(.canonical).compact(true)))
        // -48°52.600′S, 123°23.600′W

        print(coord.formatted(.degreesMinutesSeconds))
        // 48° 52′ 36″ S, 123° 23′ 36″ W
        print(coord.formatted(.degreesMinutesSeconds.symbolStyle(.canonical)))
        // 48° 52′ 36″ S, 123° 23′ 36″ W
        print(coord.formatted(.degreesMinutesSeconds.symbolStyle(.simple)))
        // 48° 52' 36" S, 123° 23' 36" W
        print(coord.formatted(.degreesMinutesSeconds.symbolStyle(.none)))
        // 48 52 36 S, 123 23 36 W
        print(coord.formatted(.degreesMinutesSeconds.ordinalStyle(.suffix)))
        // 48° 52′ 36″ S, 123° 23′ 36″ W
        print(coord.formatted(.degreesMinutesSeconds.ordinalStyle(.signed)))
        // -48° 52′ 36″, -123° 23′ 36″
        print(coord.formatted(.degreesMinutesSeconds.compact(true)))
        // 48°52′36″S, 123°23′36″W
        
        
        
        
        
        
//        print(coord.formatted(.utm))
        // 10F 471160mE 4586180mN
//        print(coord.formatted(.geoURI))
        // geo:-48.876667,-123.393333;crs=wgs84
    }

}
