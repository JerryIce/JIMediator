

public class JIMediatorManager {
    
    public static let shared = JIMediatorManager()

    // Make sure the class has only one instance
    // Should not init outside
    private init() {}

    // Optional
    func reset() {
        // Reset all properties to default value
    }
    
    
    //MARK: - Request类型
    //这里根据需求可以不断增加新的功能入口模块
    
    //MARK:登录注册/退出登录
    //手动登录入口
    lazy var presentLogin = JIPresentLogin()
    
    // 自动登录
    lazy var autoLogin = JIAutoLogin()
    
    // 退出登录
    lazy var logout = JILogout()
    
}

