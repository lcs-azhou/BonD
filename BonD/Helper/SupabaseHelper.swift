//
//  SupabaseHelper.swift
//  BonD
//
//  Created by Ansheng Zhou on 2024-06-07.
//

import Foundation
import Supabase

// 全局 Supabase 客户端实例
let supabaseClient = SupabaseClient(supabaseURL: URL(string: "https://ufdspngngqcypdbcorde.supabase.co")!,
                                    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVmZHNwbmduZ3FjeXBkYmNvcmRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc1MDcyMDAsImV4cCI6MjAzMzA4MzIwMH0.st1h6u9RPDqKGCyJ9Ccvt54lBbrNUWRok8-SO3WvgM8")

//explainations for each swift document: Foundation is a core framework that provides basic system services, including string processing, data management, date and time calculations, sorting and filtering. 'let supabaseClient' is a constant that defines the global Supabase client instance. Constants are immutable after declaration. 'URL(string:)' is the initialization method of the URL class for converting strings to URL objects. '!' is a forced unpacking operator that tells the compiler that the URL object must not be nil. use it only if you are sure the URL is formatted correctly.
