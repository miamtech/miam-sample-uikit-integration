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
public class MiamNeutralCatalogViewContent: CatalogViewContentParameters {
    
    weak var navigationController: UINavigationController?
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
// CONTENT
    public var toolbar = MiamNeutralCatalogToolbar()
    // Use defaults
    @DefaultBackgroundViewTemplate public var background
    @DefaultLoadingViewTemplate public var loading
    @DefaultEmptyViewTemplate public var empty
// ACTIONS
    public lazy var filtersTapped: () -> Void = {
        return { DispatchQueue.main.async {
                self.navigationController?.pushViewController(CatalogFiltersViewController(), animated: true)
        }}}()
    public lazy var searchTapped: () -> Void = {}
    public lazy var favoritesTapped: () -> Void = {}
    public lazy var preferencesTapped: () -> Void = {}
    
    // if you WANT the meal Planner:
    public var mealPlannerCTA = MiamNeutralMealPlannerCallToAction() // your CTA
    public lazy var launchMealPlanner: (() -> Void)? = {
        return { DispatchQueue.main.async {
                self.navigationController?.pushViewController(MealPlannerFormViewController(), animated: true)
        }}}()
    // if you do NOT want the mealPlanner
//    public lazy var launchMealPlanner: (() -> Void)? = nil
//    public var mealPlannerCTA = DefaultMealPlannerCTA()
}

/// This sets the Templates for the CatalogRecipesList Overview
public struct MiamNeutralCatalogRecipesListsViewContent: CatalogRecipesListViewContentParameters {
    public var title = MiamNeutralCatalogRecipesListTitle()
    public var recipeCard = MiamRecipeCard()
    public var noResults = MiamNeutralCatalogRecipesListNoResults()
    // use defaults
    @DefaultLoadingViewTemplate public var loading
    @DefaultEmptyViewTemplate public var empty
}


class CatalogViewController: UIHostingController<
    CatalogViewTemplate<
        MiamNeutralCatalogViewContent,
        MiamNeutralCatalogRecipesListsViewContent
>
    > {
        
        private func setupTabBarItem() {
            self.tabBarItem.title = "Catalog"
            self.tabBarItem.image = UIImage(systemName: "book.fill")
        }
    
        required init?(coder aDecoder: NSCoder) {
            let catalogPage = CatalogViewTemplate(
                content: MiamNeutralCatalogViewContent(navigationController: nil), // NavC is nil before self is created
                catalogRecipesListsContent: MiamNeutralCatalogRecipesListsViewContent(),
                closeCatalogAction: {}
            )
            super.init(coder: aDecoder, rootView: catalogPage)
            setupTabBarItem()
        }

        
        override init(rootView:
            CatalogViewTemplate<
                      MiamNeutralCatalogViewContent,
                      MiamNeutralCatalogRecipesListsViewContent>
        ) {
            super.init(rootView: rootView)
            setupTabBarItem()
        }
        
        public init() {
            let catalogPage = CatalogViewTemplate.init(
                content: MiamNeutralCatalogViewContent(navigationController: nil), // NavC is nil before self is created
                catalogRecipesListsContent: MiamNeutralCatalogRecipesListsViewContent(),
                closeCatalogAction: {}
            )
            super.init(rootView: catalogPage)
            setupTabBarItem()
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Catalog"
        let catalogPage = CatalogViewTemplate.init(
            content: MiamNeutralCatalogViewContent(navigationController: self.navigationController),
            catalogRecipesListsContent: MiamNeutralCatalogRecipesListsViewContent(),
            closeCatalogAction: {
                print("closeCatalogAction")
            }
        )
        self.rootView = catalogPage
        // Do any additional setup after loading the view.
    }
}
