//
// Copyright © 2025, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

@Mockable
protocol UserDefaultsProtocol {
    // MARK: - Getting Default Values

    /// Returns the object associated with the specified key.
    func object(forKey: String) -> Any?

    /// Returns the URL associated with the specified key.
    func url(forKey: String) -> URL?

    /// Returns the array associated with the specified key.
    func array(forKey: String) -> [Any]?

    /// Returns the dictionary object associated with the specified key.
    func dictionary(forKey: String) -> [String : Any]?

    /// Returns the string associated with the specified key.
    func string(forKey: String) -> String?

    /// Returns the array of strings associated with the specified key.
    func stringArray(forKey: String) -> [String]?

    /// Returns the data object associated with the specified key.
    func data(forKey: String) -> Data?

    /// Returns the Boolean value associated with the specified key.
    func bool(forKey: String) -> Bool

    /// Returns the integer value associated with the specified key.
    func integer(forKey: String) -> Int

    /// Returns the float value associated with the specified key.
    func float(forKey: String) -> Float

    /// Returns the double value associated with the specified key.
    func double(forKey: String) -> Double

    /// Returns a dictionary that contains a union of all key-value pairs in the domains in the search list.
    func dictionaryRepresentation() -> [String : Any]

    // MARK: - Setting Default Values

    /// Sets the value of the specified default key.
    func set(_: Any?, forKey: String)

    /// Sets the value of the specified default key to the specified float value.
    func set(_: Float, forKey: String)

    /// Sets the value of the specified default key to the double value.
    func set(_: Double, forKey: String)

    /// Sets the value of the specified default key to the specified integer value.
    func set(_: Int, forKey: String)

    /// Sets the value of the specified default key to the specified Boolean value.
    func set(_: Bool, forKey: String)

    /// Sets the value of the specified default key to the specified URL.
    func set(_: URL?, forKey: String)

    // MARK: - Removing Defaults

    /// Removes the value of the specified default key.
    func removeObject(forKey: String)

    // MARK: - Maintaining Suites

    /// Inserts the specified domain name into the receiver’s search list.
    func addSuite(named: String)

    /// Removes the specified domain name from the receiver’s search list.
    func removeSuite(named: String)

    // MARK: - Registering Defaults

    /// Adds the contents of the specified dictionary to the registration domain.
    func register(defaults: [String : Any])

    // MARK: - Maintaining Persistent Domains
    /// Returns a dictionary representation of the defaults for the specified domain.
    func persistentDomain(forName: String) -> [String : Any]?

    /// Sets a dictionary for the specified persistent domain.
    func setPersistentDomain(_: [String : Any], forName: String)

    /// Removes the contents of the specified persistent domain from the user’s defaults.
    func removePersistentDomain(forName: String)

    // MARK: - Maintaining Volatile Domains

    /// The current volatile domain names.
    var volatileDomainNames: [String] { get }

    /// Returns the dictionary for the specified volatile domain.
    func volatileDomain(forName: String) -> [String : Any]

    /// Sets the dictionary for the specified volatile domain.
    func setVolatileDomain(_: [String : Any], forName: String)

    /// Removes the specified volatile domain from the user’s defaults.
    func removeVolatileDomain(forName: String)

    // MARK: - Accessing Managed Environment Keys

    /// Returns a Boolean value indicating whether the specified key is managed by an administrator.
    func objectIsForced(forKey: String) -> Bool

    /// Returns a Boolean value indicating whether the key in the specified domain is managed by an administrator.
    func objectIsForced(forKey: String, inDomain: String) -> Bool
}

extension UserDefaults: UserDefaultsProtocol {}
