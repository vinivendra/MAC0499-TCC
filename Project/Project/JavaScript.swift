

import Foundation
import JavaScriptCore


let defaultFilename = "main.js"


class JavaScript {
    
    let context = JSContext.sharedContext()
    
    var script : String
    
    var loadFunction : JSValue?
    var updateFunction : JSValue?
    
    
    init (fileName: String?) {
        
        if fileName != nil &&
           fileName != "" {
            
            script = FileHelper.openTextFile(defaultFilename)
        }
        else {
            script = FileHelper.openTextFile(fileName!)
        }
        
        setup()
    }

    
    convenience init () {
        self.init(fileName: defaultFilename)
    }

    
    func setup() {
        
        let jsPrint: @objc_block AnyObject -> Void = { input in
            println(input)
        }
        
        context.setObject(unsafeBitCast(jsPrint, AnyObject.self), forKeyedSubscript: "print")
        context.setObject(console.self,                           forKeyedSubscript: "console")
    }
    
    
    func load() {
        
        context.evaluateScript(script)
        
        updateFunction = context.objectForKeyedSubscript("update")

        loadFunction   = context.objectForKeyedSubscript("load")
    }

    
    func update(dt : Double) {
    
        updateFunction?.callWithArguments([dt])
    }
    
}




@objc protocol consoleExports : JSExport {
    class func log(object : AnyObject);
}

@objc class console : NSObject, consoleExports {
    
    class func log(object : AnyObject) {
        println(object)
    }
}
