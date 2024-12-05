import Foundation
import Supabase

enum Secrets{
    static let supabaseURL = "https://myjkofmfdcgutruzirfh.supabase.co"
    static let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15amtvZm1mZGNndXRydXppcmZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE0MzI2MjIsImV4cCI6MjA0NzAwODYyMn0.nbjAbxcss6f96ct5CkzVnLkGS5ZvqCyC6mhRqgHQ1kw"
}

@Observable
final class AuthService {
    
    static let shared = AuthService()
    
    private let auth = SupabaseClient(supabaseURL: URL(string:Secrets.supabaseURL)!, supabaseKey: Secrets.supabaseKey).auth

    var currentUser: Supabase.Session?
    
    private init() {
        Task {
            do{
                currentUser = try await auth.session
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
    func registerNewUserWithEmail(email: String, password: String) async throws {
        let response = try await auth.signUp(email: email, password: password)
        currentUser = response.session
    }
    
    func signIn(email: String, password: String) async throws {
        let session = try await auth.signIn(email: email, password: password)
        currentUser = session
    }
    
    func signOut() async throws {
        try await auth.signOut()
        currentUser = nil
    }
}
