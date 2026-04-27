public import Foundation
public import CoreLocation

extension CLLocationCoordinate2D.ParseStrategy {
    
    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from Degrees and Decimal Minutes (DDM) formatted strings.
    public struct DegreesDecimalMinutes: Foundation.ParseStrategy, Sendable {
        
        public init(
            options: ParsingOptions = [.caseInsensitive]
        ) {
            self.options = options
        }
        
        // MARK: - ParseStrategy
        
        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D
        
        public func parse(_ value: String) throws -> CLLocationCoordinate2D {
            let components = try CoordinateFormatStyle.components(from: value)
            
            let latitude = try CLLocationDegrees.ParseStrategy.DegreesDecimalMinutes(
                orientation: .latitude,
                options: options
            ).parse(components[0])
            
            let longitude = try CLLocationDegrees.ParseStrategy.DegreesDecimalMinutes(
                orientation: .longitude,
                options: options
            ).parse(components[1])
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            guard CLLocationCoordinate2DIsValid(coordinate) else {
                throw ParsingError.invalidCoordinate
            }
            
            return coordinate
        }
        
        // MARK: - Private
        
        let options: ParsingOptions
    }
}
