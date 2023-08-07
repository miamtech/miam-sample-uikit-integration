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

class CatalogFiltersViewController:  UIHostingController<
    CatalogFilterViewTemplate<
        MiamNeutralCatalogFilterTitleAndClose,
        MiamNeutralCatalogFilterSectionTitle,
        MiamNeutralCatalogFilterRow,
        MiamNeutralCatalogFilterSubmitAndClearButton>
> {

       required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
            }

            override init(rootView: CatalogFilterViewTemplate<
                          MiamNeutralCatalogFilterTitleAndClose,
                          MiamNeutralCatalogFilterSectionTitle,
                          MiamNeutralCatalogFilterRow,
                          MiamNeutralCatalogFilterSubmitAndClearButton>
            ) {
                super.init(rootView: rootView)
            }

            public init() {
                let catalogFilterPage = CatalogFilterViewTemplate.init(
                    titleAndClose: MiamNeutralCatalogFilterTitleAndClose(),
                    filterSectionTitle: MiamNeutralCatalogFilterSectionTitle(),
                    filterRow: MiamNeutralCatalogFilterRow(),
                    finalButtons: MiamNeutralCatalogFilterSubmitAndClearButton(),
                    apply: {},
                    close: {})
                super.init(rootView: catalogFilterPage)
            }

            override func viewDidLoad() {
                let recipeId = UserDefaults.standard.value(forKey: "miam_mealplanner_recipeId") as? String ?? ""

                super.viewDidLoad()
                self.title = "Mon assistant Budget repas"
                let catalogFilterPage = CatalogFilterViewTemplate.init(
                    titleAndClose: MiamNeutralCatalogFilterTitleAndClose(),
                    filterSectionTitle: MiamNeutralCatalogFilterSectionTitle(),
                    filterRow: MiamNeutralCatalogFilterRow(),
                    finalButtons: MiamNeutralCatalogFilterSubmitAndClearButton(),
                    apply: {},
                    close: {
                         self.navigationController?.popViewController(animated: true)
                 })
                self.rootView = catalogFilterPage
                // Do any additional setup after loading the view.
            }
        }
