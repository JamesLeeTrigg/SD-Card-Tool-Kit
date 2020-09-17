//
//  DriveList.swift
//  SD Card Tool Kit
//
//  Created by James Trigg on 12/09/2020.
//  Copyright © 2020 James Trigg. All rights reserved.
//

import SwiftUI

struct DriveList: View {
    let drives = SDCardTools.getDrives()!
    var body: some View {
        return List(drives) { drive in
            DriveRow(drive : drive)
        }
    }
}

struct DriveRow: View {
    var drive : Drive
    
    var body: some View {
        HStack {
            DriveIcon(path : drive.path)
                padding(10)
            Text(drive.name)
        }
    }
}

struct DriveIcon : View {
    
    var path: String
    var body: some View {
        Image(nsImage: NSWorkspace.shared.icon(forFile: path ))
            .resizable()
            .frame(width: 50, height: 50)
    }
}

struct DriveList_Previews: PreviewProvider {
    static var previews: some View {
        DriveList()
    }
}
