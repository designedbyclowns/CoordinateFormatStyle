import Foundation
import CoreLocation
import UTMConversion

extension CLLocationCoordinate2D {
    
    /// A `ParseStrategy` that parses a string in Universal Transverse Mercator (UTM) format into a CLLocationCoordinate2D..
    ///
    /// - ``CoordinateFormat/utm``
    public struct UTMParseStrategy: Foundation.ParseStrategy {
        
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
