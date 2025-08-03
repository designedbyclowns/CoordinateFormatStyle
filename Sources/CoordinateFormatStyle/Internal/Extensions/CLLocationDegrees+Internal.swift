import CoreLocation
import Foundation

extension CLLocationDegrees {    
    init<P: Foundation.ParseStrategy>(
        _ value: String,
        parseStrategy: P
    ) throws where P.ParseInput == String, P.ParseOutput == CLLocationDegrees {
        self = try parseStrategy.parse(value)
    }
    
    func formatted<F: Foundation.FormatStyle>(_ style: F) -> F.FormatOutput where F.FormatInput == Self {
        style.format(self)
    }
    
    func rounded(to precision: CLLocationDegrees.Precision) -> CLLocationDegrees {
        self.rounded(to: precision.rawValue)
    }
    
    init(degrees: CLLocationDegrees,
         minutes: Double?,
         seconds: Double?,
         precision: Precision?,
         orientation: CoordinateOrientation,
         inHemisphere hemisphere: CoordinateHemisphere?
    ) throws(ParsingError) {
        var degrees = degrees
        var actualOrientation = orientation
        
        if let hemisphere {
            switch hemisphere {
            case .south, .west:
                if degrees > 0 { degrees.negate() }
            case .north, .east:
                if degrees < 0 { degrees.negate() }
            }
            
            if orientation != .unspecified {
                // Expected orientation does not match parsed direction
                guard orientation == hemisphere.orientation else { throw ParsingError.invalidDirection }
            }
            
            actualOrientation = hemisphere.orientation
        }
        
        if let minutes {
            let minutesAsDegrees = minutes / 60
            degrees += degrees < 0 ? -minutesAsDegrees : minutesAsDegrees
        }
        
        if let seconds {
            let secondsAsDegrees = seconds / 3600
            degrees += degrees < 0 ? -secondsAsDegrees : secondsAsDegrees
        }
        
        guard actualOrientation.range.contains(degrees) else {
            throw ParsingError.invalidRangeDegrees
        }
        
        if let precision {
            self = degrees.rounded(precision: precision)
        } else {
            self = degrees
        }
    }
    
    func rounded(precision: CLLocationDegrees.Precision) -> CLLocationDegrees {
        return self.rounded(to: precision.rawValue)
    }
}
