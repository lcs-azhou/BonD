//
//  LandingView.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-05-24.
//

import SwiftUI
import Supabase

// 主视图，包含应用程序的各个部分
struct LandingView: View {
    @Binding var hasChosenLogin: Bool  // 用户是否选择登录的状态绑定
    var author: String  // 作者名称
    
    @StateObject var viewModel: TimerViewModel  // 计时器视图模型的状态对象

    // 初始化方法
    init(hasChosenLogin: Binding<Bool>, author: String, supabaseClient: SupabaseClient) {
        self._hasChosenLogin = hasChosenLogin
        self.author = author
        // 初始化计时器视图模型
        self._viewModel = StateObject(wrappedValue: TimerViewModel(supabaseClient: supabaseClient, taskId: 1))
    }

    var body: some View {
        // 标签视图，包含四个子视图，每个子视图代表应用程序的一个部分
        TabView {
            // 待办事项视图
            TodoListView(viewModel: TodoListViewModel(supabaseClient: supabaseClient))
                .tabItem {
                    Label("Todos", systemImage: "checklist")
                }

            // 共享相册视图
            SharedAlbum()
                .tabItem {
                    Label("Album", systemImage: "person.2.crop.square.stack")
                }

            // 活动视图
            ActivitiesView(author: author)
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }

            // 消息视图
            MessageView(viewModel: MessagesViewModel(chatRoomId: 0))
                .tabItem {
                    Label("Message", systemImage: "ellipsis.message")
                }
        }
        .accentColor(.green)  // 设置标签视图的强调颜色
    }
}

// 预览代码
#Preview {
    LandingView(hasChosenLogin: .constant(false), author: "John Doe", supabaseClient: supabaseClient)
}
