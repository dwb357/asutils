//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

// swiftlint:disable missing_docs

@Mockable
public protocol URLSessionStreamTaskProtocol {
    // MARK: - URLSessionTask properties

    // These properties are duplicated here from URLSessionProtocol
    // to allow proper mocking using Mockable.

    var taskIdentifier: Int { get }

    var originalRequest: URLRequest? { get }

    var currentRequest: URLRequest? { get }

    var response: URLResponse? { get }

    @available(iOS 15.0, macOS 12.0, *)
    var delegate: URLSessionTaskDelegate? { get set }

    @available(iOS 11.0, macOS 10.13, *)
    var progress: Progress { get }

    @available(iOS 11.0, macOS 10.13, *)
    var earliestBeginDate: Date? { get }

    @available(iOS 11.0, macOS 10.13, *)
    var countOfBytesClientExpectsToSend: Int64 { get }

    @available(iOS 11.0, macOS 10.13, *)
    var countOfBytesClientExpectsToReceive: Int64 { get }

    var countOfBytesExpectedToReceive: Int64 { get }

    var countOfBytesExpectedToSend: Int64 { get }

    var countOfBytesReceived: Int64 { get }

    var countOfBytesSent: Int64 { get }

    var taskDescription: String? { get set }

    var state: URLSessionTask.State { get }

    var error: Error? { get }

    var priority: Float { get set }

    var prefersIncrementalDelivery: Bool { get set }

    // MARK: - Reading and writing data

    func readData(
        ofMinLength min: Int,
        maxLength max: Int,
        timeout: TimeInterval,
        completionHandler handler: @escaping @Sendable (Data?, Bool, (any Error)?) -> Void
    )

    func write(
        _ data: Data,
        timeout: TimeInterval,
        completionHandler handler: @escaping @Sendable ((any Error)?) -> Void
    )

    // MARK: - Capturing streams

    func captureStreams()

    // MARK: - Closing read and write sockets

    func closeRead()

    func closeWrite()

    // MARK: - Starting and stopping secure connections

    func startSecureConnection()

    // MARK: - URLSessionTask

    func cancel()

    func suspend()

    func resume()
}

extension URLSessionStreamTask: URLSessionStreamTaskProtocol {}

// swiftlint:enable missing_docs
