//
//  NetworkPathMonitor.swift
//  PokeApi Innowise
//
//  Created by Anna Zaitsava on 20.02.24.
//

import Network

enum NetworkStatus {
    case connected
    case notConnected
}

class NetworkPathMonitor {
    static let shared = NetworkPathMonitor()
    
    private let monitor: NWPathMonitor
    private var networkStatus: NetworkStatus = .notConnected
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.networkStatus = (path.status == .satisfied) ? .connected : .notConnected
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func getCurrentNetworkStatus() -> NetworkStatus {
        return networkStatus
    }
}

