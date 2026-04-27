import Testing
import CoreLocation
@testable import CoordinateFormatStyle

struct CoordinateOrientationTests {

    @Test func range() throws {
        #expect(CoordinateOrientation.latitude.range == -90.0...90.0)
        #expect(CoordinateOrientation.longitude.range == -180.0...180.0)
        #expect(CoordinateOrientation.unspecified.range == -180.0...180.0)
    }
    
    @Test func latHemisphereForDegrees() throws {
        let orientation = CoordinateOrientation.latitude
        
        #expect(orientation.hemisphere(for: 0.0) == .north)
        #expect(orientation.hemisphere(for: 90.0) == .north)
        
        #expect(orientation.hemisphere(for: -0.1) == .south)
        #expect(orientation.hemisphere(for: -90.0) == .south)
        
        #expect(orientation.hemisphere(for: 90.1) == nil)
        #expect(orientation.hemisphere(for: -90.1) == nil)
    }
    
    @Test func lonHemisphereForDegrees() throws {
        let orientation = CoordinateOrientation.longitude
        
        #expect(orientation.hemisphere(for: 0.0) == .east)
        #expect(orientation.hemisphere(for: 180.0) == .east)
        
        #expect(orientation.hemisphere(for: -0.1) == .west)
        #expect(orientation.hemisphere(for: -180.0) == .west)
        
        #expect(orientation.hemisphere(for: 180.1) == nil)
        #expect(orientation.hemisphere(for: -180.1) == nil)
    }
    
    @Test func unspecifiedHemisphereForDegrees() throws {
        let orientation = CoordinateOrientation.unspecified
        
        #expect(orientation.hemisphere(for: 0.0) == nil)
        #expect(orientation.hemisphere(for: 90.0) == nil)
        
        #expect(orientation.hemisphere(for: -0.1) == nil)
        #expect(orientation.hemisphere(for: -90.0) == nil)
    }
 }
