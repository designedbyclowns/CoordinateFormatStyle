import CoreLocation

public struct CoordinateComponent: Codable {
    let value: CLLocationDegrees
    let orientation: CoordinateOrientation
    
    public init(_ value: CLLocationDegrees, orientation: CoordinateOrientation) throws(ParsingError) {
        guard orientation.range.contains(value) else {
            throw .invalidRangeDegrees
        }
        self.orientation = orientation
        self.value = value
    }
    
    public var hemisphere: CoordinateHemisphere {
        switch orientation {
        case .latitude:
            return value >= .zero ? .north : .south
            
        case .longitude, .unspecified:
            return value >= .zero ? .east : .west
        }
    }
}
