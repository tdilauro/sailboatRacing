//
//  NauticalFlagSectionHeader.swift
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import SwiftUI


struct NauticalFlagSectionHeader: View {
    var title: String
    var isExpanded: Bool


    var body: some View {
        HStack {
            Text(title)
                .font(.title)
            Image(systemName: isExpanded ? "chevron.up.circle" : "chevron.down.circle")
                .font(.title)
            Spacer()
        }
    }
}


struct NauticalFlagSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        NauticalFlagSectionHeader(title: "Section 1", isExpanded: true)
    }
}
