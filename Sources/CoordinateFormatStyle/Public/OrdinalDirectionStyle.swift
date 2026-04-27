/// Specifies how to indicate the ordinal direction of the latitude and longitude.
public enum OrdinalDirectionStyle: Codable, Sendable {
    /// Indicates the ordinal direction using a positive or negative sign
    /// as defined by the user's locale and settings.
    ///
    /// A latitude in either the Northern or Southern hemisphere is represented by
    /// a positive or negative sign respectively.
    ///
    /// Similarly a longitude in either the Eastern or Western hemisphere is
    /// represented by a positive or negative sign respectively.
    ///
    case signed
    
    /// Indicates the ordinal direction using a suffix.
    ///
    /// A latitude in either the Northern or Southern hemisphere is represented by the suffix `N`, or `S` respectively.
    ///
    /// Similarly a longitude in either the Eastern or Western hemisphere is represented by the suffix `E`, or `W` respectively.
    ///
    case suffix
}
