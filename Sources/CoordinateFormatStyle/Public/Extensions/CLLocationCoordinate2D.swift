import Foundation
import CoreLocation

extension CLLocationCoordinate2D {    
    public init<P: Foundation.ParseStrategy>(
        _ value: String,
        parseStrategy: P
    ) throws where P.ParseInput == String, P.ParseOutput == CLLocationCoordinate2D {
        self = try parseStrategy.parse(value)
    }
    
    public func formatted<F: Foundation.FormatStyle>(_ style: F) -> F.FormatOutput where F.FormatInput == Self {
        style.format(self)
    }

}
