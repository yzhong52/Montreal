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
    
    @IBAction func saveButtonTapped(_ sender: Any)
    {
        let saveDialog = NSSavePanel()
        saveDialog.nameFieldStringValue = "hackathon.json"
        saveDialog.begin() { (result) -> Void in
            if result.rawValue == NSFileHandlingPanelOKButton,
                let url = saveDialog.url {
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let data = try! encoder.encode(AppData.settings)
                
                let success = FileManager.default.createFile(atPath: url.path,
                                                             contents: data,
                                                             attributes: nil)
                
                print("Create file at \(url): \(success)")
            }
        }
    }
    
    @IBAction func openButtonTapped(_ sender: Any)
    {
        let dialog = NSOpenPanel()
        
        dialog.title                   = "Choose a .json file"
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = false
        dialog.canChooseDirectories    = false
        dialog.canCreateDirectories    = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes        = ["json"]
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            if let url = dialog.url,
                let data = try? Data.init(contentsOf: url) {
                let decoder = JSONDecoder()
                if let appData = try? decoder.decode(AppData.self, from: data) {
                    AppData.settings = appData
                }
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
}

