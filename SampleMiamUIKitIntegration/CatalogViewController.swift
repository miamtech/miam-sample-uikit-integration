//
//  CatalogViewController.swift
//  SampleMiamUIKitIntegration
//
//  Created by didi on 08/08/2023.
//

import UIKit
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

class CatalogViewController: UIHostingController<
    CatalogViewTemplate<
        MiamNeutralCatalogToolbar,
        MiamNeutralMealPlannerCallToAction,
        MiamNeutralGeneralLoading,
        MiamNeutralCatalogEmpty,
        MiamNeutralGeneralLoading,
        MiamNeutralGeneralEmpty>
    > {
    
    required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)
         }
        
        override init(rootView:
            CatalogViewTemplate<
                MiamNeutralCatalogToolbar,
                MiamNeutralMealPlannerCallToAction,
                MiamNeutralGeneralLoading,
                      MiamNeutralCatalogEmpty,
                MiamNeutralGeneralLoading,
                MiamNeutralGeneralEmpty>
        ) {
            super.init(rootView: rootView)
        }
        
        public init() {
            let catalogPage = CatalogViewTemplate.init(
                toolbar: MiamNeutralCatalogToolbar(),
                mealPlannerCTA: MiamNeutralMealPlannerCallToAction(),
                catalogLoading: MiamNeutralGeneralLoading(),
                catalogEmpty: MiamNeutralCatalogEmpty(),
                catalogRecipeLoading: MiamNeutralGeneralLoading(),
                catalogRecipeEmpty: MiamNeutralGeneralEmpty(),
                closeCatalogAction: {},
                willNavigateTo: { _, _, _ in},
                filtersTapped: {},
                searchTapped: {},
                favoritesTapped: {},
                preferencesTapped: {})
            super.init(rootView: catalogPage)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Catalog"
        let catalogPage = CatalogViewTemplate.init(
            toolbar: MiamNeutralCatalogToolbar(),
            mealPlannerCTA: MiamNeutralMealPlannerCallToAction(),
            catalogLoading: MiamNeutralGeneralLoading(),
            catalogEmpty: MiamNeutralCatalogEmpty(),
            catalogRecipeLoading: MiamNeutralGeneralLoading(),
            catalogRecipeEmpty: MiamNeutralGeneralEmpty(),
            closeCatalogAction: {},
            willNavigateTo: { _, _, _ in},
            filtersTapped: {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(CatalogFiltersViewController(), animated: true)
                }
            },
            searchTapped: {},
            favoritesTapped: {},
            preferencesTapped: {})
        self.rootView = catalogPage
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
