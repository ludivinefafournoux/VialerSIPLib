//
//  Message.swift
//  LibExample
//
//  Created by Manuel on 08/10/2019.
//  Copyright © 2019 Harold. All rights reserved.
//


enum Message {
    
    case feature(Feature)
    enum Feature {
        case userHandling(UserHandling)
        case settings(Settings)
        case calling(Calling)
        
        enum UserHandling {
            case useCase(UseCase)
            
            enum UseCase {
                case login(LogIn)
                case logout(LogOut)
                
                enum LogIn {
                    case action(Action)
                    
                    enum Action {
                        case logIn(String, String) // logIn(username, password)
                        case logInConfirmed(User)
                    }
                }
                
                enum LogOut {
                    case action(Action)
                    
                    enum Action {
                        case logOut(User)
                        case logOutConfirmed(User)
                    }
                }
            }
        }
        
        enum Settings {
            case useCase(UseCase)
            
            enum UseCase {
                case transport(Transport)
                case register(Register)
                case unregister(Unregister)
            }
            
            enum Transport {
                case action(Action)
                
                enum Action {
                    case activate(TransportOption)
                    case didActivate(TransportOption)
                }
            }
            
            enum Register{}
            enum Unregister{}
        }
        
        enum Calling {
            case useCase(UseCase)
            
            enum UseCase {
                case call(Calling)
                
                enum Calling {
                    case action(Action)
                    
                    enum Action {
                        case start(String)
                        case dialing(Call)
                        case callDidStart(Call)
                        case callFailed(Call)
                        case stop(Call)
                        case callDidStop(Call)
                    }
                }
            }
        }
    }
}

extension Message.Feature.Calling.UseCase.Calling.Action: Equatable {
    
    static func == (
        lhs: Message.Feature.Calling.UseCase.Calling.Action,
        rhs: Message.Feature.Calling.UseCase.Calling.Action
    ) -> Bool
    {
        func compare<T:Equatable>(_ lhs:T, _ rhs:T) -> Bool { lhs == rhs }
        
        switch (lhs, rhs) {
        case (       .start(let   lhsNo),        .start(let   rhsNo)) : return compare(  lhsNo,   rhsNo)
        case (     .dialing(let lhsCall),      .dialing(let rhsCall)) : return compare(lhsCall, rhsCall)
        case (.callDidStart(let lhsCall), .callDidStart(let rhsCall)) : return compare(lhsCall, rhsCall)
        case (        .stop(let lhsCall),         .stop(let rhsCall)) : return compare(lhsCall, rhsCall)
        case ( .callDidStop(let lhsCall),  .callDidStop(let rhsCall)) : return compare(lhsCall, rhsCall)
        case (  .callFailed(let lhsCall),   .callFailed(let rhsCall)) : return compare(lhsCall, rhsCall)
        case (		  .start, _) : return false
        case (		.dialing, _) : return false
        case ( .callDidStart, _) : return false
        case (         .stop, _) : return false
        case (  .callDidStop, _) : return false
        case (   .callFailed, _) : return false
        }
    }
}