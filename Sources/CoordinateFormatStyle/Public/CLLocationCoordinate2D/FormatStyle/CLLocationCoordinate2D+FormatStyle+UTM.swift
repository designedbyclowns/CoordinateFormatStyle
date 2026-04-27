public import Foundation
public import CoreLocation
import UTMConversion

extension CLLocationCoordinate2D.FormatStyle {
    
    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the [Universal Transverse Mercator (UTM)](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) coordinate system.
    public struct UTM: Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
        
        public var compact: Bool
        
        public init(compact: Bool = false) {
            self.compact = compact
        }

        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value), let utm = try? value.utmCoordinate() else {
                return ""
            }
            
            let style = UTMCoordinate.FormatStyle().compact(compact)
            
            return style.format(utm)
        }
        
        public func compact(_ compact: Bool) -> Self {
            .init(compact: compact)
        }
    }
}

extension CLLocationCoordinate2D.FormatStyle.UTM {
    public var parseStrategy: CLLocationCoordinate2D.ParseStrategy.UTM {
        .init()
    }
}
