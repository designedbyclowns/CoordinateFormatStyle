import CoreLocation
import Foundation

extension String {
    /*
    /// Parses a coordinate value from a string.
    ///
    /// Attempts to recognize a valid coordinate in Decimal Degrees, Degrees Decimal Minutes,
    /// Degrees Minutes Seconds, UTM or GeoURI formats.
    ///
    /// - Returns: the recognized coordinate value.
    func coordinate() -> CLLocationCoordinate2D?  {
        var coordinate: CLLocationCoordinate2D?

        let strategies: [any CLLocationCoordinate2DParseStrategy] = [
            CLLocationCoordinate2D.FormatStyle.DecimalDegrees().parseStrategy,
            CLLocationCoordinate2D.FormatStyle.DegreesDecimalMinutes().parseStrategy,
            CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds().parseStrategy,
            CLLocationCoordinate2D.FormatStyle.UTM().parseStrategy,
            CLLocationCoordinate2D.FormatStyle.GeoUri().parseStrategy,
        ]

        for strategy in strategies {
            if let coord = try? strategy.parse(self) {
                coordinate = coord
                break
            }
        }

        return coordinate
    }
    */
    
    public func coordinate<F: Foundation.ParseStrategy>(_ style: F) throws -> F.ParseOutput where F.ParseInput == String, F.ParseOutput == CLLocationCoordinate2D {
        try style.parse(self)
    }
    
    public func degrees<F: Foundation.ParseStrategy>(_ style: F) throws -> F.ParseOutput where F.ParseInput == String, F.ParseOutput == CLLocationDegrees {
        try style.parse(self)
    }
}

