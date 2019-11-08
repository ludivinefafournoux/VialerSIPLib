//
//  SettingsFeatureSpec.swift
//  LibExampleTests
//
//  Created by Manuel on 14/10/2019.
//  Copyright © 2019 Harold. All rights reserved.
//

import Quick
import Nimble
@testable import LibExample

class SettingsFeatureSpec: QuickSpec {
    override func spec() {
        describe("the SettingsFeature UseCase") {
            var sut: SettingsFeature!
            var messageHandler: Mock.MessageHandler!
            var receivedModes: [TransportMode]!

            beforeEach {
                receivedModes = []
                messageHandler = Mock.MessageHandler { if case .feature(.settings(.useCase(.transport(.action(.didActivate(let m)))))) = $0 { receivedModes.append(m)}}
                sut = SettingsFeature(with: messageHandler, dependencies: self.dependencies)
            }
            
            afterEach {
                receivedModes = nil
                messageHandler = nil
                sut = nil
            }
            
            it("switches transport modes") {
                [.udp, .tcp, .tls, .udp].forEach {
                    sut.handle(feature: .settings(.useCase(.transport(.action(.activate($0))))))
                }
                
                expect(receivedModes) == [.udp, .tcp, .tls, .udp]
            }
        }
    }
    
    var dependencies: Dependencies {
        Dependencies(
            currentAppStateFetcher: Mock.CurrentAppStateFetcher(),
                       callStarter: Mock.CallStarter(),
                    statePersister: Mock.StatePersister()
        )
    }
}