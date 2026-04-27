import Foundation
import CoreLocation

extension CLLocationCoordinate2D.ParseStrategy {
    
    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from Degrees, Minutes, Seconds (DMS) formatted strings.
    public struct DegreesMinutesSeconds: Foundation.ParseStrategy, Sendable {
        
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
            
            let latitude = try CLLocationDegrees.ParseStrategy.DegreesMinutesSeconds(
                orientation: .latitude,
                options: options
            ).parse(components[0])
            
            let longitude = try CLLocationDegrees.ParseStrategy.DegreesMinutesSeconds(
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



extension CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds: ParseableFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.ParseStrategy.DegreesMinutesSeconds {
        .init()
    }
}

extension Foundation.ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.DegreesMinutesSeconds {
    public static var degreesMinutesSeconds: Self {
        .init()
    }
}
