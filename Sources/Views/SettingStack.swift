//
//  SettingStack.swift
//  Setting
//
//  Created by Zheng on 2/21/23.
//

import SwiftUI

/**
 The main view for settings. Everything else goes in here.
 */
public struct SettingStack: View {
    /**
     The main page to display.
     */
    public var page: () -> SettingPage

    /**
     A custom view to display when a search doesn't produce results.

     If this is nil, the default view will be used.
     */
    public var customNoResultsView: AnyView?

    @ObservedObject var settingViewModel = SettingViewModel()

    /**
     Whether the ``SettingStack`` should automatically embed in a ``NavigationStack`` / ``NavigationView``, or assume the view exists higher up
     in the hierarchy.
     */
    private let embedInNavigationStack: Bool
    
    
    private let isSearchable: Bool

    /**
     Create a new Settings view from a `SettingPage`. The default "no results" view will be used.
     - parameters:
        - embedInNavigationStack: Whether to embed the Settings views in a ``NavigationStack`` / ``NavigationView`` or not. If this is `false`, you will be responsible for providing the ``NavigationStack`` / ``NavigationView``.
        - page:A closure to provide a ``SettingPage`` to the ``SettingStack``.
     */
    public init(
        isSearchable: Bool = true,
        embedInNavigationStack: Bool = true,
        page: @escaping () -> SettingPage
    ) {
        self.isSearchable = isSearchable
        self.embedInNavigationStack = embedInNavigationStack
        self.page = page
    }

    /**
     Create a new Settings view from a `SettingPage`, with a custom `SettingViewModel` and custom "no results" view.
     - parameters:
        - settingViewModel: A custom view model to use for the ``SettingStack``.
        - embedInNavigationStack: Whether to embed the Settings views in a ``NavigationStack`` / ``NavigationView`` or not. If this is `false`, you will be responsible for providing the ``NavigationStack`` / ``NavigationView``.
        - page:A closure to provide a ``SettingPage`` to the ``SettingStack``.
        - customNoResultsView: A view builder to provide the view to use when there's no results.
     */
    public init<Content>(
        isSearchable: Bool,
        settingViewModel: SettingViewModel,
        embedInNavigationStack: Bool = true,
        page: @escaping () -> SettingPage,
        @ViewBuilder customNoResultsView: @escaping () -> Content
    ) where Content: View {
        self._settingViewModel = ObservedObject(wrappedValue: settingViewModel)
        self.embedInNavigationStack = embedInNavigationStack
        self.isSearchable = isSearchable
        self.page = page
        self.customNoResultsView = AnyView(customNoResultsView())
    }

    public var body: some View {
        if !embedInNavigationStack {
            main
        } else if #available(iOS 16.0, macOS 13.0, *) {
            NavigationStack {
                main
            }
        } else {
            NavigationView {
                main
            }
        }
    }

    @ViewBuilder var main: some View {
        let settingPage = page()

        VStack {
            if settingViewModel.searchText.isEmpty {
                SettingView(setting: settingPage, isInitialPage: true, isPagePreview: false)
            } else if
                let searchResult = settingViewModel.searchResult,
                !searchResult.sections.isEmpty
            {
                SettingSearchResultView(searchResult: searchResult)
            } else {
                if let customNoResultsView {
                    customNoResultsView
                } else {
                    Text("No results for '\(settingViewModel.searchText)'")
                        .foregroundColor(SettingTheme.secondaryLabelColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(SettingTheme.secondaryBackgroundColor)
                }
            }
        }
        .modify { view in
            if isSearchable {
                if #available(iOS 15.0, macOS 12.0, *) {
                    view.searchable(text: $settingViewModel.searchText)
                } else {
                    view
                }
            } else {
                view
            }
            
        }
        .environmentObject(settingViewModel)
        .onAppear {
            let paths = settingPage.generatePaths()
            settingViewModel.paths = paths
        }
        .onReceive(settingViewModel.regeneratePaths) { _ in
            let paths = settingPage.generatePaths()
            settingViewModel.paths = paths
        }
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
