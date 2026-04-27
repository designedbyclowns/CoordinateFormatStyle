import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from Degrees and Decimal Minutes (DDM) formatted strings.
    ///
    /// - ``CoordinateFormat/degreesDecimalMinutes``
    public struct DegreesDecimalMinutesParseStrategy: Foundation.ParseStrategy, Sendable {
        
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
            
            let latitude = try CLLocationDegrees.DegreesDecimalMinutesParseStrategy(
                orientation: .latitude,
                options: options
            ).parse(components[0])
            
            let longitude = try CLLocationDegrees.DegreesDecimalMinutesParseStrategy(
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

extension ParseStrategy where Self == CLLocationCoordinate2D.DegreesDecimalMinutesParseStrategy {
    public static var degreesDecimalMinutes:  CLLocationCoordinate2D.DegreesDecimalMinutesParseStrategy { .init() }
}

extension CLLocationCoordinate2D.DegreesDecimalMinutesFormatStyle: ParseableFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.DegreesDecimalMinutesParseStrategy {
        .init()
    }
}
