//
// © Copyright 2025, David W. Berry. All Rights Reserved.
//

import Foundation
import Mockable

/// ``Mockable`` protocol mirroring ``FileManager``
@Mockable
public protocol FileManagerProtocol {
    // MARK: - Supporting Types
    /// Options for enumerating the contents of directories.
    typealias DirectoryEnumerationOptions = FileManager.DirectoryEnumerationOptions

    /// The location of significant directories.
    typealias SearchPathDirectory = FileManager.SearchPathDirectory

    /// Domain constants specifying base locations to use when you search for significant directories.
    typealias SearchPathDomainMask = FileManager.SearchPathDomainMask

    /// Enumerates over directory contents
    typealias DirectoryEnumerator = FileManager.DirectoryEnumerator

    /// Options for enumerating volumes.
    typealias VolumeEnumerationOptions = FileManager.VolumeEnumerationOptions

    /// Options for replacing items.
    typealias ItemReplacementOptions = FileManager.ItemReplacementOptions

    /// Constants indicating the relationship between a directory and an item.
    typealias URLRelationship = FileManager.URLRelationship

#if os(macOS)
    /// Options that specify the behavior of an unmount operation.
    typealias UnmountOptions = FileManager.UnmountOptions
#endif

    // MARK: - Properties

    /// The temporary directory for the current user.
    var temporaryDirectory: URL { get }

    /// An opaque token that represents the current user’s iCloud Drive Documents identity.
    var ubiquityIdentityToken: (any NSCoding & NSCopying & NSObjectProtocol)? { get }

    /// The delegate of the file manager object.
    var delegate: (any FileManagerDelegate)? { get set }

    /// The path to the program’s current directory.
    var currentDirectoryPath: String { get }

    // MARK: - Locating FileProtocol in System Directories

    /// Locates and optionally creates the specified common directory in a domain.
    func file(
        for sysdir: FileManager.SearchPathDirectory,
        in domain: FileManager.SearchPathDomainMask,
        directory: String?,
        file: String,
        create: Bool
    ) throws -> FileProtocol

    // MARK: - Locating System Directories

    /// Locates and optionally creates the specified common directory in a domain.
    func url(
        for: FileManager.SearchPathDirectory,
        in: FileManager.SearchPathDomainMask,
        appropriateFor: URL?,
        create: Bool
    ) throws -> URL

    /// Returns an array of URLs for the specified common directory in the requested domains.
    func urls(
        for: FileManager.SearchPathDirectory,
        in: FileManager.SearchPathDomainMask
    ) -> [URL]

    // MARK: - Locating Application Group Container Directories

    /// Returns the container directory associated with the specified security application group identifier.
    func containerURL(forSecurityApplicationGroupIdentifier: String) -> URL?

    // MARK: - Discovering Directory Contents

    /// Performs a shallow search of the specified directory and returns URLs for the contained items.
    func contentsOfDirectory(
        at: URL,
        includingPropertiesForKeys: [URLResourceKey]?,
        options: DirectoryEnumerationOptions
    ) throws -> [URL]

    /// Performs a shallow search of the specified directory and returns the paths of any contained items.
    func contentsOfDirectory(atPath: String) throws -> [String]

    /// Returns a directory enumerator object that can be used to perform a deep enumeration of the
    /// directory at the specified URL.
    func enumerator(
        at: URL,
        includingPropertiesForKeys: [URLResourceKey]?,
        options: DirectoryEnumerationOptions,
        errorHandler: ((URL, any Error) -> Bool)?
    ) -> DirectoryEnumerator?

    /// Returns a directory enumerator object that can be used to perform a deep enumeration of the
    /// directory at the specified path.
    func enumerator(atPath: String) -> DirectoryEnumerator?

    /// Returns an array of URLs that identify the mounted volumes available on the device.
    func mountedVolumeURLs(
        includingResourceValuesForKeys: [URLResourceKey]?,
        options: VolumeEnumerationOptions
    ) -> [URL]?

    /// Performs a deep enumeration of the specified directory and returns the paths of all of the
    /// contained subdirectories.
    func subpathsOfDirectory(atPath: String) throws -> [String]

    /// Returns an array of strings identifying the paths for all items in the specified directory.
    func subpaths(atPath: String) -> [String]?

    // MARK: - Creating and Deleting Items
    /// Creates a directory with the given attributes at the specified URL.
    func createDirectory(at: URL, withIntermediateDirectories: Bool, attributes: [FileAttributeKey: Any]?) throws

    /// Creates a directory with given attributes at the specified path.
    func createDirectory(atPath: String, withIntermediateDirectories: Bool, attributes: [FileAttributeKey: Any]?) throws

    /// Creates a file with the specified content and attributes at the given location.
    func createFile(atPath: String, contents: Data?, attributes: [FileAttributeKey: Any]?) -> Bool

    /// Removes the file or directory at the specified URL.
    func removeItem(at: URL) throws

    /// Removes the file or directory at the specified path.
    func removeItem(atPath: String) throws

    /// Moves an item to the trash.
    func trashItem(at: URL, resultingItemURL: AutoreleasingUnsafeMutablePointer<NSURL?>?) throws
    // swiftlint:disable:previous legacy_objc_type

    // MARK: - Replacing Items

    /// Replaces the contents of the item at the specified URL in a manner that ensures no data loss occurs.
    func replaceItemAt(
        _ at: URL,
        withItemAt: URL,
        backupItemName: String?,
        options: FileManager.ItemReplacementOptions
    ) throws -> URL?

    /// Replaces the contents of the item at the specified URL in a manner that ensures no data loss occurs.
    func replaceItem(
        at: URL,
        withItemAt: URL,
        backupItemName: String?,
        options: FileManager.ItemReplacementOptions,
        // swiftlint:disable:next legacy_objc_type
        resultingItemURL: AutoreleasingUnsafeMutablePointer<NSURL?>?
    ) throws

    // MARK: - Moving and Copying Items

    /// Copies the file at the specified URL to a new location synchronously.
    func copyItem(at: URL, to: URL) throws

    /// Copies the item at the specified path to a new location synchronously.
    func copyItem(atPath: String, toPath: String) throws

    /// Moves the file or directory at the specified URL to a new location synchronously.
    func moveItem(at: URL, to: URL) throws

    /// Moves the file or directory at the specified path to a new location synchronously.
    func moveItem(atPath: String, toPath: String) throws

    // MARK: - Managing iCloud-Based Items

    /// Returns the URL for the iCloud container associated with the specified identifier and establishes
    /// access to that container.
    func url(forUbiquityContainerIdentifier: String?) -> URL?

    /// Returns a Boolean indicating whether the item is targeted for storage in iCloud.
    func isUbiquitousItem(at: URL) -> Bool

    /// Indicates whether the item at the specified URL should be stored in iCloud.
    func setUbiquitous(_ ubiquitous: Bool, itemAt: URL, destinationURL: URL) throws

    /// Starts downloading (if necessary) the specified item to the local system.
    func startDownloadingUbiquitousItem(at: URL) throws

    /// Removes the local copy of the specified item that’s stored in iCloud.
    func evictUbiquitousItem(at: URL) throws

    /// Returns a URL that can be emailed to users to allow them to download a copy of a flat file item from iCloud.
    func url(forPublishingUbiquitousItemAt: URL, expiration: AutoreleasingUnsafeMutablePointer<NSDate?>?) throws -> URL
    // swiftlint:disable:previous legacy_objc_type

    // MARK: - Accessing File Provider Services

//    // Returns the services provided by the File Provider extension that manages the item at the given URL.
//    func getFileProviderServicesForItem(
//        at: URL,
//        completionHandler: @escaping @Sendable (
//            [NSFileProviderServiceName: NSFileProviderService]?,
//            (any Error)?
//        ) -> Void
//    )

    // MARK: - Creating Symbolic and Hard Links
    /// Creates a symbolic link at the specified URL that points to an item at the given URL.
    func createSymbolicLink(at: URL, withDestinationURL: URL) throws

    /// Creates a symbolic link that points to the specified destination.
    func createSymbolicLink(atPath: String, withDestinationPath: String) throws

    /// Creates a hard link between the items at the specified URLs.
    func linkItem(at: URL, to: URL) throws

    /// Creates a hard link between the items at the specified paths.
    func linkItem(atPath: String, toPath: String) throws

    /// Returns the path of the item pointed to by a symbolic link.
    func destinationOfSymbolicLink(atPath: String) throws -> String

    // MARK: - Determining Access to Files
    /// Returns a Boolean value that indicates whether a file or directory exists at a specified path.
    func fileExists(atPath: String) -> Bool

    /// Returns a Boolean value that indicates whether a file or directory exists at a specified path.
    func fileExists(atPath: String, isDirectory: UnsafeMutablePointer<ObjCBool>?) -> Bool

    /// Returns a Boolean value that indicates whether the invoking object appears able to read a specified file.
    func isReadableFile(atPath: String) -> Bool

    /// Returns a Boolean value that indicates whether the invoking object appears able to write to a specified file.
    func isWritableFile(atPath: String) -> Bool

    /// Returns a Boolean value that indicates whether the operating system appears able to execute a specified file.
    func isExecutableFile(atPath: String) -> Bool

    /// Returns a Boolean value that indicates whether the invoking object appears able to delete a specified file.
    func isDeletableFile(atPath: String) -> Bool

    // MARK: - Getting and Setting Attributes

    /// Returns an array of strings representing the user-visible components of a given path.
    func componentsToDisplay(forPath: String) -> [String]?

    /// Returns the display name of the file or directory at a specified path.
    func displayName(atPath: String) -> String

    /// Returns the attributes of the item at a given path.
    func attributesOfItem(atPath: String) throws -> [FileAttributeKey: Any]

    /// Returns a dictionary that describes the attributes of the mounted file system on which a given path resides.
    func attributesOfFileSystem(forPath: String) throws -> [FileAttributeKey: Any]

    /// Sets the attributes of the specified file or directory.
    func setAttributes(_ attributes: [FileAttributeKey: Any], ofItemAtPath: String) throws

    // MARK: - Getting and Comparing File Contents

    /// Returns the contents of the file at the specified path.
    func contents(atPath: String) -> Data?

    /// Returns a Boolean value that indicates whether the files or directories in specified paths have the
    /// same contents.
    func contentsEqual(atPath: String, andPath: String) -> Bool

    // MARK: - Getting the Relationship Between Items

    /// Determines the type of relationship that exists between a directory and an item.
    func getRelationship(
        _ relationship: UnsafeMutablePointer<FileManager.URLRelationship>,
        ofDirectoryAt: URL,
        toItemAt: URL
    ) throws

    /// Determines the type of relationship that exists between a system directory and the specified item.
    func getRelationship(
        _ relationship: UnsafeMutablePointer<FileManager.URLRelationship>,
        of: FileManager.SearchPathDirectory,
        in: FileManager.SearchPathDomainMask,
        toItemAt: URL
    ) throws

    // MARK: - Converting File Paths to Strings

    /// Returns a C-string representation of a given path that properly encodes Unicode strings for use
    /// by the file system.
    func fileSystemRepresentation(withPath: String) -> UnsafePointer<CChar>

    /// Returns an NSString object whose contents are derived from the specified C-string path.
    func string(withFileSystemRepresentation: UnsafePointer<CChar>, length: Int) -> String

    // MARK: - Managing the Current Directory

    /// Changes the path of the current working directory to the specified path.
    func changeCurrentDirectoryPath(_ path: String) -> Bool
}

public extension FileManagerProtocol {
    // MARK: - Locating FileProtocol in System Directories

    /// Locates and optionally creates the specified common directory in a domain.
    func file(
        for sysdir: FileManager.SearchPathDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        // swiftlint:disable:next function_default_parameter_at_end
        directory: String? = nil,
        file: String,
        create: Bool
    ) throws -> FileProtocol {
        var url = try url(
            for: sysdir,
            in: domain,
            appropriateFor: nil,
            create: create
        )

        if let directory {
            url.appendPathComponent(directory)

            if create {
                try createDirectory(
                    at: url,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            }
        }

        url.appendPathComponent(file)

        return File(path: url)
    }
}

extension FileManager: FileManagerProtocol {}
