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
}
