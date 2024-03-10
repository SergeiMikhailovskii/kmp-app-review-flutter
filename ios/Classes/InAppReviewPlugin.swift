import Flutter
import UIKit
import inAppReviewKMP

public class InAppReviewPlugin: NSObject, FlutterPlugin {
    
    private var reviewManager: InAppReviewDelegate? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "in_app_review", binaryMessenger: registrar.messenger())
        let instance = InAppReviewPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "launchInAppReview":
            let params = (call.arguments as! [String: Any])["ios"] as! [String: Any]
            let appStoreId = params["appStoreId"] as! String
            reviewManager = AppStoreInAppReviewManager(params: AppStoreInAppReviewInitParams(appStoreId: appStoreId))
            reviewManager?.requestInAppReview().collect(collector: InAppReviewCollector(result: result)) {_ in }
        case "launchInMarketReview":
            let params = (call.arguments as! [String: Any])["ios"] as! [String: Any]
            let appStoreId = params["appStoreId"] as! String
            reviewManager = AppStoreInAppReviewManager(params: AppStoreInAppReviewInitParams(appStoreId: appStoreId))
            reviewManager?.requestInMarketReview().collect(collector: InAppReviewCollector(result: result)) {_ in }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

private class InAppReviewCollector : Kotlinx_coroutines_coreFlowCollector {
    let result: FlutterResult
    
    init(result: @escaping FlutterResult) {
        self.result = result
    }
    
    func emit(value: Any?, completionHandler: @escaping (Error?) -> Void) {
        if let reviewCode = value as? ReviewCode {
            result(reviewCode.name)
        }
    }
}
