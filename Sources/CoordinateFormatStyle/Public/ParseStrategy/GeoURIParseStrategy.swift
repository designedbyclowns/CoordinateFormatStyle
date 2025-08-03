import Foundation
import CoreLocation
import GeoURI

/// A `ParseStrategy` that parses a `GeoURI` string into a `CLLocationCoordinate2D`.
public typealias GeoURIParseStrategy = CLLocationCoordinate2D.GeoURIParseStrategy

extension CLLocationCoordinate2D {
    /// A `ParseStrategy` that parses a `GeoURI` string into a `CLLocationCoordinate2D`.
    ///
    /// - ``CoordinateFormat/geoURI``
    public struct GeoURIParseStrategy: Foundation.ParseStrategy {
        
        public init(precision: CLLocationDegrees.Precision? = .decimalPlaces6) {
            self.precision = precision
        }
        
        public func precision(_ precision: CLLocationDegrees.Precision?) -> Self {
            .init(precision: precision)
        }
        
        // MARK: - ParseStrategy
        
        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D
        
        public func parse(_ value: String) throws(GeoURIError) -> CLLocationCoordinate2D {
            let coordinate = try GeoURI(string: value).coordinate
            
            if let precision  {
                return coordinate.rounded(to: precision)
            } else {
                return coordinate
            }
        }
        
        // MARK: - Private
        
        private let precision: CLLocationDegrees.Precision?
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.GeoURIParseStrategy {
    /// A `ParseStrategy` that parses a `GeoURI` string into a `CLLocationCoordinate2D`.
    public static var geoURI:  CLLocationCoordinate2D.GeoURIParseStrategy { .init() }
}

extension CLLocationCoordinate2D.GeoURIFormatStyle: ParseableFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.GeoURIParseStrategy {
        .init()
    }
}
