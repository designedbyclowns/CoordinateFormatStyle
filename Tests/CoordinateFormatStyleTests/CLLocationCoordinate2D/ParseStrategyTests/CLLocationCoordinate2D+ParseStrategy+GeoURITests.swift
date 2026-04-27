import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_ParseStrategy_GeoUri_Tests {

    let parseStrategy = CLLocationCoordinate2D.ParseStrategy.GeoUri()

    @Test(arguments: [
        ("geo:48.11638,-122.77527;crs=wgs84", CLLocationCoordinate2D.portTownsend),
        ("geo:-55.97917,-67.275;crs=wgs84", CLLocationCoordinate2D.capeHorn),
        ("geo:-4.67785,55.46718;crs=wgs84", CLLocationCoordinate2D.seychelles),
        ("geo:62.06323,-6.87355;crs=wgs84", CLLocationCoordinate2D.faroeIslands),
        ("geo:51.37363,179.41535;crs=wgs84", CLLocationCoordinate2D.amchitkaIsland),
        ("geo:0.0,0.0;crs=wgs84", CLLocationCoordinate2D.nullIsland)
    ]) func parse(arg: (String, CLLocationCoordinate2D)) throws {
        let match = try parseStrategy.parse(arg.0)
        #expect(match.isApproximatelyEqual(to: arg.1, absoluteTolerance: 0.00001))
    }
}
