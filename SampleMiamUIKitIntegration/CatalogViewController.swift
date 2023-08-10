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

/// This sets the Templates for the CatalogPage Overview
public struct MiamNeutralCatalogPageTemplates: CatalogPageTemplateGroup {
    public var toolbar = MiamNeutralCatalogToolbar()
    // Use defaults 
    @DefaultBackgroundViewTemplate public var background
    @DefaultLoadingViewTemplate public var loading
    @DefaultEmptyViewTemplate public var empty
}

/// This sets the Templates for the CatalogRecipesList Overview
public struct MiamNeutralCatalogRecipesListTemplates: CatalogRecipesListTemplateGroup {
    // use defaults
    @DefaultLoadingViewTemplate public var loading
    @DefaultEmptyViewTemplate public var empty
}


class CatalogViewController: UIHostingController<
    CatalogViewTemplate<
        MiamNeutralCatalogPageTemplates,
        MiamNeutralMealPlannerCallToAction,
        MiamNeutralCatalogRecipesListTemplates
>
    > {
        
        private func setupTabBarItem() {
            self.tabBarItem.title = "Catalog"
            self.tabBarItem.image = UIImage(systemName: "book.fill")
        }
    
        required init?(coder aDecoder: NSCoder) {
            let catalogPage = CatalogViewTemplate(
                catalogPageTemplates: MiamNeutralCatalogPageTemplates(),
                mealPlannerCTA: MiamNeutralMealPlannerCallToAction(),
                catalogRecipesListsTemplates: MiamNeutralCatalogRecipesListTemplates(),
                closeCatalogAction: {},
                willNavigateTo: { _, _, _ in},
                filtersTapped: {},
                searchTapped: {},
                favoritesTapped: {},
                preferencesTapped: {},
                launchMealPlanner: {}
            )
            super.init(coder: aDecoder, rootView: catalogPage)
            setupTabBarItem()
        }

        
        override init(rootView:
            CatalogViewTemplate<
                      MiamNeutralCatalogPageTemplates,
                      MiamNeutralMealPlannerCallToAction,
                      MiamNeutralCatalogRecipesListTemplates>
        ) {
            super.init(rootView: rootView)
            setupTabBarItem()
        }
        
        public init() {
            let catalogPage = CatalogViewTemplate.init(
                catalogPageTemplates: MiamNeutralCatalogPageTemplates(),
                mealPlannerCTA: MiamNeutralMealPlannerCallToAction(),
                catalogRecipesListsTemplates: MiamNeutralCatalogRecipesListTemplates(),
                closeCatalogAction: {},
                willNavigateTo: { _, _, _ in},
                filtersTapped: {},
                searchTapped: {},
                favoritesTapped: {},
                preferencesTapped: {},
                launchMealPlanner: {})
            super.init(rootView: catalogPage)
            setupTabBarItem()
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Catalog"
        let catalogPage = CatalogViewTemplate.init(
            catalogPageTemplates: MiamNeutralCatalogPageTemplates(),
            mealPlannerCTA: MiamNeutralMealPlannerCallToAction(),
            catalogRecipesListsTemplates: MiamNeutralCatalogRecipesListTemplates(),
            closeCatalogAction: {
                print("closeCatalogAction")
            },
            willNavigateTo: { _, _, _ in},
            filtersTapped: {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(CatalogFiltersViewController(), animated: true)
                }
            },
            searchTapped: {
                print("searchTapped")
            },
            favoritesTapped: {
                print("favoritesTapped")
            },
            preferencesTapped: {
                print("preferencesTapped")
            },
            launchMealPlanner: {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MealPlannerFormViewController(), animated: true)
                }
            })
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
