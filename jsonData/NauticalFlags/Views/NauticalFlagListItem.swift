//
//  NauticalFlagListItem.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import SwiftUI

struct NauticalFlagListItem: View {
    var flag: NauticalFlag

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(flag.wrappedId)
                    .font(.headline)
                Text(flag.wrappedMnemonic)
                    .font(.subheadline)
            }
            Spacer()
            Image(uiImage: UIImage(data: flag.wrappedImage.imageData) ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }
    }

}
