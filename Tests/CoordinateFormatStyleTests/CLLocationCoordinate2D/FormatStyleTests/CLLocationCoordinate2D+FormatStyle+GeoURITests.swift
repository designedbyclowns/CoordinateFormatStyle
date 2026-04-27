import CoreLocation
import Testing
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_FormatStyle_GeoUri_Tests {
    
    @Test(arguments: [
        (CLLocationCoordinate2D.portTownsend, "geo:48.11638,-122.77527;crs=wgs84"),
        (CLLocationCoordinate2D.capeHorn, "geo:-55.97917,-67.275;crs=wgs84"),
        (CLLocationCoordinate2D.seychelles, "geo:-4.67785,55.46718;crs=wgs84"),
        (CLLocationCoordinate2D.faroeIslands, "geo:62.06323,-6.87355;crs=wgs84"),
        (CLLocationCoordinate2D.amchitkaIsland, "geo:51.37363,179.41535;crs=wgs84"),
        (CLLocationCoordinate2D.nullIsland, "geo:0,0;crs=wgs84")
    ]) func defaultArguments(arg: (CLLocationCoordinate2D, String)) {
        #expect(arg.0.formatted(.geoURI) == arg.1)
    }
}
