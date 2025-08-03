import CoreLocation

extension CLLocationCoordinate2D {
    func rounded(to precision: CLLocationDegrees.Precision) -> CLLocationCoordinate2D {
        .init(
            latitude: latitude.rounded(to: precision),
            longitude: longitude.rounded(to: precision)
        )
    }
}
