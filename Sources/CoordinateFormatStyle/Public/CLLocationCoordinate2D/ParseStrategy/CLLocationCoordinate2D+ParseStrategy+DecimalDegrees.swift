public import Foundation
public import CoreLocation

extension CLLocationCoordinate2D.ParseStrategy {

    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from Decimal Degrees (DD) formatted strings.
    public struct DecimalDegrees: Foundation.ParseStrategy, Sendable {

        /// Creates a Decimal Degrees parse strategy.
        /// - Parameter options: Parsing options. Defaults to ``ParsingOptions/caseInsensitive``.
        public init(
            options: ParsingOptions = [.caseInsensitive]
        ) {
            self.options = options
        }

        // MARK: - ParseStrategy

        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D

        /// Parses a Decimal Degrees string into a coordinate.
        /// - Parameter value: A string such as `"48.11638° N, 122.77527° W"`.
        /// - Returns: The parsed coordinate.
        /// - Throws: A ``ParsingError`` describing why parsing failed.
        public func parse(_ value: String) throws -> CLLocationCoordinate2D {
            let components = try CoordinateFormatStyle.components(from: value)

            let latitude = try CLLocationDegrees.ParseStrategy.DecimalDegrees(
                orientation: .latitude,
                options: options
            ).parse(components[0])

            let longitude = try CLLocationDegrees.ParseStrategy.DecimalDegrees(
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
