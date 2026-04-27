public import Foundation
public import CoreLocation


extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.DecimalDegrees {
    public static var decimalDegrees: CLLocationCoordinate2D.ParseStrategy.DecimalDegrees {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.DegreesDecimalMinutes {
    public static var degreesDecimalMinutes: CLLocationCoordinate2D.ParseStrategy.DegreesDecimalMinutes {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.DegreesMinutesSeconds {
    public static var degreesMinutesSeconds: CLLocationCoordinate2D.ParseStrategy.DegreesMinutesSeconds {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.GeoUri {
    public static var geoURI: CLLocationCoordinate2D.ParseStrategy.GeoUri {
        .init()
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.ParseStrategy.UTM {
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
