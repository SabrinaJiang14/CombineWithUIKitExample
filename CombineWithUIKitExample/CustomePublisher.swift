//
//  CustomePublisher.swift
//  CombineWithUIKitExample
//
//  Created by sabrina on 2020/11/18.
//

import UIKit
import Combine
/**
 To create a working stream we need three things
 1. Publisher 發布者
 2. Subscriber 訂閱者
 3. Subscription 訂閱者與發布者之間的協議
 */

// Publisher
final class CustomPublisher<C: UIControl> : Publisher {
    typealias Output = C
    typealias Failure = Never
    
    private let control:C
    private let event:C.Event
    init(control:C, event:C.Event) {
        self.control = control
        self.event = event
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, CustomPublisher.Failure == S.Failure, CustomPublisher.Output == S.Input {
        let subscription = CustomSubscription(subscriber: subscriber, control: control, event: event)
        subscriber.receive(subscription: subscription)
    }
}


final class CustomSubscription<C:UIControl, S:Subscriber>:Subscription where S.Input == C {
    
    private var subscriber:S?
    private let control:C
    init(subscriber:S, control:C, event:C.Event) {
        self.subscriber = subscriber
        self.control = control
        
        self.control.addTarget(self, action: #selector(eventHandler), for: event)
    }
    
    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        subscriber = nil
    }
    
    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
    
    deinit {
        self.control.removeTarget(self, action: nil, for: .allEvents)
    }
}


protocol CombineCompatible { }
extension UIControl:CombineCompatible { }
extension CombineCompatible where Self:UIControl {
    func controlEvent(for event:UIControl.Event) -> CustomPublisher<Self> {
        return .init(control: self, event: event)
    }
}
