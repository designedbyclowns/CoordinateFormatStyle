import CoreLocation

extension CLLocationDegrees {
    
    /// Test if self and other are approximately equal with specified precision.
    /// - Parameters:
    ///   - other: The value to which self is compared.
    ///   - precision: The ``CLLocationDegrees/Precision`` to use in the comparison.
    /// - Returns: true if self and other are equal.
    public func isApproximatelyEqual(to other: CLLocationDegrees, precision: Precision) -> Bool {
        self.isApproximatelyEqual(to: other, absoluteTolerance: precision.tolerance)
    }
}
