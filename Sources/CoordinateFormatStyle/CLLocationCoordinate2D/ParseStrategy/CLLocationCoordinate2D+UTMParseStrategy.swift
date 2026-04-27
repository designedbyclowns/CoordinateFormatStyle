import Foundation
import CoreLocation
import UTMConversion

extension CLLocationCoordinate2D {
    
    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from strings formatted using the [Universal Transverse Mercator (UTM)](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) coordinate system.
    ///
    /// - ``CoordinateFormat/utm``
    public struct UTMParseStrategy: Foundation.ParseStrategy, Sendable {
        
        public init(options: ParsingOptions = [.caseInsensitive]) {
            self.options = options
        }
        
        public var options: ParsingOptions
        
        // MARK: - ParseStrategy
        
        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D
        
        public func parse(_ value: String) throws -> CLLocationCoordinate2D {
            let utm = try UTMCoordinate.ParseStrategy().parse(value)
            return utm.coordinate()
        }
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.UTMParseStrategy {
    public static var utm:  CLLocationCoordinate2D.UTMParseStrategy { .init() }
}

extension CLLocationCoordinate2D.UTMFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.UTMParseStrategy {
        .init()
    }
}
