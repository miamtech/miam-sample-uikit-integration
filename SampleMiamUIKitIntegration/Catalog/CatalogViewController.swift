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
public class MiamNeutralCatalogViewParams: CatalogViewParameters {
    weak var navigationController: UINavigationController?
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // if you WANT the meal Planner:
    public var mealPlannerCTA = MiamNeutralMealPlannerCallToAction() // your CTA

// ACTIONS
    public lazy var filtersTapped: () -> Void = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(CatalogFiltersViewController(), animated: true)
        }}()
    public lazy var searchTapped: () -> Void = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(CatalogSearchViewController(), animated: true)
        }}()
    public lazy var favoritesTapped: () -> Void = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(CatalogResultsViewController(), animated: true)
        }}()
    public lazy var preferencesTapped: () -> Void = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(PreferencesViewController(), animated: true)
        }}()
    
    public lazy var launchMealPlanner: (() -> Void)? = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(MealPlannerFormViewController(), animated: true)
        }}()
    
    public lazy var myMealsButtonTapped: () -> Void = { [weak self] in
        return {
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(MyMealsViewController(), animated: true)
        }}()
}

/// This sets the Templates for the CatalogRecipesList Overview
public class MiamNeutralCatalogPackageRowParams: CatalogPackageRowParameters {
    weak var navigationController: UINavigationController?
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public var title = MiamNeutralCatalogPackageTitle()
    public var recipeCard = MiamNeutralRecipeCard()
    public var recipeCardLoading = MiamNeutralRecipeCardLoading()
    public var callToAction = MiamNeutralCatalogPackageCallToAction()
    
    public lazy var showRecipes: () -> Void = { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.navigationController?.pushViewController(CatalogResultsViewController(), animated: true)
    }
    public lazy var onRecipeTapped: (String) -> Void = { [weak self] recipeId in
        guard let strongSelf = self else { return }
        strongSelf.navigationController?.pushViewController(RecipeDetailsViewController(recipeId), animated: true)
        }
}

class CatalogViewController: UIViewController {
    deinit {
        print("deinit: CatalogViewController is being deallocated")
    }
    // Your SwiftUI View
    var swiftUIView: CatalogViewTemplate<
        MiamNeutralCatalogViewParams,
        MiamNeutralCatalogPackageRowParams> {
        return CatalogViewTemplate.init(
            params: MiamNeutralCatalogViewParams(navigationController: self.navigationController),
            catalogPackageRowParams: MiamNeutralCatalogPackageRowParams(navigationController: self.navigationController),
            config: MiamRecipesListViewConfig
        )
    }
    // The hosting controller for your SwiftUI view
    private var hostingController: UIHostingController<CatalogViewTemplate<
        MiamNeutralCatalogViewParams,
        MiamNeutralCatalogPackageRowParams>>?

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
