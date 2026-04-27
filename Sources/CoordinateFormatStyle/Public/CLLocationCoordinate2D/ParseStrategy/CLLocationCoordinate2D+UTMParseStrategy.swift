public import Foundation
public import CoreLocation
import UTMConversion

extension CLLocationCoordinate2D.ParseStrategy {
    
    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from strings formatted using the [Universal Transverse Mercator (UTM)](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) coordinate system.
    public struct UTM: Foundation.ParseStrategy, Sendable {
        
        public init(options: ParsingOptions = [.caseInsensitive]) {
            self.options = options
        }
        
        public var options: ParsingOptions
        
        // MARK: - ParseStrategy
        
        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D
        
        public func parse(_ value: String) throws -> CLLocationCoordinate2D {
            let utm = try UTMCoordinate.ParseStrategy().parse(value)
            let coordinate = utm.coordinate()

            guard CLLocationCoordinate2DIsValid(coordinate) else {
                throw ParsingError.invalidCoordinate
            }

            return coordinate
        }
    }
}
