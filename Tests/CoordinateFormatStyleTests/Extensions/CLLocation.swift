import CoreLocation
@testable import CoordinateFormatStyle

extension CLLocation {
    
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    static let mountEverest = CLLocation(
        coordinate: CLLocationCoordinate2D(latitude: 27.988056, longitude: 86.925278),
        altitude: 8848.86,
        horizontalAccuracy: 0,
        verticalAccuracy: 0.21,
        timestamp: Date()
    )
    
    static let challengerDeep = CLLocation(
        coordinate: CLLocationCoordinate2D(latitude: 11.373333, longitude: 142.591667),
        altitude: -10920,
        horizontalAccuracy: 0.0,
        verticalAccuracy: 10.0,
        timestamp: Date()
    )
    
    static let pointNemo = CLLocation(coordinate: .pointNemo)
}
