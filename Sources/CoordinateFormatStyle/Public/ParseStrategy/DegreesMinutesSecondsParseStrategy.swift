import Foundation
import CoreLocation

/// A `ParseStrategy` that parses a string formatted as Degrees, Minutes, Seconds (DMS) into a `CLLocationCoordinate2D`.
public typealias DegreesMinutesSecondsParseStrategy = CLLocationCoordinate2D.DegreesMinutesSecondsParseStrategy

extension CLLocationCoordinate2D {
    /// A `ParseStrategy` that parses a string formatted as Degrees, Minutes, Seconds (DMS) into a `CLLocationCoordinate2D`.
    ///
    /// - ``CoordinateFormat/degreesMinutesSeconds``
    public struct DegreesMinutesSecondsParseStrategy: Foundation.ParseStrategy {
        
        public init(
            precision: CLLocationDegrees.Precision? = .decimalPlaces6,
            options: ParsingOptions = [.caseInsensitive]
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
        
        public func parse(_ value: String) throws((ParsingError)) -> CLLocationCoordinate2D {
            let components = try CoordinateFormatStyle.components(from: value)
            
            let latitude = try CLLocationDegrees.DegreesMinutesSecondsParseStrategy(
                orientation: .latitude,
                options: options,
                precision: precision
            ).parse(components[0])
            
            let longitude = try CLLocationDegrees.DegreesMinutesSecondsParseStrategy(
                orientation: .longitude,
                options: options,
                precision: precision
            ).parse(components[1])
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            guard CLLocationCoordinate2DIsValid(coordinate) else {
                throw ParsingError.invalidCoordinate
            }
            
            return coordinate
        }
        
        // MARK: - Private
        
        private let options: ParsingOptions
        private let precision: CLLocationDegrees.Precision?
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.DegreesMinutesSecondsParseStrategy {
    /// A `ParseStrategy` that parses a string formatted as Degrees, Minutes, Seconds (DMS) into a `CLLocationCoordinate2D`.
    public static var degreesMinutesSeconds:  CLLocationCoordinate2D.DegreesMinutesSecondsParseStrategy { .init() }
}

extension CLLocationCoordinate2D.DegreesMinutesSecondsFormatStyle: ParseableFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.DegreesMinutesSecondsParseStrategy {
        .init()
    }
}
