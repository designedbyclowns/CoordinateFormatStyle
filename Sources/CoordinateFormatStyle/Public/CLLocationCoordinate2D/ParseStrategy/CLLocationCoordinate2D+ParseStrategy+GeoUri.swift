public import Foundation
public import CoreLocation
import GeoURI

extension CLLocationCoordinate2D.ParseStrategy {
    
    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from ['geo' URI](https://geouri.org) formatted strings.
    public struct GeoUri: Foundation.ParseStrategy, Sendable {
        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D
        
        public func parse(_ value: String) throws -> CLLocationCoordinate2D {
            return try GeoURI(string: value).coordinate
        }
    }
}
