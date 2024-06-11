//
//  LoginView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-07.
//

import SwiftUI
import _PhotosUI_SwiftUI
import Supabase

struct LoginView: View {
    @Binding var haschosenlogin: Bool
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @StateObject private var viewModel = SharedAlbumViewModel()
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            Button(action: {
                        isImagePickerPresented = true
                    }) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .shadow(radius: 5)
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())

                                .shadow(radius: 5)
                               
                        }
                    }
                    .padding(.bottom, 20)
                    .sheet(isPresented: $isImagePickerPresented) {
                        PhotosPicker("Select Photo", selection: $viewModel.selectionResult, matching: .images)
                
                TextField("First Name", text: $firstName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                TextField("Last Name", text: $lastName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(.emailAddress)
                
                Button(action: {
                    print("First Name: \(firstName), Last Name: \(lastName), Email: \(email)")
                    loginUser()
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
                .padding(.top, 20)
                .onTapGesture {
                    haschosenlogin = true
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func loginUser() {
        Task {
            do {
                let newUser = [
                    "name_first": firstName,
                    "name_last": lastName,
                    "email": email
                ]
                
                let response = try await supabaseClient
                    .from("patron")
                    .insert([newUser])
                    .execute()
                
                print("User inserted: \(response)")
                haschosenlogin = true
            } catch {
                print("Error inserting user: \(error)")
            }
        }
    }
}

#Preview {
    LoginView(haschosenlogin: .constant(false))
}
