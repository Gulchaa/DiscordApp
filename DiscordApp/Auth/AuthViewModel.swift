//
//  Untitled.swift
//  DiscordApp
//
//  Created by Gulchin Ibragimli on 03.11.24.
//
import SwiftUI


@Observable
final class AuthViewModel {
    var signInEmail: String = ""
    var signInPassword: String = ""
    
    var registerEmail = ""
    var registerPassword = ""
    var registerUsername = ""
    var registerDisplayName = ""
    var registerDOB = Date.now
    func logIn(){
        Task{
            do{
                try await AuthService.shared.signIn(email: signInEmail, password: signInPassword)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func createAccount(){
        Task{
            do{
                try await AuthService.shared.registerNewUserWithEmail(email: registerEmail, password: registerPassword)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
}

extension EnvironmentValues{
    var authViewModel: AuthViewModel{
        //self[AuthViewModelKey.self] means "for this instance of EnvironmentValues, look up the value associated with AuthViewModelKey as a key."
        get{self[AuthViewModelKey.self]}
        set{self[AuthViewModelKey.self] = newValue}
    }
}

private struct AuthViewModelKey: EnvironmentKey {
    static let defaultValue: AuthViewModel = AuthViewModel()
}
