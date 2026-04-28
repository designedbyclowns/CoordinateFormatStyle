 /// Options affecting how a coordinate is parsed from a string.
public struct ParsingOptions: OptionSet, Sendable, Codable, Hashable {
    /// Disregard case when matching strings.
    public static let caseInsensitive = Self(rawValue: 1 << 0)
    /// Ignore whitespace at the beginning and end of the string.
    public static let trimmed = Self(rawValue: 1 << 1)
    
    /// Creates an option set from the given raw value.
    /// - Parameter rawValue: The bitfield representation of the option set.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// The bitfield representation of the option set.
    public let rawValue: Int
}
