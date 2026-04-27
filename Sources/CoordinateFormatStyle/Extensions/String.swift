import CoreLocation
import Foundation

extension String {
    
    /// Parses a coordinate value from a string.
    ///
    /// Attempts to recognize a valid coordinate in Decimal Degrees, Degrees Decimal Minutes,
    /// Degrees Minutes Seconds, UTM or GeoURI formats.
    ///
    /// - Returns: the recognized `CLLocationCoordinate2D` value, or nil.
    func coordinate() -> CLLocationCoordinate2D?  {
        // Try each parsing strategy individually to avoid existential type issues
        if let coord = try? self.coordinate(CLLocationCoordinate2D.DecimalDegreesParseStrategy()) {
            return coord
        }
        
        if let coord = try? self.coordinate(CLLocationCoordinate2D.DegreesDecimalMinutesParseStrategy()) {
            return coord
        }
        
        if let coord = try? self.coordinate(CLLocationCoordinate2D.DegreesMinutesSecondsParseStrategy()) {
            return coord
        }
        
        if let coord = try? self.coordinate(CLLocationCoordinate2D.UTMParseStrategy()) {
            return coord
        }
        
        if let coord = try? self.coordinate(CLLocationCoordinate2D.GeoUriParseStrategy()) {
            return coord
        }
                
        return nil
    }
    
    /// Parses a location degrees value from a string.
    ///
    /// Attempts to recognize a valid coordinate in Decimal Degrees, Degrees Decimal Minutes,
    /// or Degrees Minutes Seconds formats.
    ///
    /// - Returns: the recognized `CLLocationDegrees` value, or nil.
    func degrees() -> CLLocationDegrees? {
        // Try each parsing strategy individually to avoid existential type issues
        if let degrees = try? self.degrees(CLLocationDegrees.DecimalDegreesParseStrategy()) {
            return degrees
        }
        
        if let degrees = try? self.degrees(CLLocationDegrees.DegreesDecimalMinutesParseStrategy()) {
            return degrees
        }
        
        if let degrees = try? self.degrees(CLLocationDegrees.DegreesMinutesSecondsParseStrategy()) {
            return degrees
        }
                
        return nil
    }
    
    public func coordinate<F: Foundation.ParseStrategy>(_ style: F) throws -> F.ParseOutput where F.ParseInput == String, F.ParseOutput == CLLocationCoordinate2D {
        try style.parse(self)
    }
    
    public func degrees<F: Foundation.ParseStrategy>(_ style: F) throws -> F.ParseOutput where F.ParseInput == String, F.ParseOutput == CLLocationDegrees {
        try style.parse(self)
    }
}

