//
//  User.swift
//  DOT
//
//  Created by Martin Nava on 08/03/24.
//

import Foundation

struct RequestBody: Codable {
    let email: String
}

class DotUser: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var registrationCode: String = ""
    
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
    
    public func reset() {
        name = ""
        email = ""
        password = ""
        confirmPassword = ""
        registrationCode = ""
        errorMessage = ""
    }
    
    public func requestCode(completion: @escaping (Bool, String) -> Void) {
        AppStatus.shared.isProcessing = true
        
        if(isValidEmail()) {
            let urlString = Constants.Endpoints.AutService.DOMAIN + Constants.Endpoints.AutService.REQUEST_CODE
            guard let url = URL(string: urlString) else {
                completion(false, "Invalid URL")
                return
            }
            
            let requestBody = RequestBody(email: self.email)
            do {
                let requestJson = try JSONEncoder().encode(requestBody)
                
                RestService.post(url: url, body: requestJson) { statusCode, errorMessage, data in
                    if let errorMessage = errorMessage {
                        completion(false, errorMessage)
                        return
                    }
                    
                    guard let data = data, let message = data["message"] as? String else {
                        completion(false, "Error inesperado. Intenta nuevamente.")
                        return
                    }
                    
                    completion(true, message)
                }
            } catch {
                completion(false, "Unable to parse request data.")
                return
            }
        } else {
            completion(false, self.errorMessage)
        }
    }
    
    public func register(completion: @escaping (Bool, String) -> Void) {
        AppStatus.shared.isProcessing = true
        
        if(validateUser(isNewUser: true)) {
            completion(true, "Cuenta creada. Revisa tu correo para activarla y regresa a la pantalla de inicio para iniciar sesión.")
        } else {
            completion(false, errorMessage)
        }
    }
    
    public func resetPassword(completion: @escaping (Bool, String) -> Void) {
        AppStatus.shared.isProcessing = true
        
        if(isValidEmail()) {
            AuthService.resetPassword(email: email)
            completion(true, "Hemos enviado un correo a \(email) para que puedas recuperar tu contraseña.")
        } else {
            completion(false, errorMessage)
        }
    }
    
    //Functions to validate user data
    private func validateUser(isNewUser: Bool) -> Bool {
        self.errorMessage = ""
        
        if(!validateMandatoryFields(isNewUser: isNewUser)) {
            self.errorMessage = "Todos los campos son obligatorios."
            return false
        } else if(!isNewUser && !isValidEmail()) {
            self.errorMessage = "El email no es válido."
            return false
        } else if(isNewUser && !passwordsMatch()) {
            self.errorMessage = "Los passwords no son iguales."
            return false
        }
        
        return true
    }
    
    private func validateMandatoryFields(isNewUser: Bool) -> Bool {
        var result = !self.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        if(isNewUser) {
            result = result && !self.registrationCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !self.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !self.confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        } else {
            result = result && !self.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
                
        return result
    }
    
    private func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let result = emailPred.evaluate(with: self.email)
        
        if(!result) {
            self.errorMessage = "El email no es válido."
        }
        
        return result
    }
    
    private func passwordsMatch() -> Bool {
        return self.password == self.confirmPassword
    }
}
