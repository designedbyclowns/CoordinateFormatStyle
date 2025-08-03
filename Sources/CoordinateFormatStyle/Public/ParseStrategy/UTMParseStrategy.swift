import Foundation
import CoreLocation
import UTMConversion

/// A `ParseStrategy` that parses a string in Universal Transverse Mercator (UTM) format into a `CLLocationCoordinate2D`..
public typealias UTMParseStrategy = CLLocationCoordinate2D.UTMParseStrategy

extension CLLocationCoordinate2D {
    
    /// A `ParseStrategy` that parses a string in Universal Transverse Mercator (UTM) format into a `CLLocationCoordinate2D`..
    ///
    /// - ``CoordinateFormat/utm``
    public struct UTMParseStrategy: Foundation.ParseStrategy {
        public init(
            options: ParsingOptions = [.caseInsensitive],
            precision: CLLocationDegrees.Precision? = .decimalPlaces6
        ) {
            self.precision = precision
            self.options = options
        }
        
        public func precision(_ precision: CLLocationDegrees.Precision?) -> Self {
            .init(precision: precision)
        }
        
        public func options(_ options: ParsingOptions) -> Self {
            .init(options: options)
        }
                
        // MARK: - ParseStrategy
        
        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D
        
        public func parse(_ value: String) throws(ParsingError) -> CLLocationCoordinate2D {
            let coordinate = try UTMCoordinate.ParseStrategy()
                .parse(value)
                .coordinate()
            
            if let precision  {
                return coordinate.rounded(to: precision)
            } else {
                return coordinate
            }
        }
        
        // MARK: - Private
        
        private let options: ParsingOptions
        private let precision: CLLocationDegrees.Precision?
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.UTMParseStrategy {
    /// A `ParseStrategy` that parses a string in Universal Transverse Mercator (UTM) format into a `CLLocationCoordinate2D`..
    public static var utm:  CLLocationCoordinate2D.UTMParseStrategy { .init() }
}

extension CLLocationCoordinate2D.UTMFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.UTMParseStrategy {
        .init()
    }
}
