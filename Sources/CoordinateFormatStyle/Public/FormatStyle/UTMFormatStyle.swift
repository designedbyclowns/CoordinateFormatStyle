import Foundation
import CoreLocation
import UTMConversion

/// A `FormatStyle` that converts a `CLLocationCoordinate2D` into a string
///  representation using the Universal Transverse Mercator (UTM) format.
public typealias UTMFormatStyle = CLLocationCoordinate2D.UTMFormatStyle

extension CLLocationCoordinate2D {
    /// A `FormatStyle` that converts a `CLLocationCoordinate2D` into a string
    ///  representation using the Universal Transverse Mercator (UTM) format.
    ///
    ///  - ``CoordinateFormat/utm``
    public struct UTMFormatStyle : Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
                
        public init(options: DisplayOptions = [.suffix]) {
            self.options = options
        }
        
        public func options(_ options: DisplayOptions) -> Self {
            .init(options: options)
        }

        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value), let coordinate = try? value.utmCoordinate() else {
                return ""
            }
            return UTMCoordinate.FormatStyle(options: options).format(coordinate)
        }
        
        // MARK: - Private
        
        private let options: DisplayOptions
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.UTMFormatStyle {
    public static var utm:  CLLocationCoordinate2D.UTMFormatStyle { .init() }
}

