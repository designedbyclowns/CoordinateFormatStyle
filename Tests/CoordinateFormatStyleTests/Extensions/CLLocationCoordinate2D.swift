import CoreLocation
import Numerics

extension CLLocationCoordinate2D {
    /// Test if self and other are approximately equal with specified tolerances.
    /// - Parameters:
    ///   - other: The value to which self is compared.
    ///   - absoluteTolerance: The absolute tolerance to use in the comparison.
    ///   - relativeTolerance: The relative tolerance to use in the comparison. Defaults to zero.
    /// - Returns: true if self and other are equal, or if they are finite and either.
    func isApproximatelyEqual(to other: CLLocationCoordinate2D, absoluteTolerance: Double, relativeTolerance: Double = 0) -> Bool {
        let latitudeIsApproximatelyEqual = latitude.isApproximatelyEqual(
            to: other.latitude,
            absoluteTolerance: absoluteTolerance,
            relativeTolerance: relativeTolerance
        )
        let longitudeIsApproximatelyEqual = longitude.isApproximatelyEqual(
            to: other.longitude,
            absoluteTolerance: absoluteTolerance,
            relativeTolerance: relativeTolerance
        )
        return latitudeIsApproximatelyEqual && longitudeIsApproximatelyEqual
    }
}

extension CLLocationCoordinate2D {
    static let portTownsend = CLLocationCoordinate2D(latitude: 48.11638, longitude: -122.77527)
    static let capeHorn = CLLocationCoordinate2D(latitude: -55.97917, longitude: -67.275)
    static let seychelles = CLLocationCoordinate2D(latitude: -4.67785, longitude: 55.46718)
    static let faroeIslands = CLLocationCoordinate2D(latitude: 62.06323, longitude: -6.87355)
    static let amchitkaIsland = CLLocationCoordinate2D(latitude: 51.37363, longitude: 179.41535)
    static let pointNemo = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)
    static let nullIsland = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
}
