//
//  SwiftUIView.swift
//  
//
//  Created by Philip Young on 2023-04-24.
//

import SwiftUI

struct MaybeSystemImage: View {
    var systemName: String
    var body: some View {
#if os(iOS)
        Image(systemName: systemName)
#else
        if #available(macOS 11.0, *) {
            Image(systemName: systemName)
        } else {
            EmptyView()
        }
#endif
    }
}


struct MaybeSystemImage_Previews: PreviewProvider {
    static var previews: some View {
        MaybeSystemImage(systemName: "circle.fill")
    }
}

extension View {
    func modify<T: View>(@ViewBuilder _ modifier: (Self) -> T) -> some View {
        return modifier(self)
    }
}
