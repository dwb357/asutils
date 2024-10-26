//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

public extension URLComponents {
    /// helper for builder pattern functions
    private func mutate(_ body: (inout Self) -> Void) -> Self {
        var mutable = self
        body(&mutable)
        return mutable
    }

    /// builder pattern to set the `scheme` of a ``URLComponents``
    /// - parameter scheme: scheme to assign
    /// - returns a new, modified, `URLComponents`
    func scheme(_ scheme: String) -> Self {
        mutate { components in
            components.scheme = scheme
        }
    }

    /// builder pattern to set the `host` of a ``URLComponents``
    /// - parameter host: host to assign
    /// - returns a new, modified, `URLComponents`
    func host(_ host: String) -> Self {
        mutate { components in
            components.host = host
        }
    }

    /// builder pattern to set the `port` of a ``URLComponents``
    /// - parameter port: port to assign
    /// - returns a new, modified, `URLComponents`
    func port(_ port: Int?) -> Self {
        mutate { components in
            components.port = port
        }
    }

    /// builder pattern to set the `user` of a ``URLComponents``
    /// - parameter user: user to assign
    /// - returns a new, modified, `URLComponents`
    func user(_ user: String) -> Self {
        mutate { components in
            components.user = user
        }
    }

    /// builder pattern to set the `password` of a ``URLComponents``
    /// - parameter password: password to assign
    /// - returns a new, modified, `URLComponents`
    func password(_ password: String) -> Self {
        mutate { components in
            components.password = password
        }
    }

    /// builder pattern to set the `path` of a ``URLComponents``
    /// - parameter path: path to assign
    /// - returns a new, modified, `URLComponents`
    func path(_ path: String) -> Self {
        mutate { components in
            components.path = path.hasPrefix("/") ? path : ("/" + path)
        }
    }

    /// builder pattern to append to the `path` of a ``URLComponents``
    /// - parameter path: path to append
    /// - returns a new, modified, `URLComponents`
    func append(path: String) -> Self {
        mutate { components in
            let first = components.path.hasSuffix("/")
                ? components.path
                : (components.path + "/")
            let second = path.hasPrefix("/")
                ? String(path[path.index(after: path.startIndex)..<path.endIndex])
                : path

            components.path = first + second
        }
    }

    /// builder pattern to append to the path of a ``URLComponents``
    /// - parameter elements: path elements to append, appended elements
    /// will be separated by the standard path separator "/".
    /// - returns a new, modified, `URLComponents`
    func append(elements: String...) -> Self {
        append(
            path: elements.joined(separator: "/")
        )
    }

    /// builder pattern to append a query to a ``URLComponents``
    /// - parameter query: query to assign
    /// - parameter value: value to assign to query, if not nil no value will be associated
    /// with the query
    /// - returns a new, modified, `URLComponents`
    func append(query: String, value: String? = nil) -> Self {
        mutate { components in
            components.queryItems = (components.queryItems ?? [])
                + [URLQueryItem(name: query, value: value)]
        }
    }

    /// builder pattern to set the `query` of a ``URLComponents``
    /// - parameter query: query to assign
    /// - returns a new, modified, `URLComponents`
    func query(_ queries: (String, String?)...) -> Self {
        mutate { components in
            components.queryItems = (components.queryItems ?? [])
            + queries.map { key, value in URLQueryItem(name: key, value: value) }
        }
    }

    /// builder pattern to set the `fragment` of a ``URLComponents``
    /// - parameter fragment: fragment to assign
    /// - returns a new, modified, `URLComponents`
    func fragment(_ fragment: String?) -> Self {
        mutate { components in
            components.fragment = fragment
        }
    }
}

public extension URL {
    /// Create a builder (``URLComponents``) from the target URL
    var builder: URLComponents? {
        URLComponents(url: self, resolvingAgainstBaseURL: true)
    }
}
