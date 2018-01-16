//
//  ViewController.swift
//  IntroRedux
//
//  Created by James Rochabrun on 1/12/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// DEFINING THE STORE
    lazy var store: Store = {
        return Store(reducer: self.appReducer, state: nil)
    }()
    
    /// DEFINIGN THE STATE
    struct AppState: State {
        var counter: Int = 0
    }
    
    /// DEFINING THE ACTIONS
    struct IncreaseAction: Action {
        let increaseBy: Int
    }
    
    struct DecreaseAction: Action {
        let decreaseBy: Int
    }
    
    /// DEFINING THE REDUCER
    /// the reducer is just a function that takes an action and an state and returns a new state
    private func appReducer(_ action: Action, _ state: State?) -> State {
        var newState = state as? AppState ?? AppState()
        switch action {
        case let action as IncreaseAction:
            newState.counter += action.increaseBy
        case let action as DecreaseAction:
            newState.counter -= action.decreaseBy
        default:
            break
        }
        return newState
    }
    
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.subscribe(self)
    }
    
    @IBAction func increment(_ sender: UIButton) {
        store.dispatch(action: IncreaseAction(increaseBy: 1))
    }
    
    @IBAction func decrease(_ sender: UIButton) {
        store.dispatch(action: DecreaseAction(decreaseBy: 1))
    }
}

extension ViewController: StoreSubscriber {
    
    func newState(state: State) {
        counterLabel.text = "\((state as? AppState)?.counter ?? 0)"
    }
}












