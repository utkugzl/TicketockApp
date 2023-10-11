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
    public func registerUser(with user: RegisterUserModal, completion: @escaping (Result<Void, Error>) -> Void) {
        let username = user.username
        let email = user.email
        let password = user.password

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let resultUser = result?.user else {
                completion(.failure(NSError(domain: "Firebase", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                return
            }

            let db = Firestore.firestore()

            db.collection("users").document(resultUser.uid).setData([
                "username": username,
                "email": email
            ]) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                completion(.success(()))
            }
        }
    }
    
    
    /// A method to sign in the user
    /// - Parameters:
    ///   - user: The users information (emali,password)
    ///   - completion: A completion with one values...
    ///   ///   Error: An error if the firebase provides one
    public func signIn(with user: LoginUserModal, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    
    /// A method to sign out the current user
    /// - Parameter completion:
    /// ///    Error: An error if the firebase provides one
    public func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    
    /// A method to resert user password
    /// - Parameters:
    ///   - email: User email
    ///   - completion: A completion with one values...
    ///   ///   Error: An error if the firebase provides one
    public func forgotPassword(with email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    
    public func fetchUser(completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "UserNotFound", code: 404, userInfo: nil)))
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userUID).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                completion(.failure(NSError(domain: "SnapshotNotFound", code: 404, userInfo: nil)))
                return
            }
            
            guard let data = snapshot.data() else {
                completion(.failure(NSError(domain: "DataNotFound", code: 404, userInfo: nil)))
                return
            }
            
            let username = data["username"] as? String ?? "No username"
            let email = data["email"] as? String ?? "No email"
            
            let user = UserModel(username: username, email: email, userUID: userUID)
            
            completion(.success(user))
        }
    }
    
    
    func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            goToController(LoginViewController())
        } else {
            goToController(MainTabBarViewController())
        }
    }
    
    private func goToController(_ viewController: UIViewController) {
        var window: UIWindow?
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    let sceneWindow = sceneDelegate.window
                    window = sceneWindow
                    window?.layer.opacity = 0
                }
                
            } completion: { _ in
                var newRootViewController: UIViewController?
                if let tabBarController = viewController as? UITabBarController {
                    newRootViewController = tabBarController
                } else {
                    newRootViewController = UINavigationController(rootViewController: viewController)
                    (newRootViewController as? UINavigationController)?.modalPresentationStyle = .fullScreen
                }
                
                window?.rootViewController = newRootViewController
                
                UIView.animate(withDuration: 0.25) {
                    window?.layer.opacity = 1
                }
            }
        }
    }
    
}
