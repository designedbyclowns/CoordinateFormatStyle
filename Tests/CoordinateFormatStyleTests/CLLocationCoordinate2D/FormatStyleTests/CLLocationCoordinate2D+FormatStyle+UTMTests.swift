import CoreLocation
import Testing
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_FormatStyle_UTM_Tests {
    let formatStyle = CLLocationCoordinate2D.FormatStyle.UTM()
    
    @Test(arguments: [
        (CLLocationCoordinate2D.portTownsend, "10U 516726mE 5329260mN"),
        (CLLocationCoordinate2D.capeHorn, "19F 607636mE 3794896mN"),
        (CLLocationCoordinate2D.seychelles, "40M 329980mE 9482760mN"),
        (CLLocationCoordinate2D.faroeIslands, "29V 611132mE 6883046mN"),
        (CLLocationCoordinate2D.amchitkaIsland, "60U 668108mE 5694144mN"),
        (CLLocationCoordinate2D.nullIsland, "31N 166021mE 0000000mN")
    ]) func defaultArguments(arg: (CLLocationCoordinate2D, String)) {
        #expect(arg.0.formatted(formatStyle) == arg.1)
    }
}
