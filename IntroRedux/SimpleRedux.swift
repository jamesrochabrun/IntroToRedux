//
//  SimpleRedux.swift
//  IntroRedux
//
//  Created by James Rochabrun on 1/12/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.

import Foundation

/// 1 We’ve stubbed out protocols for Action and State. Neither have any requirements.
protocol Action {}
protocol State {}

/// 2 We’ve defined our Reducer as a pure function that receives an action and the old state, and returns the new state.
typealias Reducer = (_ action: Action, _ state: State?) -> State

/// 3 We’ve defined a StoreSubscriber protocol for our view controllers to use to receive updates when state has changed.
protocol StoreSubscriber {
    func newState(state: State)
}

/// 4 We’ve created a Store class that sits at the center of this whole thing. When we use it to dispatch our actions, it will use our pure reducer function to create the new state object, replacing the old one and notifying subscribers.
class Store {
    
    let reducer : Reducer
    var state: State?
    var subscribers: [StoreSubscriber] = []
    
    init(reducer: @escaping Reducer, state: State?) {
        self.reducer = reducer
        self.state = state
    }
    
    func dispatch(action: Action) {
        state = reducer(action, state)
        subscribers.forEach { $0.newState(state: state!) }
    }
    
    func subscribe(_ newSubscriber: StoreSubscriber) {
        subscribers.append(newSubscriber)
    }
}
    













