//
//  URLComponentsExt.swift
//  ASUtils-Core
//
//  © Copyright 2024 David W. Berry. All Rights Reserved.
//

import Foundation

public extension URLComponents {
    private func mutate(_ body: (inout Self) -> Void) -> Self {
        var mutable = self
        body(&mutable)
        return mutable
    }

    func scheme(_ scheme: String) -> Self {
        mutate { components in
            components.scheme = scheme
        }
    }

    func host(_ host: String) -> Self {
        mutate { components in
            components.host = host
        }
    }

    func port(_ port: Int?) -> Self {
        mutate { components in
            components.port = port
        }
    }

    func user(_ user: String) -> Self {
        mutate { components in
            components.user = user
        }
    }

    func password(_ password: String) -> Self {
        mutate { components in
            components.password = password
        }
    }

    func path(_ path: String) -> Self {
        mutate { components in
            components.path = path.hasPrefix("/") ? path : ("/" + path)
        }
    }

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

    func append(elements: String...) -> Self {
        append(
            path: elements.joined(separator: "/")
        )
    }

    func append(query: String, value: String? = nil) -> Self {
        mutate { components in
            components.queryItems = (components.queryItems ?? [])
                + [URLQueryItem(name: query, value: value)]
        }
    }

    func queries(_ queries: (String, String?)...) -> Self {
        mutate { components in
            components.queryItems = (components.queryItems ?? [])
            + queries.map { (key, value) in URLQueryItem(name: key, value: value) }
        }
    }

    func fragment(_ fragment: String?) -> Self {
        mutate { components in
            components.fragment = fragment
        }
    }
}

public extension URL {
    var builder: URLComponents? {
        URLComponents(url: self, resolvingAgainstBaseURL: true)
    }
}
