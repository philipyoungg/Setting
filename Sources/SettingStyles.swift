//
//  SettingStyles.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A button style that highlights the row when tapped.
 */
public struct SettingRowButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .background(
                Group {
                    if configuration.isPressed {
                        SettingTheme.labelColor
                            .opacity(0.1)
                    } else {
                        EmptyView()
                    }
                }
            )
    }
}

public extension ButtonStyle where Self == SettingRowButtonStyle {
    static var row: SettingRowButtonStyle {
        SettingRowButtonStyle()
    }
}
