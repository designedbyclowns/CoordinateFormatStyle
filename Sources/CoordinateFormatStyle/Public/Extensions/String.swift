public import CoreLocation
public import Foundation

extension String {
    
    /// Parses a coordinate value from a string.
    ///
    /// Attempts to recognize a valid coordinate in Decimal Degrees, Degrees Decimal Minutes,
    /// Degrees Minutes Seconds, UTM or GeoURI formats.
    ///
    /// - Returns: the recognized `CLLocationCoordinate2D` value, or nil.
    public func coordinate() -> CLLocationCoordinate2D?  {
        // Try each parsing strategy individually to avoid existential type issues
        if let coord = try? CLLocationCoordinate2D(self, parseStrategy: .decimalDegrees) {
            return coord
        }
        
        if let coord = try? CLLocationCoordinate2D(self, parseStrategy: .degreesDecimalMinutes) {
            return coord
        }
        
        if let coord = try? CLLocationCoordinate2D(self, parseStrategy: .degreesMinutesSeconds) {
            return coord
        }
        
        if let coord = try? CLLocationCoordinate2D(self, parseStrategy: .utm) {
            return coord
        }
        
        if let coord = try? CLLocationCoordinate2D(self, parseStrategy: .geoURI) {
            return coord
        }
                
        return nil
    }

    public func coordinate<F: Foundation.ParseStrategy>(_ style: F) throws -> F.ParseOutput where F.ParseInput == String, F.ParseOutput == CLLocationCoordinate2D {
        try style.parse(self)
    }
    
    // MARK: - Internal
    
    func degrees<F: Foundation.ParseStrategy>(_ style: F) throws -> F.ParseOutput where F.ParseInput == String, F.ParseOutput == CLLocationDegrees {
        try style.parse(self)
    }
    
    /// Parses a location degrees value from a string.
    ///
    /// Attempts to recognize a valid coordinate in Decimal Degrees, Degrees Decimal Minutes,
    /// or Degrees Minutes Seconds formats.
    ///
    /// - Returns: the recognized `CLLocationDegrees` value, or nil.
    internal func degrees() -> CLLocationDegrees? {
        // Try each parsing strategy individually to avoid existential type issues
        if let degrees = try? CLLocationDegrees(self, parseStrategy: .decimalDegrees) {
            return degrees
        }
        
        if let degrees = try? CLLocationDegrees(self, parseStrategy: .degreesDecimalMinutes) {
            return degrees
        }
        
        if let degrees = try? CLLocationDegrees(self, parseStrategy: .degreesMinutesSeconds) {
            return degrees
        }
                
        return nil
    }
}

