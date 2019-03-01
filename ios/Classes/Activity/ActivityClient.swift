//
//  ActivityClient.swift
//  activity_recognition
//
//  Created by Daniel Morawetz on 02.08.18.
//

import Foundation
import CoreMotion

class ActivityClient {
    
    private let activityManager = CMMotionActivityManager()
    private var activityUpdatesCallback: ActivityUpdatesCallback? = nil
    
    private var isPaused = true
    
    public func resume() {
        guard isPaused else {
            return
        }
     
        if CMMotionActivityManager.isActivityAvailable() {
               NSLog("ABCXYZ isActivityAvailable")
        activityManager.startActivityUpdates(to: OperationQueue.init(), withHandler:  OnActivity);
            
        } else {
            NSLog("ABCXYZ isActivityAvailable NOT")
            
        }
        
        isPaused = false
    }
    
    public func derp(){
        
    }
    public func OnActivity( activity: Optional<CMMotionActivity>) {
      
            NSLog("ABCXYZ ActivityChannel got an activity. %@",activity.debugDescription)
        self.activityUpdatesCallback?(Result<Activity>.success(with: Activity(from:activity!)))
       
    }
    public func pause() {
        guard !isPaused else {
            return
        }
        
        activityManager.stopActivityUpdates()
        
        isPaused = true
    }
    
    public func registerActivityUpdates(callback: @escaping ActivityUpdatesCallback) {
        activityUpdatesCallback = callback
    }
    
    public func deregisterActivityUpdatesCallback() {
        activityUpdatesCallback = nil
    }
    
    typealias ActivityUpdatesCallback = (Result<Activity>) -> Void
}
