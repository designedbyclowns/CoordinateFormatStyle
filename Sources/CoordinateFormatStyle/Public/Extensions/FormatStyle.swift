public import Foundation
public import CoreLocation


extension FormatStyle where Self == CLLocationCoordinate2D.FormatStyle.DecimalDegrees {
    /// Formats a `CLLocationCoordinate2D` using the Decimal Degrees (DD) format.
    ///
    /// let str = coordinate.formatted(.decimalDegrees)
    public static var decimalDegrees: CLLocationCoordinate2D.FormatStyle.DecimalDegrees {
        .init()
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.FormatStyle.DegreesDecimalMinutes {
    /// Formats a `CLLocationCoordinate2D` using the Degrees and Decimal Minutes (DDM) format.
    ///
    /// let str = coordinate.formatted(.degreesDecimalMinutes)
    public static var degreesDecimalMinutes: CLLocationCoordinate2D.FormatStyle.DegreesDecimalMinutes {
        .init()
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds {
    /// Formats a `CLLocationCoordinate2D` using the Degrees, Minutes, Seconds (DMS) format.
    ///
    /// let str = coordinate.formatted(.degreesMinutesSeconds)
    public static var degreesMinutesSeconds: CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds {
        .init()
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.FormatStyle.GeoUri {
    /// Formats a `CLLocationCoordinate2D` using the ['geo' URI](https://geouri.org) scheme format.
    ///
    /// let str = coordinate.formatted(.geoURI)
    public static var geoURI: CLLocationCoordinate2D.FormatStyle.GeoUri {
        .init()
    }
}

extension Foundation.FormatStyle where Self == CLLocationCoordinate2D.FormatStyle.UTM {
    /// Formats a `CLLocationCoordinate2D` using the Universal Transverse Mercator (UTM) coordinate system.
    ///
    /// let str = coordinate.formatted(.utm)
    public static var utm: CLLocationCoordinate2D.FormatStyle.UTM {
        .init()
    }
}
