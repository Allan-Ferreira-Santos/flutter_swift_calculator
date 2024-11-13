import Flutter
import UIKit

@UIApplicationMain

@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let calculadoraChannel = FlutterMethodChannel(name: "calculadora", binaryMessenger: controller.binaryMessenger)
        
        calculadoraChannel.setMethodCallHandler { (call, result) in
            if call.method == "calcular" {
                guard let args = call.arguments as? [String: Any],
                      let numero1 = args["numero1"] as? Int,
                      let numero2 = args["numero2"] as? Int,
                      let operador = args["operador"] as? String else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Argumentos inválidos", details: nil))
                    return
                }
                
                let res = self.calcular(numero1: numero1, numero2: numero2, operador: operador)
                result(res)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func calcular(numero1: Int, numero2: Int, operador: String) -> Int {
        switch operador {
        case "+":
            return numero1 + numero2
        case "-":
            return numero1 - numero2
        case "*":
            return numero1 * numero2
        case "/":
            return numero2 != 0 ? numero1 / numero2 : 0
        default:
            return 0
        }
    }
}
