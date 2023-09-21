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
    public lazy var filtersTapped: () -> Void = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(CatalogFiltersViewController(), animated: true)
        }}()
    public lazy var searchTapped: () -> Void = {}
    public lazy var favoritesTapped: () -> Void = {}
    public lazy var preferencesTapped: () -> Void = {}
    
    // if you WANT the meal Planner:
    public var mealPlannerCTA = MiamNeutralMealPlannerCallToAction() // your CTA
    public lazy var launchMealPlanner: (() -> Void)? = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(MealPlannerFormViewController(), animated: true)
        }}()
    // if you do NOT want the mealPlanner
//    public lazy var launchMealPlanner: (() -> Void)? = nil
//    public var mealPlannerCTA = DefaultMealPlannerCTA()
}

/// This sets the Templates for the CatalogRecipesList Overview
public class MiamNeutralCatalogPackageRowContent: CatalogPackageRowContentParameters {
    weak var navigationController: UINavigationController?
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public var title = MiamNeutralCatalogPackageTitle()
    public var recipeCard = MiamRecipeCard()
    public var recipeCardLoading = MiamRecipeCardLoading()
    public var callToAction = MiamNeutralCatalogPackageCallToAction()
    
    public lazy var showRecipes: (MiamIOSFramework.CatalogPackage) -> Void = {[weak self] _ in}
    public lazy var onRecipeTapped: (String) -> Void = { [weak self] recipe in
        UserDefaults.standard.set(recipe, forKey: "miam_catalog_recipeId")
        guard let strongSelf = self else { return }
        strongSelf.navigationController?.pushViewController(MealPlannerRecipeDetailsViewController(), animated: true)
        }
}

class CatalogViewController: UIViewController {
    deinit {
        print("deinit: CatalogViewController is being deallocated")
    }
    // Your SwiftUI View
    var swiftUIView: CatalogViewTemplate<
        MiamNeutralCatalogViewContent,
        MiamNeutralCatalogPackageRowContent> {
        return CatalogViewTemplate.init(
            content: MiamNeutralCatalogViewContent(navigationController: self.navigationController),
            catalogPackageRowTemplates: MiamNeutralCatalogPackageRowContent(navigationController: self.navigationController),
            config: MiamCatalogListViewConfig,
            closeCatalogAction: {
                print("closeCatalogAction")
            }
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogViewTemplate<
        MiamNeutralCatalogViewContent,
        MiamNeutralCatalogPackageRowContent>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filters"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Retour", style: .plain, target: nil, action: nil)
        // Initialize the hosting controller with your SwiftUI view
        hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingController = hostingController, let hcView = hostingController.view
        else { return }
        // Since hostingController is optional, using guard to safely unwrap its view
        hcView.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        view.addSubview(hcView)
        NSLayoutConstraint.activate([
            hcView.topAnchor.constraint(equalTo: view.topAnchor),
            hcView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hcView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hcView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}
