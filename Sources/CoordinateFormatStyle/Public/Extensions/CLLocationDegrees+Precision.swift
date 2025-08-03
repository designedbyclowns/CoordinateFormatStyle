import CoreLocation

extension CLLocationDegrees {
    /// Represents the fractional scale of `CLLocationDegrees` expressed as decimal positions.
    public enum Precision: UInt, Codable {
        /// 0 decimal places.
        ///
        /// Country or large region.
        case decimalPlaces0 = 0
        
        /// 1 decimal place.
        ///
        /// Represents 111 kilometers at the equator.
        ///
        /// A large city or district is _unambiguously_ recognizable at this scale.
        case decimalPlaces1 = 1
        
        /// 2 decimal places.
        ///
        /// Represents 11.1 kilometers at the equator.
        ///
        /// A town or village is _unambiguously_ recognizable at this scale.
        case decimalPlaces2 = 2
        
        /// 3 decimal places.
        ///
        /// Represents 1.11 kilometers at the equator.
        ///
        /// A neighborhood, street is _unambiguously_ recognizable at this scale.
        case decimalPlaces3 = 3
        
        /// 4 decimal places.
        ///
        /// Represents 111 meters at the equator.
        ///
        /// A neighborhood, street is _unambiguously_ recognizable at this scale.
        case decimalPlaces4 = 4
        
        /// 5 decimal places.
        ///
        /// Represents 11.1 meters at the equator.
        ///
        /// An individual street, large building is _unambiguously_ recognizable at this scale.
        ///
        /// > This the practical limit of basic GPS.
        case decimalPlaces5 = 5
        
        /// 6 decimal places.
        ///
        /// Represents 1.11 meters at the equator.
        ///
        /// Individual humans are _unambiguously_ recognizable at this scale.
        ///
        /// > Typically requires the enhanced accuracy of Differential GPS (DGPS).
        case decimalPlaces6 = 6
        
        /// 7 decimal places.
        ///
        /// Represents 111 millimeters at the equator.
        ///
        /// The practical limit of commercial surveying.
        ///
        /// > Real-Time Kinematic (RTK) GPS.
        case decimalPlaces7 = 7
        
        /// 8 decimal places.
        ///
        /// Represents 1.11 millimeters at the equator.
        ///
        /// Specialized surveying.
        case decimalPlaces8 = 8
    }
}

extension CLLocationDegrees.Precision {
    var tolerance: Double {
        switch self {
        case .decimalPlaces0:
            return .zero
        case .decimalPlaces1:
            return 1E-01
        case .decimalPlaces2:
            return 1E-02
        case .decimalPlaces3:
            return 1E-03
        case .decimalPlaces4:
            return 1E-04
        case .decimalPlaces5:
            return 1E-05
        case .decimalPlaces6:
            return 1E-06
        case .decimalPlaces7:
            return 1E-07
        case .decimalPlaces8:
            return 1E-08
        }
    }
}
