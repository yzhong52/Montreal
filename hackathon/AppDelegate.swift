//
//  AppDelegate.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func saveButtonTapped(_ sender: Any)
    {
        let saveDialog = NSSavePanel()
        saveDialog.begin() { (result) -> Void in
            if result.rawValue == NSFileHandlingPanelOKButton,
                let url = saveDialog.url {
                let stringData = "electron."
                let success = FileManager.default.createFile(atPath: url.path,
                                                             contents: stringData.data(using: String.Encoding.utf8),
                                                             attributes: nil)
                
                print("Create file at \(url): \(success)")
            }
        }
    }
    
    @IBAction func openButtonTapped(_ sender: Any)
    {
        let dialog = NSOpenPanel()
        
        dialog.title                   = "Choose a .txt file"
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = false
        dialog.canChooseDirectories    = true
        dialog.canCreateDirectories    = true
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes        = ["txt"]
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            // Pathname of the file
            let result = dialog.url
            if (result != nil) {
                //                let path = result!.path
                //                filename_field.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
}

