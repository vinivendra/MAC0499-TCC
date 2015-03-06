//
//  JSContextExtension.swift
//  Project
//
//  Created by Vinicius Vendramini on 06/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import JavaScriptCore


var JSContextInstance = JSContext()


extension JSContext {
    
    class func sharedContext() -> JSContext {
        return JSContextInstance
    }
    
}
