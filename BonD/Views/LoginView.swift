//
//  LoginView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-07.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct LoginView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var haschosenlogin = false
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var chatRoomCode: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
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
                
                TextField("Chat Room Code (Optional)", text: $chatRoomCode)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Button(action: {
                    if chatRoomCode.isEmpty {
                        createChatRoom()
                    } else {
                        joinChatRoom()
                    }
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
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func createChatRoom() {
        Task {
            do {
                let code = UUID().uuidString.prefix(6).lowercased()
                let _ = try await supabaseClient
                    .from("ChatRoom")
                    .insert(["code": code])
                    .execute()
                
                let newPatron = Patron(id: 0, name_first: firstName, name_last: lastName, email: email, profile_image_url: nil)
                let _ = try await supabaseClient
                    .from("patron")
                    .insert(newPatron)
                    .execute()
                
                alertMessage = "Chat room created with code: \(code)"
                showAlert = true
            } catch {
                alertMessage = "Error creating chat room: \(error)"
                showAlert = true
            }
        }
    }
    
    private func joinChatRoom() {
        Task {
            do {
                let response: [ChatRoom] = try await supabaseClient
                    .from("ChatRoom")
                    .select()
                    .eq("code", value: chatRoomCode)
                    .execute()
                    .value
                
                if response.isEmpty {
                    alertMessage = "Chat room code not found."
                } else {
                    let newPatron = Patron(id: 0, name_first: firstName, name_last: lastName, email: email, profile_image_url: nil)
                    let _ = try await supabaseClient
                        .from("patron")
                        .insert(newPatron)
                        .execute()
                    
                    alertMessage = "Joined chat room with code: \(chatRoomCode)"
                }
                showAlert = true
            } catch {
                alertMessage = "Error joining chat room: \(error)"
                showAlert = true
            }
        }
    }
}

#Preview {
    LoginView()
}
