//
//  CatalogFiltersViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 07/08/2023.
//
import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

/// This sets the Templates for the CatalogFiltersPage Overview
public struct MiamNeutralCatalogCatalogFilterViewParameters: CatalogFilterViewParameters {
    public var titleAndClose = MiamNeutralCatalogFilterTitleAndClose()
    public var filterSectionTitle = MiamNeutralCatalogFilterSectionTitle()
    public var filterRow = MiamNeutralCatalogFilterRow()
    public var finalButtons = MiamNeutralCatalogFilterSubmitAndClearButton()
    // Use defaults
    @DefaultBackgroundViewTemplate public var background
}

class CatalogFiltersViewController:  UIHostingController<
    CatalogFilterViewTemplate<
        MiamNeutralCatalogCatalogFilterViewParameters
>
> {

       required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
            }

            override init(rootView: CatalogFilterViewTemplate<
                          MiamNeutralCatalogCatalogFilterViewParameters>
            ) {
                super.init(rootView: rootView)
            }

            public init() {
                let catalogFilterPage = CatalogFilterViewTemplate.init(
                    viewParameters: MiamNeutralCatalogCatalogFilterViewParameters(),
                    apply: {},
                    close: {})
                super.init(rootView: catalogFilterPage)
            }

            override func viewDidLoad() {
                let recipeId = UserDefaults.standard.value(forKey: "miam_mealplanner_recipeId") as? String ?? ""

                super.viewDidLoad()
                self.title = "Catalog Filters"
                let catalogFilterPage = CatalogFilterViewTemplate.init(
                    viewParameters: MiamNeutralCatalogCatalogFilterViewParameters(),
                    apply: {
                        self.navigationController?.popViewController(animated: true)
                    },
                    close: {
                         self.navigationController?.popViewController(animated: true)
                 })
                self.rootView = catalogFilterPage
                // Do any additional setup after loading the view.
            }
        }
