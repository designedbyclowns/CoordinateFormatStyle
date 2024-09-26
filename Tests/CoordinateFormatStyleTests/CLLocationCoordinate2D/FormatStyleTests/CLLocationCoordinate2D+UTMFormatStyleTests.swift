import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_UTMFormatStyleTests {
    let formatStyle = CLLocationCoordinate2D.UTMFormatStyle()
    
    @Test(arguments: [
        (CLLocationCoordinate2D.portTownsend, "10U 516726m E 5329260m N"),
        (CLLocationCoordinate2D.capeHorn, "19F 607636m E 3794896m N"),
        (CLLocationCoordinate2D.seychelles, "40M 329980m E 9482760m N"),
        (CLLocationCoordinate2D.faroeIslands, "29V 611132m E 6883046m N"),
        (CLLocationCoordinate2D.amchitkaIsland, "60U 668108m E 5694144m N"),
        (CLLocationCoordinate2D.nullIsland, "31N 166021m E 0000000m N")
    ]) func defaultArguments(arg: (CLLocationCoordinate2D, String)) {
        #expect(arg.0.formatted(formatStyle) == arg.1)
    }
}
