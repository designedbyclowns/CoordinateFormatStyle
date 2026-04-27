import Foundation
import CoreLocation
import GeoURI

extension CLLocationCoordinate2D.ParseStrategy {
    
    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from ['geo' URI](https://geouri.org) formatted strings.
    public struct GeoUri: Foundation.ParseStrategy, Sendable {
        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D
        
        public func parse(_ value: String) throws -> CLLocationCoordinate2D {
            return try GeoURI(string: value).coordinate
        }
    }
}



extension CLLocationCoordinate2D.FormatStyle.GeoUri: ParseableFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.ParseStrategy.GeoUri {
        .init()
    }
}

extension Foundation.ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.GeoUri {
    public static var geoURI: Self {
        .init()
    }
}
