import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    /// Initialize `CLLocationCoordinate2D` with a formatted string.
    public init<P: Foundation.ParseStrategy>(
        _ value: String,
        parseStrategy: P
    ) throws where P.ParseInput == String, P.ParseOutput == CLLocationCoordinate2D {
        self = try parseStrategy.parse(value)
    }
    
    /// Produces a formatted string representation of a `CLLocationCoordinate2D`.
    public func formatted<F: Foundation.FormatStyle>(_ style: F) -> F.FormatOutput where F.FormatInput == Self {
        style.format(self)
    }
    
    /// Test if self and other are approximately equal with specified precision.
    /// - Parameters:
    ///   - other: The value to which self is compared.
    ///   - precision: The ``CLLocationCoordinate2D/Precision`` to use in the comparison.
    /// - Returns: true if self and other are equal.
    public func isApproximatelyEqual(to other: CLLocationCoordinate2D, precision: CLLocationDegrees.Precision) -> Bool {
        self.latitude.isApproximatelyEqual(to: other.latitude, precision: precision) &&
        self.longitude.isApproximatelyEqual(to: other.longitude, precision: precision)
    }
}


extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
