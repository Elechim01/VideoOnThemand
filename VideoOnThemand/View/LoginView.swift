//
//  LoginView.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 09/08/22.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var getCheck: Bool{
        if(email.isEmpty){
            loginViewModel.errorMessage = "Il campo email è vuoto"
            return false
        }
        if(!loginViewModel.isValidEmail(email)){
            loginViewModel.errorMessage = "l'email non è valida"
            return false
        }
        if(password.isEmpty){
            loginViewModel.errorMessage = "Il campo password è vuoto"
            return false
        }
        
        if(!loginViewModel.isValidPassword(testStr: password)){
            loginViewModel.errorMessage = "la password non è valida, deve comprendere: Almeno una maiuscola, Almeno un numero, Almeno una minuscola, 8 caratteri in totale"
            return false
        }
        return true
        
    }
    
    
    @EnvironmentObject var loginViewModel : LoginViewModel
    
    
    var body: some View {
        VStack{
            Text("Benvenuto in app.")
                .font(.title)
                .padding()
            
            Text("Effettua l' accesso per visionare i video")
                .padding()
            
            TextField("email", text: $email)
//            AUMANTARE LA GRANDEZZA DEL TESTO
                .font(.title3)
                .foregroundColor(.white)
                .padding()
            
            SecureField("password", text: $password)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
            
            Button {
                if(getCheck){
//                    Login
                    loginViewModel.login(email: email, password: password)
                }else{
                    loginViewModel.showError = true
                }
                
            } label: {
                Text("Login")
            }
            .padding()
            
            
            Spacer()

        }
        .background(Color.blue.opacity(0.8).ignoresSafeArea())
        .alert(loginViewModel.errorMessage, isPresented: $loginViewModel.showError, actions: {
            Button(action: {loginViewModel.showError = false}, label: {Text("OK")})
        })
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
