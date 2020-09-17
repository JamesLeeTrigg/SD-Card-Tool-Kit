//
//  ContentView.swift
//  SD Card Tool Kit
//
//  Created by James Trigg on 12/09/2020.
//  Copyright © 2020 James Trigg. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var message = "Hello, World!"
    @State var isRunning = false
    
    func speak() {
        let executableURL = URL(fileURLWithPath: "/usr/bin/say")
        self.isRunning = true
        try! Process.run(executableURL,
                         arguments: [self.message],
                         terminationHandler: { _ in self.isRunning = false })
    }
    
    var body: some View {
        VStack {
            Text("SD Card Tool Kit")
            .font(.largeTitle)
            DriveList()
        }
        
    }
}

/*
     Button(action: {
         print(drive.lastPathComponent)
     }) {
         Text(drive.lastPathComponent)
     }.disabled(isRunning)
         .padding(.trailing)
     */


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
