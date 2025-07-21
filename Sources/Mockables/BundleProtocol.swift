//
// Copyright © 2025, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

#if os(macOS)
import AppKit
#endif

@Mockable
public protocol BundleProtocol {

    // MARK: - Finding Resources as FileProtocol

    // Returns the file URL for the resource file identified by the specified name and
    // extension and residing in a given bundle directory.
    func file(forResource: String?, withExtension: String?, subdirectory: String?) -> FileProtocol?

    // Returns the file URL for the resource identified by the specified name and file extension.
    func file(forResource: String?, withExtension: String?) -> FileProtocol?

    // MARK: - Finding Resource Files

    // Returns the file URL for the resource file identified by the specified name and
    // extension and residing in a given bundle directory.
    func url(forResource: String?, withExtension: String?, subdirectory: String?) -> URL?

    // Returns the file URL for the resource identified by the specified name and file extension.
    func url(forResource: String?, withExtension: String?) -> URL?

    // Returns an array of file URLs for all resources identified by the specified file extension
    // and located in the specified bundle subdirectory.
    func urls(forResourcesWithExtension: String?, subdirectory: String?) -> [URL]?

    // Returns the file URL for the resource identified by the specified name and file extension,
    // located in the specified bundle subdirectory, and limited to global resources and those
    // associated with the specified localization.
    func url(forResource: String?, withExtension: String?, subdirectory: String?, localization: String?) -> URL?

    // Returns an array containing the file URLs for all bundle resources having the specified
    // filename extension, residing in the specified resource subdirectory, and limited to global
    // resources and those associated with the specified localization.
    func urls(forResourcesWithExtension: String?, subdirectory: String?, localization: String?) -> [URL]?

    // Returns the full pathname for the resource identified by the specified name and file extension.
    func path(forResource: String?, ofType: String?) -> String?

    // Returns the full pathname for the resource identified by the specified name and file extension
    // and located in the specified bundle subdirectory.
    func path(forResource: String?, ofType: String?, inDirectory: String?) -> String?

    // Returns the full pathname for the resource identified by the specified name and file extension,
    // located in the specified bundle subdirectory, and limited to global resources and those associated
    // with the specified localization.
    func path(forResource: String?, ofType: String?, inDirectory: String?, forLocalization: String?) -> String?

    // Returns an array containing the pathnames for all bundle resources having the specified filename
    // extension and residing in the resource subdirectory.
    func paths(forResourcesOfType: String?, inDirectory: String?) -> [String]

    // Returns an array containing the file for all bundle resources having the specified filename extension,
    // residing in the specified resource subdirectory, and limited to global resources and those associated
    // with the specified localization.
    func paths(forResourcesOfType: String?, inDirectory: String?, forLocalization: String?) -> [String]

    // MARK: - Fetching Localized Strings

    // Returns a localized version of the string designated by the specified key and residing in the specified table.
    func localizedString(forKey: String, value: String?, table: String?) -> String

    // MARK: - Getting the Standard Bundle Directories

    // The file URL of the bundle’s subdirectory containing resource files.
    var resourceURL: URL? { get }

    // The file URL of the receiver’s executable file.
    var executableURL: URL? { get }

    // The file URL of the bundle’s subdirectory containing private frameworks.
    var privateFrameworksURL: URL? { get }

    // The file URL of the receiver’s subdirectory containing shared frameworks.
    var sharedFrameworksURL: URL? { get }

    // The file URL of the receiver’s subdirectory containing plug-ins.
    var builtInPlugInsURL: URL? { get }

    // Returns the file URL of the executable with the specified name in the receiver’s bundle.
    func url(forAuxiliaryExecutable: String) -> URL?

    // The file URL of the bundle’s subdirectory containing shared support files.
    var sharedSupportURL: URL? { get }

    // The full pathname of the bundle’s subdirectory containing resources.
    var resourcePath: String? { get }

    // The full pathname of the receiver’s executable file.
    var executablePath: String? { get }

    // The full pathname of the bundle’s subdirectory containing private frameworks.
    var privateFrameworksPath: String? { get }

    // The full pathname of the bundle’s subdirectory containing shared frameworks.
    var sharedFrameworksPath: String? { get }

    // The full pathname of the receiver’s subdirectory containing plug-ins.
    var builtInPlugInsPath: String? { get }

    // Returns the full pathname of the executable with the specified name in the receiver’s bundle.
    func path(forAuxiliaryExecutable: String) -> String?

    // The full pathname of the bundle’s subdirectory containing shared support files.
    var sharedSupportPath: String? { get }

    // MARK: - Getting Bundle Information

    // The full URL of the receiver’s bundle directory.
    var bundleURL: URL { get }

    // The full pathname of the receiver’s bundle directory.
    var bundlePath: String { get }

    // The receiver’s bundle identifier.
    var bundleIdentifier: String? { get }

    // A dictionary, constructed from the bundle’s Info.plist file, that contains information about the receiver.
    var infoDictionary: [String: Any]? { get }

    // Returns the value associated with the specified key in the receiver’s information property list.
    func object(forInfoDictionaryKey: String) -> Any?

    // MARK: - Getting Localization Information

    // A list of all the localizations contained in the bundle.
    var localizations: [String] { get }

    // An ordered list of preferred localizations contained in the bundle.
    var preferredLocalizations: [String] { get }

    // The localization for the development language.
    var developmentLocalization: String? { get }

    // A dictionary with the keys from the bundle’s localized property list.
    var localizedInfoDictionary: [String: Any]? { get }

    // MARK: - Getting Classes from a Bundle

    // Returns the Class object for the specified name.
    func classNamed(_ named: String) -> AnyClass?

    // The bundle’s principal class.
    var principalClass: AnyClass? { get }

    // MARK: - Loading Code from a Bundle

    // An array of numbers indicating the architecture types supported by the bundle’s executable.
    var executableArchitectures: [NSNumber]? { get }

    // Returns a Boolean value indicating whether the bundle’s executable code could be loaded successfully.
    func preflight() throws

    // Dynamically loads the bundle’s executable code into a running program, if the code has not already been loaded.
    func load() -> Bool

    // Loads the bundle’s executable code and returns any errors.
    func loadAndReturnError() throws

    // Unloads the code associated with the receiver.
    func unload() -> Bool

    // The load status of a bundle.
    var isLoaded: Bool { get }
}

public extension BundleProtocol {
    static var didLoadNotification: NSNotification.Name {
        Bundle.didLoadNotification
    }

    // Returns the file URL for the resource file identified by the specified name and
    // extension and residing in a given bundle directory.
    func file(
        forResource resource: String?,
        withExtension ext: String?,
        subdirectory directory: String?
    ) -> FileProtocol? {
        url(forResource: resource, withExtension: ext, subdirectory: directory).map { url in
            File(path: url)
        }
    }

    // Returns the file URL for the resource identified by the specified name and file extension.
    func file(forResource: String?, withExtension: String?) -> FileProtocol? {
        file(
            forResource: forResource,
            withExtension: withExtension,
            subdirectory: nil
        )
    }

}

extension Bundle: BundleProtocol {}
