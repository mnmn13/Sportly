// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI
#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#elseif os(tvOS) || os(watchOS)
import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.SystemColor", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.SystemColor
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
internal enum Assets {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let baseballLogo = ImageAsset(name: "baseballLogo")
  internal static let basketLogo = ImageAsset(name: "basketLogo")
  internal static let footballLogo = ImageAsset(name: "footballLogo")
  internal static let hockeyLogo = ImageAsset(name: "hockeyLogo")
  internal static let nbaLogo = ImageAsset(name: "nbaLogo")
  internal static let rugbyLogo = ImageAsset(name: "rugbyLogo")
  internal static let volleyballLogo = ImageAsset(name: "volleyballLogo")
  internal static let sportlyLogo = ImageAsset(name: "SportlyLogo")
  internal static let sportlyLogo2 = ImageAsset(name: "SportlyLogo2")
  internal static let sportlyLogoBlured = ImageAsset(name: "SportlyLogoBlured")
  internal static let sportlyLogoBlured2 = ImageAsset(name: "SportlyLogoBlured2")
  internal static let ball = ImageAsset(name: "ball")
  internal static let footballBoots = ImageAsset(name: "footballBoots")
  internal static let player = ImageAsset(name: "player")
  internal static let background = ColorAsset(name: "background")
}
internal enum Colors {
  internal static let bannerBlue = ColorAsset(name: "bannerBlue")
  internal static let bannerBlueBorder = ColorAsset(name: "bannerBlueBorder")
  internal static let bannerBlueTranslucent = ColorAsset(name: "bannerBlueTranslucent")
  internal static let bannerGreen = ColorAsset(name: "bannerGreen")
  internal static let bannerGreenBorder = ColorAsset(name: "bannerGreenBorder")
  internal static let bannerGreenTranslucent = ColorAsset(name: "bannerGreenTranslucent")
  internal static let bannerOrange = ColorAsset(name: "bannerOrange")
  internal static let bannerOrangeBorder = ColorAsset(name: "bannerOrangeBorder")
  internal static let bannerOrangeTranslucent = ColorAsset(name: "bannerOrangeTranslucent")
  internal static let bannerRed = ColorAsset(name: "bannerRed")
  internal static let bannerRedBorder = ColorAsset(name: "bannerRedBorder")
  internal static let bannerRedTranslucent = ColorAsset(name: "bannerRedTranslucent")
  internal static let background = ColorAsset(name: "background")
  internal static let gray = ColorAsset(name: "gray")
  internal static let gray2 = ColorAsset(name: "gray2")
  internal static let gray3 = ColorAsset(name: "gray3")
  internal static let grayPV = ColorAsset(name: "grayPV")
  internal static let green1 = ColorAsset(name: "green1")
  internal static let green2 = ColorAsset(name: "green2")
  internal static let logoBG = ColorAsset(name: "logoBG")
  internal static let purple = ColorAsset(name: "purple")
  internal static let red = ColorAsset(name: "red")
}
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
internal fileprivate(set) var name: String

#if os(macOS)
internal typealias SystemColor = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
internal typealias SystemColor = UIColor
#endif

@available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
internal private(set) lazy var systemColor: SystemColor = {
guard let color = SystemColor(asset: self) else {
fatalError("Unable to load color asset named \(name).")
}
return color
}()


internal private(set) lazy var color: Color = {
Color(systemColor)
}()

fileprivate init(name: String) {
self.name = name
}
}

internal extension ColorAsset.SystemColor {
@available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
convenience init?(asset: ColorAsset) {
let bundle = BundleToken.bundle
#if os(iOS) || os(tvOS)
self.init(named: asset.name, in: bundle, compatibleWith: nil)
#elseif os(macOS)
self.init(named: NSColor.Name(asset.name), bundle: bundle)
#elseif os(watchOS)
self.init(named: asset.name)
#endif
}
}

internal struct ImageAsset {
internal fileprivate(set) var name: String

#if os(macOS)
internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
internal typealias Image = UIImage
#endif

internal var image: Image {
let bundle = BundleToken.bundle
#if os(iOS) || os(tvOS)
let image = Image(named: name, in: bundle, compatibleWith: nil)
#elseif os(macOS)
let name = NSImage.Name(self.name)
let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
#elseif os(watchOS)
let image = Image(named: name)
#endif
guard let result = image else {
fatalError("Unable to load image asset named \(name).")
}
return result
}
}

internal extension ImageAsset.Image {
@available(macOS, deprecated,
message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
convenience init?(asset: ImageAsset) {
#if os(iOS) || os(tvOS)
let bundle = BundleToken.bundle
self.init(named: asset.name, in: bundle, compatibleWith: nil)
#elseif os(macOS)
self.init(named: NSImage.Name(asset.name))
#elseif os(watchOS)
self.init(named: asset.name)
#endif
}
}

// swiftlint:disable convenience_type
private final class BundleToken {
static let bundle: Bundle = {
#if SWIFT_PACKAGE
return Bundle.module
#else
return Bundle(for: BundleToken.self)
#endif
}()
}

// swiftlint:enable convenience_type
