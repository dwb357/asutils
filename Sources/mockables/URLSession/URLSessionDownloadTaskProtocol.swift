//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

// swiftlint:disable missing_docs

/// Mockable `URLSessionDownloadTask`
@Mockable
public protocol URLSessionDownloadTaskProtocol {
    // MARK: - URLSessionTaskProtocol

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

    // MARK: - Methods

    func cancel(byProducingResumeData: @escaping @Sendable (Data?) -> Void)

    // MARK: - URLSessionTask

    func cancel()

    func suspend()

    func resume()
}

extension URLSessionDownloadTask: URLSessionDownloadTaskProtocol {}

// swiftlint:enable missing_docs
