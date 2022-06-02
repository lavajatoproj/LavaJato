//
//  OpenURL.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 01/06/22.
//

import Foundation
import SafariServices

final class Safari: NSObject{
    
    static func openWebPage(url:String,controller:UIViewController){
        var urlFormat = url
        if !urlFormat.hasPrefix("https://"){
            urlFormat = String(format:"http://%@", urlFormat)
        }
        guard let url = URL(string: urlFormat) else { return }
        print (url)
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.configuration.barCollapsingEnabled = true
        safariViewController.dismissButtonStyle = .close
        
        controller.present(safariViewController,animated: true, completion: nil)
    }
}
