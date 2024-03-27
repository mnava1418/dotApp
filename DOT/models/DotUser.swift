//
//  User.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import Foundation

class DotUser: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    //Validation
    private var errorMessage: String = ""
        
    public func login(completion: @escaping(Bool, String?) -> Void) {
        AppStatus.shared.isProcessing = true
        
        if(validateUser(isNewUser: false)) {
            AuthService.signIn(email: email, password: password) { result in
                completion(result, nil)
            }
        } else {
            completion(false, self.errorMessage)
        }
    }
    
    public func register(completion: @escaping (Bool, String) -> Void) {
        AppStatus.shared.isProcessing = true
        
        if(validateUser(isNewUser: true)) {
            AuthService.createUser(email: self.email, password: self.password, name: self.name) { (user, error) in
                if let error = error {
                    completion(false, error.localizedDescription)
                    return
                }
                
                if let user = user {
                    user.sendEmailVerification()
                }
                
                completion(true, "Cuenta creada. Revisa tu correo para activarla e inicia sesión.")
            }
        } else {
            completion(false, errorMessage)
        }
    }
    
    public func resetPassword() {
        print("Reset Password")
    }
    
    //Functions to validate user data
    private func validateUser(isNewUser: Bool) -> Bool {
        self.errorMessage = ""
        
        if(!validateMandatoryFields(isNewUser: isNewUser)) {
            self.errorMessage = "Todos los campos son obligatorios."
            return false
        } else if(!isValidEmail()) {
            self.errorMessage = "El email no es válido."
            return false
        } else if(isNewUser && !passwordsMatch()) {
            self.errorMessage = "Los passwords no son iguales."
            return false
        }
        
        return true
    }
    
    private func validateMandatoryFields(isNewUser: Bool) -> Bool {
        var result = !self.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !self.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        if(isNewUser) {
            result = result && !self.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !self.confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
                
        return result
    }
    
    private func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let result = emailPred.evaluate(with: self.email)
        
        if(!result) {
            self.errorMessage = "Todos los campos son obligatorios."
        }
        
        return result
    }
    
    private func passwordsMatch() -> Bool {
        return self.password == self.confirmPassword
    }
}
