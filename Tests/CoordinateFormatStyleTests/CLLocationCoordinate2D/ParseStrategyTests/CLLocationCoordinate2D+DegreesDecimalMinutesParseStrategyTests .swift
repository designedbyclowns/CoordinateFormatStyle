import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_DegreesDecimalMinutesParseStrategyTests {
    
    let formatStyle = CLLocationCoordinate2D.DegreesDecimalMinutesFormatStyle()
    
    @Test(arguments: [
        ("48° 06.983′ N, 122° 46.516′ W", CLLocationCoordinate2D.portTownsend),
        ("4° 40.671′ S, 55° 28.031′ E", CLLocationCoordinate2D.seychelles),
        ("62° 03.794′ N, 6° 52.413′ W", CLLocationCoordinate2D.faroeIslands),
        ("51° 22.418′ N, 179° 24.921′ E", CLLocationCoordinate2D.amchitkaIsland),
        ("0° 00.000′ N, 0° 00.000′ E", CLLocationCoordinate2D.nullIsland)
        
    ]) func decimalDegrees(arg: (String, CLLocationCoordinate2D)) {
        #expect(throws: Never.self) {
            let parsed = try CLLocationCoordinate2D(arg.0, parseStrategy: formatStyle.parseStrategy)
            #expect(parsed.isApproximatelyEqual(
                to: arg.1,
                precision: .decimalPlaces4
            ))
        }
    }
    
    @Test(arguments: [
        "55° 58.750′ S, 67° 16.500′ W",
        "-55° 58.750′, -67° 16.500′",
        "55°58.750′S,67°16.500′W",
        "55° 58.750' S, 67° 16.500' W",
        "S 55° 58.750′ S, W 67° 16.500′"
    ]) func patternMatching(text: String) {
        #expect(throws: Never.self) {
            let parsed = try CLLocationCoordinate2D(text, parseStrategy: formatStyle.parseStrategy)
            #expect(parsed.isApproximatelyEqual(
                to: CLLocationCoordinate2D.capeHorn,
                precision: .decimalPlaces4
            ))
        }
    }
    
    // Google uses a space instead of a comma as its delimiter for whatever reason
    @Test(arguments: [
        "55°58.750′S 67°16.500′W",
        "-55°58.750′ -67°16.500′",
        "55°58.750'S 67°16.500'W",
        "S55°58.750′S W67°16.500′"
    ]) func googleFormat(text: String) {
        #expect(throws: Never.self) {
            let parsed = try CLLocationCoordinate2D(text, parseStrategy: formatStyle.parseStrategy)
            #expect(parsed.isApproximatelyEqual(
                to: CLLocationCoordinate2D.capeHorn,
                precision: .decimalPlaces4
            ))
        }
    }
    
    @Test func precision() {
        let style = CLLocationCoordinate2D.DegreesDecimalMinutesFormatStyle()
        
        #expect(throws: Never.self) {
            let parsed = try CLLocationCoordinate2D("-55° 58.750′, -67° 16.500′",
                                                    parseStrategy: style.parseStrategy.precision(.decimalPlaces3))
            
            #expect(parsed.isApproximatelyEqual(to: .capeHorn, precision: .decimalPlaces1) == true)
            #expect(parsed.isApproximatelyEqual(to: .capeHorn, precision: .decimalPlaces2) == true)
            #expect(parsed.isApproximatelyEqual(to: .capeHorn, precision: .decimalPlaces3) == true)
            #expect(parsed.isApproximatelyEqual(to: .capeHorn, precision: .decimalPlaces4) == false)
        }
        
        #expect(throws: Never.self) {
            let parsed = try CLLocationCoordinate2D("-55° 58.750′, -67° 16.500′",
                                                    parseStrategy: style.parseStrategy.precision(.decimalPlaces2))
   
            #expect(parsed.isApproximatelyEqual(to: .capeHorn, precision: .decimalPlaces1) == true)
            #expect(parsed.isApproximatelyEqual(to: .capeHorn, precision: .decimalPlaces2) == true)
            #expect(parsed.isApproximatelyEqual(to: .capeHorn, precision: .decimalPlaces3) == false)
            #expect(parsed.isApproximatelyEqual(to: .capeHorn, precision: .decimalPlaces4) == false)
        }
    }
}
