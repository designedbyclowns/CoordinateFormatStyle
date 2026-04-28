public import Foundation
public import CoreLocation


extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.DecimalDegrees {
    /// A parse strategy that creates `CLLocationCoordinate2D` values from
    /// Decimal Degrees (DD) formatted strings.
    ///
    /// ```swift
    /// let coordinate = try CLLocationCoordinate2D("48.11638° N, 122.77527° W", parseStrategy: .decimalDegrees)
    /// ```
    public static var decimalDegrees: CLLocationCoordinate2D.ParseStrategy.DecimalDegrees {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.DegreesDecimalMinutes {
    /// A parse strategy that creates `CLLocationCoordinate2D` values from
    /// Degrees and Decimal Minutes (DDM) formatted strings.
    ///
    /// ```swift
    /// let coordinate = try CLLocationCoordinate2D("48° 06.983′ N, 122° 46.516′ W", parseStrategy: .degreesDecimalMinutes)
    /// ```
    public static var degreesDecimalMinutes: CLLocationCoordinate2D.ParseStrategy.DegreesDecimalMinutes {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.DegreesMinutesSeconds {
    /// A parse strategy that creates `CLLocationCoordinate2D` values from
    /// Degrees, Minutes, Seconds (DMS) formatted strings.
    ///
    /// ```swift
    /// let coordinate = try CLLocationCoordinate2D("48° 6′ 59″ N, 122° 46′ 31″ W", parseStrategy: .degreesMinutesSeconds)
    /// ```
    public static var degreesMinutesSeconds: CLLocationCoordinate2D.ParseStrategy.DegreesMinutesSeconds {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.GeoUri {
    /// A parse strategy that creates `CLLocationCoordinate2D` values from
    /// ['geo' URI](https://geouri.org) formatted strings.
    ///
    /// ```swift
    /// let coordinate = try CLLocationCoordinate2D("geo:48.11638,-122.77527", parseStrategy: .geoURI)
    /// ```
    public static var geoURI: CLLocationCoordinate2D.ParseStrategy.GeoUri {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.UTM {
    /// A parse strategy that creates `CLLocationCoordinate2D` values from strings
    /// formatted using the Universal Transverse Mercator (UTM) coordinate system.
    ///
    /// ```swift
    /// let coordinate = try CLLocationCoordinate2D("10U 516726m E 5329260m N", parseStrategy: .utm)
    /// ```
    public static var utm: CLLocationCoordinate2D.ParseStrategy.UTM {
        .init()
    }
}

// MARK: - Internal

extension ParseStrategy where Self == CLLocationDegrees.ParseStrategy.DecimalDegrees {
    internal static var decimalDegrees: CLLocationDegrees.ParseStrategy.DecimalDegrees {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationDegrees.ParseStrategy.DegreesDecimalMinutes {
    internal static var degreesDecimalMinutes: CLLocationDegrees.ParseStrategy.DegreesDecimalMinutes {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationDegrees.ParseStrategy.DegreesMinutesSeconds {
    internal static var degreesMinutesSeconds: CLLocationDegrees.ParseStrategy.DegreesMinutesSeconds {
        .init()
    }
}
