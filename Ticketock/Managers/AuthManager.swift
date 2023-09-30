//
//  AuthManager.swift
//  Ticketock
//
//  Created by Utku Güzel on 30.09.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthManager {
    public static let shared = AuthManager()
    
    private init() {}
    
    
    /// A method to register the user
    /// - Parameters:
    ///   - user: The users information (emali,password,username)
    ///   - completion: A completion with two values...
    ///   Bool: wasRegistered - Determines if the user was registered and saved in the database correctly
    ///   Error?: An error optianol error if the firebase provides one
    public func registerUser(with user: RegisterUserModal, completion: @escaping (Bool,Error?) -> Void) {
        let username = user.username
        let email = user.email
        let password = user.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false,error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false,nil)
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("users").document(resultUser.uid).setData([
                "username": username,
                "email": email
            ]) { error in
                if let error = error {
                    completion(false,error)
                    return
                }
                
                completion(true,nil)
            }
        }
    }
    
    
    /// A method to sign in the user
    /// - Parameters:
    ///   - user: The users information (emali,password)
    ///   - completion: A completion with one values...
    ///   ///   Error?: An error optianol error if the firebase provides one
    public func signIn(with user: LoginUserModal, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    
    /// A method to sign out the user
    /// - Parameters:
    ///   - completion: A completion with one values...
    ///   ///   Error?: An error optianol error if the firebase provides one
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
