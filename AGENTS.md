# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

`CoordinateFormatStyle` is a Swift Package that provides Foundation `FormatStyle` and `ParseStrategy` conformances for `CLLocationCoordinate2D`, supporting five textual formats: Decimal Degrees (DD), Degrees Decimal Minutes (DDM), Degrees Minutes Seconds (DMS), `geo:` URI, and UTM. Public entry points live under `CLLocationCoordinate2D.FormatStyle` / `CLLocationCoordinate2D.ParseStrategy`, plus extension statics on `Foundation.FormatStyle` so call sites can write `.decimalDegrees`, `.utm`, etc.

- Swift tools 6.2; platforms: macOS 13, iOS 16, watchOS 9, tvOS 16.
- Tests use **Swift Testing** (`import Testing`, `@Test`), not XCTest.
- Dependencies: `UTMConversion` (a `designedbyclowns` fork pinned to a branch), `GeoURI`, and `swift-numerics` (test target only).

## Common commands

```bash
swift build                                    # build the package
swift test                                     # run all tests
swift test --filter <TestTypeName>             # run a single test type (Swift Testing)
swift test --filter <TestTypeName>/<testName>  # run a single test function
swift package resolve                          # refresh Package.resolved after editing dependencies
swift package generate-documentation           # build the DocC catalog (CoordinateFormatStyle.docc)
```

CI (`.github/workflows/tests.yml`) runs `swift build -v` and `swift test -v` on `macos-latest`.

## Architecture

The library is structured as **two layers**, with a clean Public/Internal split that mirrors the on-disk layout under `Sources/CoordinateFormatStyle/`:

1. **Coordinate-pair layer (Public)** — `CLLocationCoordinate2D.FormatStyle.{DecimalDegrees, DegreesDecimalMinutes, DegreesMinutesSeconds, GeoUri, UTM}` and the matching `ParseStrategy` types. These are the public API. Each pair-level format style delegates to the per-axis layer below: it formats `value.latitude` and `value.longitude` independently with `.orientation(.latitude)` / `.orientation(.longitude)`, validates with `CLLocationCoordinate2DIsValid`, and joins with `", "`.
2. **Per-axis layer (Internal)** — `CLLocationDegrees.FormatStyle` / `CLLocationDegrees.ParseStrategy` variants. These do the real work of formatting/parsing a single `CLLocationDegrees` (a `Double`) and are aware of orientation (lat vs lon) so they can pick the correct hemisphere letter and clamp range.

`UTM` and `GeoUri` are slightly different: they delegate to the `UTMConversion` and `GeoURI` packages rather than the per-axis layer.

### Shared building blocks (`Sources/CoordinateFormatStyle/Internal/`)
- `CoordinateOrientation` — `.latitude`/`.longitude`/`.unspecified`; carries the valid degree range used for validation.
- `CoordinateHemisphere` — N/S/E/W with mapping to/from orientation and sign.
- `CoordinateSymbol` — degree/minute/second glyphs in `.simple` vs `.canonical` form.
- `CoordinateComponent` — a validated `(value, orientation)` pair used during parsing.
- `CoordinateFormatStyle` (helper, `Internal/CoordinateFormatStyle.swift`) — `components(from:)` splits a coordinate-pair string on comma (preferred) or space; `resolveDirection(prefix:suffix:)` reconciles N/S/E/W appearing on either side; `normalize(degrees:minutes:seconds:orientation:inHemisphere:)` collapses DMS/DDM into signed decimal degrees and enforces range. Touch this when changing how *any* parser tokenizes or normalizes input.
- `UTMLatitudeBand` — UTM-specific latitude band table.

### Public configuration knobs
- `SymbolStyle` — `.none` / `.simple` (`° ′ ″`) / `.canonical` (`° ' "`).
- `OrdinalDirectionStyle` — `.signed` / `.prefix` / `.suffix`.
- `ParsingOptions` — `OptionSet` with `.caseInsensitive`, `.trimmed`.
- `ParsingError` — exhaustive parse errors (`noMatch`, `conflict`, `invalidDirection`, `invalidRange*`, `invalidZone`, `invalidLatitudeBand`, `notFound(name:)`, `unsupportedCoordinateReferenceSystem(crs:)`). Throw the most specific case; tests assert on these.
- Default `formatted()` (no args) on `CLLocationCoordinate2D` uses `.degreesMinutesSeconds.ordinalStyle(.suffix).symbolStyle(.canonical)`. Changing this default is a behavior change — update tests.

### Adding or changing a format
When adding a new format or changing an existing one, expect to touch four parallel files plus the `CoordinateFormat` enum and the `FormatStyle` / `ParseStrategy` extension statics:

- `Public/CLLocationCoordinate2D/FormatStyle/CLLocationCoordinate2D+FormatStyle+<Name>.swift`
- `Public/CLLocationCoordinate2D/ParseStrategy/CLLocationCoordinate2D+ParseStrategy+<Name>.swift`
- `Internal/CLLocationDegrees/FormatStyle/CLLocationDegrees+FormatStyle+<Name>.swift`
- `Internal/CLLocationDegrees/ParseStrategy/CLLocationDegrees+ParseStrategy+<Name>.swift`
- `Public/CoordinateFormat.swift` (add a case)
- `Public/Extensions/FormatStyle.swift` and `Public/Extensions/ParseStrategy.swift` (add the `.<name>` static)
- `Sources/CoordinateFormatStyle/CoordinateFormatStyle.docc/<Name>FormatStyle.md`

The `Foundation.FormatStyle` conformance must be `Sendable`, declare `FormatInput`/`FormatOutput`, and provide `with`-style modifier methods (e.g. `symbolStyle(_:)`, `ordinalStyle(_:)`, `compact(_:)`) that return a new `Self` — see `DecimalDegrees` for the canonical pattern. The format style should also conform to `ParseableFormatStyle` and expose `parseStrategy`.

### Module imports
Public sources use Swift 6.2 `public import` for re-exported types (`Foundation`, `CoreLocation`, `UTMConversion`, `GeoURI`). Keep that — downstream code relies on these being visible through `CoordinateFormatStyle`.

`Package.swift` has commented-out upcoming features (`defaultIsolation(MainActor.self)`, `NonisolatedNonsendingByDefault`, `InferIsolatedConformances`, `InternalImportsByDefault`). They are intentionally off — do not silently enable them.
