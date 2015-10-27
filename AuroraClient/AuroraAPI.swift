//
//  AuroraAPI.swift
//  AuroraClient
//
//  Created by Joseph Smith on 9/24/15.
//  Copyright © 2015 bjoli.com. All rights reserved.
//

import Foundation
import thrift

/**
 * Helper to connect to the scheduler
 */
class AuroraAPI {
    var schedulerPort = 2223
    var schedulerHostname = "localhost"

    func getJobs() {
        let schedulerURL = NSURL(string: "http://\(schedulerHostname):\(schedulerPort)/api")
        let session = NSURLSession.sharedSession()

        if let url = schedulerURL {
            let thriftClientFactory = THTTPSessionTransportFactory.init(session: session, URL: url)
            let thriftProtocol = TBinaryProtocolFactory.sharedFactory().newProtocolOnTransport(thriftClientFactory.newTransport())
            let client = ReadOnlySchedulerClient(inoutProtocol: thriftProtocol)
            do {
                let roleResponse = try client.getRoleSummary()
                print(roleResponse)
            } catch let error as TTransportError {
                print("Transport Error: \(error)")
            } catch let error as TProtocolError {
                print("Protocol Error: \(error)")
            } catch let error as TProtocolExtendedError {
                print("Protocol Extended Error: \(error)")
            } catch let error as NSError {
                print("DOH!: \(error)")
            }
        } else {
            print("Error: Bad Scheduler URI: \(schedulerHostname):\(schedulerPort)")
        }
    }

    func handleSchedulerResponse(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void {
        if let schedulerData = data {
            let output = NSString(data: schedulerData, encoding: NSUTF8StringEncoding)
            print("\(output)")
        } else if let schedulerError = error {
            print("\(schedulerError)")
        } else {
            print("Something crazy happened talking to the scheduler. No data, but no error.")
        }
    }
}