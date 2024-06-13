import SwiftUI
import PhotosUI

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
    @AppStorage("haschosenlogin") private var appHasChosenLogin = false // 使用 @AppStorage 存储登录状态
    @AppStorage("author") private var author: String = "" // 存储用户名称
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
                PhotosPicker(selection: $viewModel.selectionResult, matching: .images) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.green.opacity(0.3))
                            .cornerRadius(8)
                            .frame(height: 45)
                            .padding(130)
                        Text("Select Photo")
                            .accentColor(.green)
                    }
                }
            }.accentColor(.green)
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func loginUser() {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty {
            alertMessage = "Please fill all fields."
            showAlert = true
        } else {
            // 假设登录成功，保存用户信息并跳转到 LandingView
            author = "\(firstName) \(lastName)"
            appHasChosenLogin = true
        }
    }
}

#Preview {
    LoginView()
}
