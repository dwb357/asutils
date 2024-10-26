//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

@Mockable
public protocol URLSessionWebSocketTaskProtocol {

    typealias Message = URLSessionWebSocketTask.Message

    typealias CloseCode = URLSessionWebSocketTask.CloseCode

    var maximumMessageSize: Int { get set }

    var closeCode: CloseCode { get }

    var closeReason: Data? { get }

    // MARK: - Sending and receiving data

    func send(
        _ message: Message,
        completionHandler: @escaping @Sendable ((any Error)?) -> Void
    )

    func send(_ message: Message) async throws

    func receive(
        completionHandler handler: @escaping @Sendable (Result<Message, any Error>) -> Void
    )

    func receive() async throws -> Message

    // MARK: - Sending ping frames

    func sendPing(pongReceiveHandler handler: @escaping @Sendable ((any Error)?) -> Void)

    // MARK: - Closing the connection

    func cancel(with: CloseCode, reason: Data?)

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

    func cancel()

    func suspend()

    func resume()
}

extension URLSessionWebSocketTask: URLSessionWebSocketTaskProtocol {}
