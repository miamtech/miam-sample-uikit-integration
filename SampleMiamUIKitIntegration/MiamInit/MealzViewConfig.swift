//
//  MealzViewConfig.swift
//  SampleMiamUIKitIntegration
//
//  Created by Diarmuid McGonagle on 06/03/2024.
//

import Foundation
import MealzUIModuleIOS
import MealzIOSFramework
import MealzNavModuleIOS

struct MealzViewConfig {
    
    // Below is the list of all the views and dimensions that are configurable.
    // They are commented out to demonstrate that they are not needed, as the Mealz Defaults will be used.
    
    // ----------------------------- BASE VIEWS ----------------------------------
    
    static let baseViews = BasePageViewParameters(
//        loading: TypeSafeLoading(MealzGeneralLoading()),
//        empty: TypeSafeEmpty(MealzGeneralEmpty()),
//        background: TypeSafeBackground(MealzGeneralBackground())
    )
    
    // ----------------------------- RECIPE DETAILS ------------------------------
    
    static let recipeDetailsViews = RecipeDetailsViewOptions(
//        header: TypeSafeRecipeDetailsHeader(MealzRecipeDetailsHeaderView()),
//        sponsor: TypeSafeRecipeDetailsSponsor(MealzRecipeDetailsSponsor()),
//        selectedControl: TypeSafeRecipeDetailsSelectedControl(MealzRecipeDetailsSelectedControlView()),
//        numberOfIngredientsTitle: TypeSafeBaseTitle(MealzRecipeDetailsNumberOfIngredientsTitleView()),
//        ingredients: TypeSafeRecipeDetailsIngredients(MealzRecipeDetailsIngredientsView()),
//        steps: TypeSafeRecipeDetailsSteps(MealzRecipeDetailsStepsView()),
//        footer: TypeSafeRecipeDetailsFooter(MealzRecipeDetailsFooterView()),
//        ingredientsAtHomeToggleButton: TypeSafeBaseButton(MealzNotInBasketTitle()),
//        unavailableIngredientsToggleButton: TypeSafeBaseButton(MealzNotInBasketTitle()),
//        ingredientsAtHome: TypeSafeNotInBasketProduct(MealzNotInBasketProduct()),
//        unavailableIngredients: TypeSafeNotInBasketProduct(MealzNotInBasketProduct())
    )
    static let recipeDetailsProductsViews = RecipeDetailsProductViewOptions(
//        ignoredProduct: TypeSafeRecipeDetailsIgnoredProduct(MealzRecipeDetailsIgnoredProductView()), 
//        unaddedProduct: TypeSafeRecipeDetailsUnaddedProduct(MealzRecipeDetailsUnaddedProductView()), 
//        addedProduct: TypeSafeRecipeDetailsAddedProduct(MealzRecipeDetailsAddedProductView()),
//        loadingProduct: TypeSafeLoading(MealzRecipeDetailsLoadingProductView())
    )
    static let itemSelectorViews = ItemSelectorViewOptions(
//        searchBar: TypeSafeSearch(MealzItemSelectorSearch()),
//        title: TypeSafeBaseTitle(MealzItemSelectorTitle()),
//        selectedProduct: TypeSafeItemSelectorSelectedProduct(MealzItemSelectorSelectedProduct()),
//        productOptions: TypeSafeItemSelectorOptionProducts(MealzItemSelectorOptionProducts())
    )
    static let recipeDetailsConfig = RecipeDetailsFeatureConstructor(
//        baseViews: baseViews,
//        recipeDetailsViewOptions: recipeDetailsViews,
//        recipeDetailsProductViewOptions: recipeDetailsProductsViews
    )
    
    // -------------------------------- CATALOG ----------------------------------
    
    static let catalogView = CatalogViewOptions(
//        catalogToolbar: TypeSafeCatalogToolbar(MealzCatalogToolbar()),
//        resultsToolbar: TypeSafeCatalogToolbar(MealzCatalogResultsToolbar()),
//        mealsInBasketButtonSuccess: TypeSafeMealsInBasketButtonSuccess(MealzMealsInBasketButtonSuccess()),
//        mealsInBasketButtonEmpty: TypeSafeEmpty(MealzGeneralEmpty())
    )
    static let catalogPackageView = CatalogPackageRowViewOptions(
//        callToAction: TypeSafeCatalogPackageCTA(MealzCatalogPackageCTA()),
//        recipeCard: TypeSafeCatalogRecipeCard(MealzRecipeCard()),
//        recipeCardLoading: TypeSafeRecipeCardLoading(MealzRecipeCardLoading())
    )
    static let recipesListView = CatalogRecipesListViewOptions(
//        recipeCard: TypeSafeCatalogRecipeCard(MealzRecipeCard()),
//        recipeCardLoading: TypeSafeRecipeCardLoading(MealzRecipeCardLoading()),
//        title: TypeSafeBaseTitle(MealzCatalogPackageTitle()),
//        noResults: TypeSafeCatalogRecipesListNoResults(MealzCatalogRecipesListNoResults()),
//        loading: TypeSafeLoading(MealzGeneralLoading())
    )
    static let catalogViewGridConfig = CatalogRecipesListGridConfig(
//        numberOfColumns: 1,
//        spacing: CGSize(width: 4, height: 4),
//        recipeCardDimensions: CGSize(width: 300, height: 300),
//        recipeCardFillMaxWidth: false // width will be ignored if this is true
    )
    static let catalogResultsGridConfig = CatalogRecipesListGridConfig(
//        numberOfColumns: 2,
//        spacing: CGSize(width: 4, height: 4),
//        recipeCardDimensions: CGSize(width: 300, height: 300),
//        recipeCardFillMaxWidth: true // width will be ignored if this is true
    )
    static let catalogSearchView = CatalogSearchViewOptions(
//        search: TypeSafeSearch(MealzGeneralSearch())
    )
    static let filtersViewOptions = FiltersViewOptions(
//        header: TypeSafeFiltersHeader(MealzFiltersHeader()),
//        callToAction: TypeSafeFiltersCTA(MealzFiltersCTA()),
//        section: TypeSafeFiltersSection(MealzFiltersSection()),
//        background: TypeSafeBackground(MealzGeneralBackground())
    )
    static let preferencesViewOptions = PreferencesViewOptions(
//        guestSection: TypeSafePreferencesGuest(MealzPreferencesGuest()),
//        dietSection: TypeSafePreferencesDiet(MealzPreferencesDiet()),
//        ingredientsSection: TypeSafePreferencesIngredients(MealzPreferencesIngredients()),
//        equipmentSection: TypeSafePreferencesEquipment(MealzPreferencesEquipment()),
//        footer: TypeSafePreferencesFooter(MealzPreferencesFooter())
    )
    static let preferencesSearchViewOptions = PreferencesSearchViewOptions(
//        search: TypeSafeSearch(MealzGeneralSearch()),
//        tagButton: TypeSafeBaseButton(MealzPreferencesSearchTag())
    )
    static let catalogConfig = CatalogFeatureConstructor(
        useMealPlanner: true // only if you want Meal Planner feature
//        usesPreferences: true,
//        baseViews: baseViews,
//        catalogViewOptions: catalogView,
//        recipesListViewOptions: recipesListView,
//        packageRowViewOptions: catalogPackageView,
//        catalogSearchViewOptions: catalogSearchView, 
//        filtersViewOptions: filtersViewOptions,
//        preferencesViewOptions: preferencesViewOptions,
//        preferencesSearchViewOptions: preferencesSearchViewOptions,
//        catalogViewGridConfig: catalogViewGridConfig,
//        catalogResultsGridConfig: catalogResultsGridConfig
    )
    
    // -------------------------------- FAVORITES ----------------------------------
    
    /* pass in your nav to the catalog here! */
    static let showCatalog = {}
    
    static let favoritesView = FavoritesViewOptions(
//        title: TypeSafeBaseTitle(MealzFavoritesTitle()),
//        recipeCard: TypeSafeCatalogRecipeCard(MealzRecipeCard()),
//        recipeCardLoading: TypeSafeRecipeCardLoading(MealzRecipeCardLoading())
    )
    static let favoritesGridConfig = CatalogRecipesListGridConfig(
//        numberOfColumns: 1,
//        spacing: CGSize(width: 4, height: 4),
//        recipeCardDimensions: CGSize(width: 300, height: 300),
//        recipeCardFillMaxWidth: true // width will be ignored if this is true
    )
    
    static let favoritesConfig = FavoritesFeatureConstructor(
//        baseViews: baseViews,
//        favoritesViewOptions: favoritesView,
//        catalogRecipesListGridConfig: favoritesGridConfig,
        navigateToCatalog: showCatalog // this is mandatory
    )
    
    // ---------------------------------- MY MEALS ----------------------------------
    
    static let myMealsView = MyMealsViewOptions(
//        title: TypeSafeBaseTitle(MealzMyMealsTitle()),
//        recipeCard: TypeSafeMyMealRecipeCard(MealzMyMealRecipeCard()),
//        recipeCardLoading: TypeSafeRecipeCardLoading(MealzRecipeCardLoading())
    )
    static let myMealsGridConfig = CatalogRecipesListGridConfig(
//        numberOfColumns: 1,
//        spacing: CGSize(width: 4, height: 4),
//        recipeCardDimensions: CGSize(width: 300, height: 300),
//        recipeCardFillMaxWidth: true // width will be ignored if this is true
    )
    static let myMealsConfig = MyMealsFeatureConstructor(
//        baseViews: baseViews,
//        myMealsViewOptions: myMealsView,
//        catalogRecipesListGridConfig: myMealsGridConfig,
        navigateToCatalog: showCatalog // this is mandatory
    )
    
    // ------------------------------- MEAL PLANNER ------------------------------
    
    static let mealPlannerFormView = MealPlannerFormViewOptions(
//        form: TypeSafeMealPlannerForm(MealzMealPlannerForm())
    )
    static let mealPlannerResultsView = MealPlannerResultsViewOptions(
//        toolbar: TypeSafeMealPlannerResultsToolbar(MealzMealPlannerResultsToolbar()),
//        footer: TypeSafeMealPlannerResultsFooter(MealzMealPlannerStickyFooter()),
//        recipeCard: TypeSafeMealPlannerRecipeCard(MealzMealPlannerRecipeCard()),
//        recipeCardLoading: TypeSafeRecipeCardLoading(MealzMealPlannerRecipeCardLoading()),
//        placeholder: TypeSafeMealPlannerRecipePlaceholder(MealzMealPlannerRecipePlaceholder()),
//        emptyResults: TypeSafeMealPlannerResultsEmpty(MealzMealPlannerResultsEmpty())
    )
    static let mealPlannerReplaceRecipeView = MealPlannerRecipePickerViewOptions(
//        search: TypeSafeSearch(MealzMealPlannerSearch()),
//        noResults: TypeSafeCatalogRecipesListNoResults(MealzCatalogRecipesListNoResults()),
//        recipeCard: TypeSafeCatalogRecipeCard(MealzRecipeCard()),
//        recipeCardLoading: TypeSafeRecipeCardLoading(MealzRecipeCardLoading())
    )
    static let mealPlannerBasketView = MealPlannerBasketViewOptions(
//        footer: TypeSafeMealPlannerBasketFooter(MealzMealPlannerBasketPreviewFooter())
    )
    static let basketRecipeView = BasketRecipeViewOptions(
//        recipeOverview: TypeSafeBasketRecipeOverview(MealzBasketRecipeOverview()),
//        recipeOverviewLoading: TypeSafeRecipeCardLoading(MealzMealPlannerRecipeCardLoading()),
//        basketProduct: TypeSafeBasketProduct(MealzBasketProduct()),
//        ingredientsAtHomeToggleButton: TypeSafeBaseButton(MealzNotInBasketTitle()),
//        removedIngredientsToggleButton: TypeSafeBaseButton(MealzNotInBasketTitle()),
//        unavailableIngredientsToggleButton: TypeSafeBaseButton(MealzNotInBasketTitle()),
//        ingredientsAtHome: TypeSafeNotInBasketProduct(MealzNotInBasketProduct()),
//        removedIngredients: TypeSafeNotInBasketProduct(MealzNotInBasketProduct()),
//        unavailableIngredients: TypeSafeNotInBasketProduct(MealzNotInBasketProduct())
    )
    static let mealPlannerRecapView = MealPlannerRecapViewOptions(
//        success: TypeSafeMealPlannerRecap(MealzMealPlannerRecap()),
//        background: TypeSafeBackground(MealzGeneralBackground())
    )
    static let basketGridConfig = BasketRecipesGridConfig(
//        recipeSpacing: CGSize(width: 4, height: 4),
//        productSpacing: CGSize(width: 4, height: 4),
//        recipeOverviewDimensions: CGSize(width: 300, height: 150),
//        heightOfFooter: 80,
//        isExpandable: true
    )
    static let mealPlannerRecipesListGridConfig = MealPlannerRecipesListGridConfig(
//        spacing: CGSize(width: 4, height: 4),
//        recipeCardDimensions: CGSize(width: 300, height: 200),
//        heightOfFooter: 100
    )
    
    static let mealPlannerConfig = MealPlannerFeatureConstructor(
//        baseViews: baseViews,
//        mealPlannerFormViewOptions: mealPlannerFormView,
//        mealPlannerResultsViewOptions: mealPlannerResultsView,
//        mealPlannerRecipePickerViewOptions: mealPlannerReplaceRecipeView,
//        mealPlannerBasketViewOptions: mealPlannerBasketView,
//        basketRecipeViewOptions: basketRecipeView,
//        mealPlannerRecapViewOptions: mealPlannerRecapView,
//        filtersViewOptions: filtersViewOptions,
//        mealPlannerRecipesListGridConfig: mealPlannerRecipesListGridConfig,
//        catalogRecipesListGridConfig: catalogResultsGridConfig
    )
    
    static let mealPlannerRecipeDetailsConfig = RecipeDetailsFeatureConstructor(
//        baseViews: baseViews,
//        recipeDetailsViewOptions: recipeDetailsViews,
//        recipeDetailsProductViewOptions: recipeDetailsProductsViews,
//        itemSelectorViewOptions: itemSelectorViews
    )
}
