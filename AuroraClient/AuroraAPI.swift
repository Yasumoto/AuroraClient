//
//  AuroraAPI.swift
//  AuroraClient
//
//  Created by Joseph Smith on 9/24/15.
//  Copyright © 2015 bjoli.com. All rights reserved.
//

import Foundation

/**
 * Helper to connect to the scheduler
 */
class Aurora {
    var schedulerPort = 2223
    var schedulerHostname = "localhost"

    func getJobs() {
        let schedulerURL = NSURL(string: "http://\(schedulerHostname):\(schedulerPort)")
        let scheduler = ReadOnlySchedulerClient()
        //scheduler.
        if let url = schedulerURL {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: handleSchedulerResponse)
            task.resume()
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