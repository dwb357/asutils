//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

@Mockable
public protocol URLSessionProtocol {

    typealias DataTaskPublisher = URLSession.DataTaskPublisher

    // MARK: - Properties

    var delegate: URLSessionDelegate? { get }

    var delegateQueue: OperationQueue { get }

    var configuration: URLSessionConfiguration { get }

    var sessionDescription: String? { get }

    // MARK: - Asynchronous Transfers

    func bytes(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (URLSession.AsyncBytes, URLResponse)

    func bytes(
        from url: URL,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (URLSession.AsyncBytes, URLResponse)

    func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)

    func data(
        from url: URL,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)

    func download(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (URL, URLResponse)

    func download(
        from url: URL,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (URL, URLResponse)

    func upload(
        for request: URLRequest,
        from: Data, delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)

    func upload(
        for request: URLRequest,
        fromFile file: URL,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)

    // MARK: - Adding data tasks to a session

    func dataTask(with request: URLRequest) -> URLSessionDataTaskProtocol

    func dataTask(
        with request: URLRequest,
        completionHandler handler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol

    func dataTask(with url: URL) -> URLSessionDataTaskProtocol

    func dataTask(
        with url: URL,
        completionHandler handler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol

    // MARK: - Adding download tasks to a session

    func downloadTask(with url: URL) -> URLSessionDownloadTaskProtocol

    func downloadTask(
        with url: URL,
        completionHandler handler: @escaping @Sendable (URL?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionDownloadTaskProtocol

    func downloadTask(
        with request: URLRequest
    ) -> URLSessionDownloadTaskProtocol

    func downloadTask(
        with: URLRequest,
        completionHandler: @escaping @Sendable (URL?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionDownloadTaskProtocol

    func downloadTask(withResumeData: Data) -> URLSessionDownloadTaskProtocol

    func downloadTask(
        withResumeData: Data,
        completionHandler handler: @escaping @Sendable (URL?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionDownloadTaskProtocol

    // MARK: - Adding upload tasks to a session

    func uploadTask(with request: URLRequest, from data: Data) -> URLSessionUploadTaskProtocol

    func uploadTask(
        with request: URLRequest,
        from data: Data?,
        completionHandler handler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionUploadTaskProtocol

    func uploadTask(
        with request: URLRequest,
        fromFile file: URL
    ) -> URLSessionUploadTaskProtocol

    func uploadTask(
        with request: URLRequest,
        fromFile file: URL,
        completionHandler handler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionUploadTaskProtocol

    func uploadTask(withStreamedRequest request: URLRequest) -> URLSessionUploadTaskProtocol

    // MARK: - Adding stream tasks to a session

    func streamTask(withHostName hostName: String, port: Int) -> URLSessionStreamTaskProtocol

    // MARK: - Managing the session

    func finishTasksAndInvalidate()

    func flush(completionHandler handler: @escaping @Sendable () -> Void)

    func getTasksWithCompletionHandler(
        _ handler: @escaping @Sendable (
            [URLSessionDataTask],
            [URLSessionUploadTask],
            [URLSessionDownloadTask]
        ) -> Void
    )

    func getAllTasks(
        completionHandler handler: @escaping @Sendable ([URLSessionTask]) -> Void
    )

    func invalidateAndCancel()

    func reset(completionHandler handler: @escaping @Sendable () -> Void)

    // MARK: - Performing tasks as a Combine Publisher

    func dataTaskPublisher(for request: URLRequest) -> DataTaskPublisher

    func dataTaskPublisher(for url: URL) -> DataTaskPublisher
}

extension URLSession: URLSessionProtocol {

    // MARK: - Adding data tasks to a session

    public func dataTask(
        with request: URLRequest,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }

    public func dataTask(with request: URLRequest) -> any URLSessionDataTaskProtocol {
        dataTask(with: request) as URLSessionDataTask
    }

    public func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionDataTaskProtocol {
        dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }

    public func dataTask(with url: URL) -> any URLSessionDataTaskProtocol {
        dataTask(with: url) as URLSessionDataTask
    }

    // MARK: - Adding download tasks to a session

    public func downloadTask(with url: URL) -> URLSessionDownloadTaskProtocol {
        downloadTask(with: url) as URLSessionDownloadTask
    }

    public func downloadTask(
        with url: URL,
        completionHandler handler: @escaping @Sendable (URL?, URLResponse?, (any Error)?) -> Void
    ) -> any URLSessionDownloadTaskProtocol {
        downloadTask(with: url, completionHandler: handler) as URLSessionDownloadTask
    }

    public func downloadTask(with request: URLRequest) -> any URLSessionDownloadTaskProtocol {
        downloadTask(with: request) as URLSessionDownloadTask
    }

    public func downloadTask(
        with request: URLRequest,
        completionHandler handler: @escaping @Sendable (URL?, URLResponse?, (any Error)?) -> Void
    ) -> any URLSessionDownloadTaskProtocol {
        downloadTask(
            with: request,
            completionHandler: handler
        ) as URLSessionDownloadTask
    }

    public func downloadTask(withResumeData data: Data) -> any URLSessionDownloadTaskProtocol {
        downloadTask(withResumeData: data) as URLSessionDownloadTask
    }

    public func downloadTask(
        withResumeData data: Data,
        completionHandler handler: @escaping @Sendable (URL?, URLResponse?, (any Error)?) -> Void
    ) -> any URLSessionDownloadTaskProtocol {
        downloadTask(
            withResumeData: data,
            completionHandler: handler
        ) as URLSessionDownloadTask
    }

    // MARK: - Adding upload tasks to a session

    public func uploadTask(with request: URLRequest, from data: Data) -> URLSessionUploadTaskProtocol {
        uploadTask(with: request, from: data) as URLSessionUploadTask
    }

    public func uploadTask(
        with request: URLRequest,
        from data: Data?,
        completionHandler handler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionUploadTaskProtocol {
        uploadTask(
            with: request,
            from: data,
            completionHandler: handler
        ) as URLSessionUploadTask
    }

    public func uploadTask(
        with request: URLRequest,
        fromFile file: URL
    ) -> any URLSessionUploadTaskProtocol {
        uploadTask(with: request, fromFile: file) as URLSessionUploadTask
    }

    public func uploadTask(
        with request: URLRequest,
        fromFile file: URL,
        completionHandler handler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionUploadTaskProtocol {
        uploadTask(
            with: request,
            fromFile: file,
            completionHandler: handler
        ) as URLSessionUploadTask
    }

    public func uploadTask(
        withStreamedRequest request: URLRequest
    ) -> URLSessionUploadTaskProtocol {
        uploadTask(withStreamedRequest: request) as URLSessionUploadTask
    }

    // MARK: - Adding stream tasks to a session

    public func streamTask(
        withHostName hostName: String,
        port: Int
    ) -> URLSessionStreamTaskProtocol {
        streamTask(withHostName: hostName, port: port) as URLSessionStreamTask
    }

    // MARK: - Adding WebSocket tasks to a session

    public func webSocketTask(with url: URL) -> URLSessionWebSocketTaskProtocol {
        webSocketTask(with: url) as URLSessionWebSocketTask
    }

    public func webSocketTask(
        with url: URL,
        protocols: [String]
    ) -> URLSessionWebSocketTaskProtocol {
        webSocketTask(with: url, protocols: protocols) as URLSessionWebSocketTask
    }
}
