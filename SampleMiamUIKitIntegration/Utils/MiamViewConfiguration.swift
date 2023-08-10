//
//  MiamViewConfiguration.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 10/08/2023.
//

import Foundation
import MiamIOSFramework
import MiamNeutraliOSFramework

@available(iOS 14, *)
@propertyWrapper
struct DefaultLoadingViewTemplate {
    var wrappedValue: some GeneralLoadingViewTemplate {
        return DefaultLoadingView()
    }
}

@available(iOS 14, *)
@propertyWrapper
struct DefaultEmptyViewTemplate {
    var wrappedValue: some GeneralEmptyViewTemplate {
        return DefaultEmptyView()
    }
}

@available(iOS 14, *)
@propertyWrapper
struct DefaultBackgroundViewTemplate {
    var wrappedValue: some GeneralBackgroundViewTemplate {
        return MiamNeutralGeneralBackground()
    }
}
