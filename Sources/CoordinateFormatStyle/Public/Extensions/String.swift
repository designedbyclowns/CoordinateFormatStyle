import CoreLocation
import Foundation

extension String {
    
    // MARK: CLLocationCoordinate2D - Public
    
    public init<F: FormatStyle>(coordinate: CLLocationCoordinate2D,  style: F) where F.FormatInput == CLLocationCoordinate2D, F.FormatOutput == Self {
        self = style.format(coordinate)
    }

    public func coordinate<P: ParseStrategy>(_ strategy: P) throws -> P.ParseOutput where P.ParseInput == String, P.ParseOutput == CLLocationCoordinate2D {
        try strategy.parse(self)
    }
    
    // MARK: CLLocationDegrees - Internal
    
    init<F: FormatStyle>(degrees: CLLocationDegrees,  style: F) where F.FormatInput == CLLocationDegrees, F.FormatOutput == Self {
        self = style.format(degrees)
    }
    
    func degrees<P: ParseStrategy>(_ strategy: P) throws -> P.ParseOutput where P.ParseInput == String, P.ParseOutput == CLLocationDegrees {
        try strategy.parse(self)
    }    
}
