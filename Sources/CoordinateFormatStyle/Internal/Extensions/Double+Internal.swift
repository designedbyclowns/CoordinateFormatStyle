import Numerics

extension Double {
    /// Rounds `Decimal` to `scale` decimal places.
    /// - Parameter scale: ow many decimal places to round to.
    /// - Returns: The rounded `Double` value.
    func rounded(to scale: UInt) -> Double {
        let multiplier = Double.pow(10, Double(scale))
        return (self * multiplier).rounded() / multiplier
    }
}
