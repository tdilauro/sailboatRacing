//
//  NauticalFlagListItem.swift
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import SwiftUI

struct NauticalFlagListItem: View {
    var flagVM: NauticalFlagViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(flagVM.id)
                    .font(.headline)
                Text(flagVM.mnemonic)
                    .font(.subheadline)
            }
            Spacer()
            Image(uiImage: UIImage(data: flagVM.image.imageData) ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }
    }

}
