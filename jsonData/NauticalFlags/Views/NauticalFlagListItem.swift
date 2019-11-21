//
//  NauticalFlagListItem.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import SwiftUI

struct NauticalFlagListItem: View {
    @ObservedObject var flag: NauticalFlagJSON

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(flag.id)
                    .font(.headline)
                Text(flag.mnemonic)
                    .font(.subheadline)
            }
            Spacer()
            Image(uiImage: flag.uiImage)
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }
    }

}


struct NauticalFlagListItem_Previews: PreviewProvider {
    @ObservedObject static var flag: NauticalFlagJSON = {
        let flag = NauticalFlagJSON()
        flag.id = "A"
        flag.mnemonic = "Alfa"
        flag.media_url = ""
        return flag
    }()

    static var previews: some View {
        return NauticalFlagListItem(flag: flag)
    }
}
