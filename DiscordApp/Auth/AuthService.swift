import Foundation
import Supabase

enum Secrets{
    static let supabaseURL = "https://myjkofmfdcgutruzirfh.supabase.co"
    static let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15amtvZm1mZGNndXRydXppcmZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE0MzI2MjIsImV4cCI6MjA0NzAwODYyMn0.nbjAbxcss6f96ct5CkzVnLkGS5ZvqCyC6mhRqgHQ1kw"
}

@Observable
final class AuthService {
    
    static let shared = AuthService()
    
    private let client = SupabaseClient(supabaseURL: URL(string: "https://xyzcompany.supabase.co")!, supabaseKey: "public-anon-key")

    private let auth = SupabaseClient(supabaseURL: URL(string:Secrets.supabaseURL)!, supabaseKey: Secrets.supabaseKey).auth

    var currentUser: DiscordUser?
    
    private init() {
        Task {
            do{
                let session = try await auth.session
                
                guard let email = session.user.email, email.isEmpty else {
                    return
                }
                try await fetchCurrentUser(id: session.user.id, email: email)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCurrentUser(id: UUID, email: String) async throws{
        if let user = DatabaseService.shared.fetchUserFromStoredInfo(), id == user.id
        {
            currentUser = user
        }
        else{
            currentUser = try await DatabaseService.shared.fetchUserFromDatabase(email: email)
        }
    }
    
    @MainActor
    func registerNewUserWithEmail(user: DiscordUser, password: String) async throws {
        let response = try await auth.signUp(email: user.email, password: password)
        var updatedUser = user
        updatedUser.id = response.session?.user.id
        
        try await DatabaseService.shared.createUserInDatabase(updatedUser)
        DatabaseService.shared.storeUserInfoOnDevice(user: updatedUser)
        currentUser = updatedUser
    }
    
    @MainActor
    func signIn(email: String, password: String) async throws {
        let session = try await auth.signIn(email: email, password: password)
    
        try await fetchCurrentUser(id: session.user.id, email: email )
        
    }
    
    func signOut() async throws {
        try await auth.signOut()
        currentUser = nil
    }
}

struct DiscordUser: Codable, Identifiable, Equatable {
    var id:UUID?
    let createdAt:Date
    let username: String
    let displayName: String
    let email: String
    var imageURL: String
    let dob: Date
    var servers: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case username = "username"
        case displayName = "display_name"
        case email = "email"
        case imageURL = "image_url"
        case dob = "dob"
        case servers = "servers"
        
    }
}

enum Table{
    static let users = "users"
}

@Observable
final class DatabaseService {
    
    static let shared = DatabaseService()
    
    private let database = SupabaseClient(supabaseURL: URL(string:Secrets.supabaseURL)!, supabaseKey: Secrets.supabaseKey).database
    
    private init(){
        }
    
    @discardableResult
    func createUserInDatabase(_ user: DiscordUser) async throws -> DiscordUser{
        let user: DiscordUser = try await database.from(Table.users).insert(user, returning: .representation).execute().value
        return user
    }
    
    func fetchUserFromDatabase(email: String) async throws -> DiscordUser{
        let user: DiscordUser = try await database
            .from(Table.users)
            .select()
            .equals("email", value: email)
            .single()
            .execute()
            .value
        
        return user
    }
    
    func storeUserInfoOnDevice(user: DiscordUser){
        UserDefaults.standard.setValue(user.id?.uuidString, forKey: "id")
        UserDefaults.standard.setValue(user.createdAt, forKey: "createdAt")
        UserDefaults.standard.setValue(user.username, forKey: "username")
        UserDefaults.standard.setValue(user.displayName, forKey: "displayName")
        UserDefaults.standard.setValue(user.email, forKey: "email")
        UserDefaults.standard.setValue(user.imageURL, forKey: "imageURL")
        UserDefaults.standard.setValue(user.dob, forKey: "dob")
        UserDefaults.standard.setValue(user.servers, forKey: "servers")
    }
    
    func fetchUserFromStoredInfo()-> DiscordUser?{
        if let idString = UserDefaults.standard.string(forKey: "id"),
           let id = UUID(uuidString: idString),
           let createdAt = UserDefaults.standard.object(forKey: "createdAt") as? Date,
           let username = UserDefaults.standard.string(forKey: "username"),
           let displayName = UserDefaults.standard.string(forKey: "displayName"),
           let email = UserDefaults.standard.string(forKey: "email"),
           let imageURL = UserDefaults.standard.string(forKey: "imageURL"),
           let dob = UserDefaults.standard.object(forKey: "dob") as? Date,
           let servers = UserDefaults.standard.array(forKey: "servers") as? [Int] {
            
            let user = DiscordUser(id: id, createdAt: createdAt, username: username, displayName: displayName, email: email, imageURL: imageURL, dob: dob, servers: servers)
            return user
        }else{
            return nil
        }
    }
    
    func resetDevicestorage(){
        UserDefaults.standard.setValue(nil, forKey: "id")
        UserDefaults.standard.setValue(nil, forKey: "createdAt")
        UserDefaults.standard.setValue(nil, forKey: "username")
        UserDefaults.standard.setValue(nil, forKey: "displayName")
        UserDefaults.standard.setValue(nil, forKey: "email")
        UserDefaults.standard.setValue(nil, forKey: "imageURL")
        UserDefaults.standard.setValue(nil, forKey: "dob")
        UserDefaults.standard.setValue(nil, forKey: "servers")
    }
}




