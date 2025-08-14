//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Foundation

/// A builder model for creating URLs
public typealias URLBuilder = URLComponents

public extension URLBuilder {
    /// helper for builder pattern functions
    private func mutate(_ body: (inout Self) -> Void) -> Self {
        var mutable = self
        body(&mutable)
        return mutable
    }

    /// builder pattern to set the `scheme` of a ``URLBuilder``
    /// - parameter scheme: scheme to assign
    /// - returns a new, modified, `URLBuilder`
    func scheme(_ scheme: String) -> Self {
        mutate { components in
            components.scheme = scheme
        }
    }

    /// builder pattern to set the `host` of a ``URLBuilder``
    /// - parameter host: host to assign
    /// - returns a new, modified, `URLBuilder`
    func host(_ host: String) -> Self {
        mutate { components in
            components.host = host
        }
    }

    /// builder pattern to set the `port` of a ``URLBuilder``
    /// - parameter port: port to assign
    /// - returns a new, modified, `URLBuilder`
    func port(_ port: Int?) -> Self {
        mutate { components in
            components.port = port
        }
    }

    /// builder pattern to set the `user` of a ``URLBuilder``
    /// - parameter user: user to assign
    /// - returns a new, modified, `URLBuilder`
    func user(_ user: String) -> Self {
        mutate { components in
            components.user = user
        }
    }

    /// builder pattern to set the `password` of a ``URLBuilder``
    /// - parameter password: password to assign
    /// - returns a new, modified, `URLBuilder`
    func password(_ password: String) -> Self {
        mutate { components in
            components.password = password
        }
    }

    /// builder pattern to set the `path` of a ``URLBuilder``
    /// - parameter path: path to assign
    /// - returns a new, modified, `URLBuilder`
    func path(_ path: String) -> Self {
        mutate { components in
            components.path = path.hasPrefix("/") ? path : ("/" + path)
        }
    }

    /// builder pattern to append to the `path` of a ``URLBuilder``
    /// - parameter path: path to append
    /// - returns a new, modified, `URLBuilder`
    mutating func append(path additionalPath: String) {
        let first = path.hasSuffix("/") ? String(path.dropLast()) : path
        let second = additionalPath.hasPrefix("/") ? String(additionalPath.dropFirst()) : additionalPath

        self.path = first + "/" + second
    }

    /// builder pattern to append to the path of a ``URLBuilder``
    /// - parameter elements: path elements to append, appended elements
    /// will be separated by the standard path separator "/".
    /// - returns a new, modified, `URLBuilder`
    mutating func append(elements: String...) {
        append(path: elements.joined(separator: "/"))
    }

    /// builder pattern to append to the path of a ``URLBuilder``
    /// - parameter elements: path elements to append, appended elements
    /// will be separated by the standard path separator "/".
    /// - returns a new, modified, `URLBuilder`
    mutating func append(elements: [String]) {
        append(path: elements.joined(separator: "/"))
    }

    /// builder pattern to append to the `path` of a ``URLBuilder``
    /// - parameter path: path to append
    /// - returns a new, modified, `URLBuilder`
    func appending(path: String) -> Self {
        mutate { components in
            components.append(path: path)
        }
    }

    /// builder pattern to append to the path of a ``URLBuilder``
    /// - parameter elements: path elements to append, appended elements
    /// will be separated by the standard path separator "/".
    /// - returns a new, modified, `URLBuilder`
    func appending(elements: String...) -> Self {
        appending(path: elements.joined(separator: "/"))
    }

    /// builder pattern to append to the path of a ``URLBuilder``
    /// - parameter elements: path elements to append, appended elements
    /// will be separated by the standard path separator "/".
    /// - returns a new, modified, `URLBuilder`
    func appending(elements: [String]) -> Self {
        appending(path: elements.joined(separator: "/"))
    }

    /// builder pattern to append a query to a ``URLBuilder``
    /// - parameter query: query to assign
    /// - parameter value: value to assign to query, if not nil no value will be associated
    /// with the query
    /// - returns a new, modified, `URLBuilder`
    mutating func append(query: String, value: String? = nil) {
        queryItems = (queryItems ?? []) + [URLQueryItem(name: query, value: value)]
    }

    /// builder pattern to append a query to a ``URLBuilder``
    /// - parameter query: query to assign
    /// - parameter value: value to assign to query, if not nil no value will be associated
    /// with the query
    /// - returns a new, modified, `URLBuilder`
    func appending(query: String, value: String? = nil) -> Self {
        mutate { components in
            components.append(query: query, value: value)
        }
    }

    /// builder pattern to set the `query` of a ``URLBuilder``
    /// - parameter queries: query to assign
    /// - returns a new, modified, `URLBuilder`
    func query(_ queries: (String, String?)...) -> Self {
        mutate { components in
            components.queryItems = (components.queryItems ?? [])
            + queries.map { key, value in URLQueryItem(name: key, value: value) }
        }
    }

    /// builder pattern to set the `fragment` of a ``URLBuilder``
    /// - parameter fragment: fragment to assign
    /// - returns a new, modified, `URLBuilder`
    func fragment(_ fragment: String?) -> Self {
        mutate { components in
            components.fragment = fragment
        }
    }
}

public extension URL {
    /// Create a builder (``URLBuilder``) from the target URL
    var builder: URLBuilder? {
        URLBuilder(url: self, resolvingAgainstBaseURL: true)
    }
}
