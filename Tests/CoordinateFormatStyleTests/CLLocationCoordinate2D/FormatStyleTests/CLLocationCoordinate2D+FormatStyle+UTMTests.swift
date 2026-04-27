import CoreLocation
import Testing
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_FormatStyle_UTM_Tests {
    
    @Test(arguments: [
        (CLLocationCoordinate2D.portTownsend, "10U 516726m E 5329260m N"),
        (CLLocationCoordinate2D.capeHorn, "19F 607636m E 3794896m N"),
        (CLLocationCoordinate2D.seychelles, "40M 329980m E 9482760m N"),
        (CLLocationCoordinate2D.faroeIslands, "29V 611132m E 6883046m N"),
        (CLLocationCoordinate2D.amchitkaIsland, "60U 668108m E 5694144m N"),
        (CLLocationCoordinate2D.nullIsland, "31N 166021m E 0000000m N")
    ]) func defaultArguments(arg: (CLLocationCoordinate2D, String)) {
        #expect(arg.0.formatted(.utm) == arg.1)
    }
    
    @Test(arguments: [
        (CLLocationCoordinate2D.portTownsend, "10U 516726mE 5329260mN"),
        (CLLocationCoordinate2D.capeHorn, "19F 607636mE 3794896mN"),
        (CLLocationCoordinate2D.seychelles, "40M 329980mE 9482760mN"),
        (CLLocationCoordinate2D.faroeIslands, "29V 611132mE 6883046mN"),
        (CLLocationCoordinate2D.amchitkaIsland, "60U 668108mE 5694144mN"),
        (CLLocationCoordinate2D.nullIsland, "31N 166021mE 0000000mN")
    ]) func compact(arg: (CLLocationCoordinate2D, String)) {
        let style = CLLocationCoordinate2D.FormatStyle.UTM().compact(true)
        #expect(style.format(arg.0) == arg.1)
    }
}
