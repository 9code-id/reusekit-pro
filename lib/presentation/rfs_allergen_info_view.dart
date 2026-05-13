import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsAllergenInfoView extends StatefulWidget {
  const RfsAllergenInfoView({super.key});

  @override
  State<RfsAllergenInfoView> createState() => _RfsAllergenInfoViewState();
}

class _RfsAllergenInfoViewState extends State<RfsAllergenInfoView> {
  String searchQuery = "";
  String selectedAllergen = "All";
  String selectedRisk = "All";
  bool showOnlyAllergenFree = false;

  final List<Map<String, dynamic>> allergenItems = [
    {"label": "All", "value": "All"},
    {"label": "Nuts", "value": "Nuts"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Gluten", "value": "Gluten"},
    {"label": "Eggs", "value": "Eggs"},
    {"label": "Fish", "value": "Fish"},
    {"label": "Shellfish", "value": "Shellfish"},
    {"label": "Soy", "value": "Soy"},
    {"label": "Sesame", "value": "Sesame"},
  ];

  final List<Map<String, dynamic>> riskItems = [
    {"label": "All", "value": "All"},
    {"label": "High Risk", "value": "High Risk"},
    {"label": "Medium Risk", "value": "Medium Risk"},
    {"label": "Low Risk", "value": "Low Risk"},
    {"label": "Safe", "value": "Safe"},
  ];

  final List<Map<String, dynamic>> allergenInfo = [
    {
      "name": "Tree Nuts",
      "icon": Icons.nature,
      "color": dangerColor,
      "severity": "High Risk",
      "description": "Can cause severe allergic reactions including anaphylaxis",
      "commonSources": ["Almonds", "Walnuts", "Cashews", "Pistachios", "Pecans", "Hazelnuts"],
      "hiddenSources": ["Natural flavoring", "Marzipan", "Nougat", "Pesto"],
      "symptoms": ["Hives", "Swelling", "Difficulty breathing", "Anaphylaxis"],
      "prevalence": "1% of population",
      "crossContamination": "High risk in manufacturing facilities"
    },
    {
      "name": "Peanuts",
      "icon": Icons.scatter_plot,
      "color": dangerColor,
      "severity": "High Risk",
      "description": "One of the most severe food allergies, can be life-threatening",
      "commonSources": ["Peanut butter", "Peanut oil", "Roasted peanuts", "Peanut flour"],
      "hiddenSources": ["African dishes", "Asian sauces", "Chili", "Mole sauce"],
      "symptoms": ["Skin reactions", "Digestive problems", "Respiratory issues", "Anaphylaxis"],
      "prevalence": "1.2% of population",
      "crossContamination": "Very high risk due to processing equipment"
    },
    {
      "name": "Milk & Dairy",
      "icon": Icons.local_drink,
      "color": warningColor,
      "severity": "Medium Risk",
      "description": "Most common food allergy in infants and young children",
      "commonSources": ["Milk", "Cheese", "Butter", "Yogurt", "Ice cream", "Cream"],
      "hiddenSources": ["Casein", "Whey", "Lactalbumin", "Ghee"],
      "symptoms": ["Digestive issues", "Skin rashes", "Respiratory problems"],
      "prevalence": "2.5% of children, 0.3% of adults",
      "crossContamination": "Medium risk in dairy processing facilities"
    },
    {
      "name": "Eggs",
      "icon": Icons.egg,
      "color": warningColor,
      "severity": "Medium Risk",
      "description": "Common in children, often outgrown by adulthood",
      "commonSources": ["Whole eggs", "Egg whites", "Egg yolks", "Mayonnaise"],
      "hiddenSources": ["Albumin", "Globulin", "Lecithin", "Lysozyme"],
      "symptoms": ["Skin inflammation", "Digestive problems", "Respiratory issues"],
      "prevalence": "1.3% of children, 0.2% of adults",
      "crossContamination": "Medium risk in baking facilities"
    },
    {
      "name": "Fish",
      "icon": Icons.set_meal,
      "color": infoColor,
      "severity": "Medium Risk",
      "description": "Different from shellfish allergy, can be species-specific",
      "commonSources": ["Salmon", "Tuna", "Cod", "Halibut", "Fish sauce"],
      "hiddenSources": ["Worcestershire sauce", "Caesar dressing", "Imitation crab"],
      "symptoms": ["Hives", "Nausea", "Breathing difficulties"],
      "prevalence": "0.4% of population",
      "crossContamination": "High risk in seafood restaurants"
    },
    {
      "name": "Shellfish",
      "icon": Icons.restaurant,
      "color": dangerColor,
      "severity": "High Risk",
      "description": "Most common food allergy in adults, often lifelong",
      "commonSources": ["Shrimp", "Crab", "Lobster", "Clams", "Mussels", "Oysters"],
      "hiddenSources": ["Surimi", "Bouillabaisse", "Cioppino", "Paella"],
      "symptoms": ["Severe allergic reactions", "Anaphylaxis", "Digestive issues"],
      "prevalence": "2.9% of adults",
      "crossContamination": "Very high risk in seafood establishments"
    },
    {
      "name": "Wheat & Gluten",
      "icon": Icons.grass,
      "color": warningColor,
      "severity": "Medium Risk",
      "description": "Includes wheat allergy and celiac disease",
      "commonSources": ["Bread", "Pasta", "Cereal", "Flour", "Beer"],
      "hiddenSources": ["Soy sauce", "Malt", "Modified food starch", "Hydrolyzed protein"],
      "symptoms": ["Digestive problems", "Skin reactions", "Headaches"],
      "prevalence": "1% of population (celiac), 0.4% (wheat allergy)",
      "crossContamination": "High risk in bakeries and kitchens"
    },
    {
      "name": "Soy",
      "icon": Icons.eco,
      "color": successColor,
      "severity": "Low Risk",
      "description": "More common in infants, often outgrown",
      "commonSources": ["Soy sauce", "Tofu", "Soy milk", "Edamame", "Miso"],
      "hiddenSources": ["Lecithin", "Vegetable protein", "Natural flavoring"],
      "symptoms": ["Mild digestive issues", "Skin reactions"],
      "prevalence": "0.4% of children, 0.1% of adults",
      "crossContamination": "Medium risk in Asian cuisine"
    },
    {
      "name": "Sesame",
      "icon": Icons.grain,
      "color": infoColor,
      "severity": "Medium Risk",
      "description": "Increasingly recognized as major allergen",
      "commonSources": ["Sesame seeds", "Tahini", "Sesame oil", "Hummus"],
      "hiddenSources": ["Bagels", "Breadcrumbs", "Flavoring", "Spice blends"],
      "symptoms": ["Skin reactions", "Respiratory issues", "Anaphylaxis"],
      "prevalence": "0.2% of population",
      "crossContamination": "Medium risk in Middle Eastern cuisine"
    }
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      "id": 1,
      "name": "Grilled Salmon with Quinoa",
      "category": "Main Course",
      "allergens": ["Fish"],
      "allergenFree": ["Nuts", "Dairy", "Gluten", "Eggs", "Shellfish", "Soy", "Sesame"],
      "riskLevel": "Medium Risk",
      "image": "https://picsum.photos/300/200?random=1&keyword=salmon",
      "description": "Fresh grilled salmon served with quinoa and seasonal vegetables",
      "safeTags": ["Nut-Free", "Dairy-Free", "Gluten-Free"],
      "warningTags": ["Contains Fish"],
      "crossContamination": "Prepared in kitchen that handles shellfish"
    },
    {
      "id": 2,
      "name": "Vegetable Stir Fry",
      "category": "Main Course",
      "allergens": ["Soy"],
      "allergenFree": ["Nuts", "Dairy", "Gluten", "Eggs", "Fish", "Shellfish", "Sesame"],
      "riskLevel": "Low Risk",
      "image": "https://picsum.photos/300/200?random=2&keyword=vegetables",
      "description": "Mixed vegetables stir-fried with soy sauce and garlic",
      "safeTags": ["Vegan", "Nut-Free", "Dairy-Free"],
      "warningTags": ["Contains Soy"],
      "crossContamination": "May contain traces of sesame oil"
    },
    {
      "id": 3,
      "name": "Classic Caesar Salad",
      "category": "Appetizer",
      "allergens": ["Eggs", "Dairy", "Fish"],
      "allergenFree": ["Nuts", "Shellfish", "Soy", "Sesame"],
      "riskLevel": "Medium Risk",
      "image": "https://picsum.photos/300/200?random=3&keyword=salad",
      "description": "Traditional Caesar salad with homemade dressing and croutons",
      "safeTags": ["Nut-Free"],
      "warningTags": ["Contains Eggs", "Contains Dairy", "Contains Anchovies"],
      "crossContamination": "Croutons may contain gluten"
    },
    {
      "id": 4,
      "name": "Peanut Butter Cookies",
      "category": "Dessert",
      "allergens": ["Nuts", "Eggs", "Dairy", "Gluten"],
      "allergenFree": ["Fish", "Shellfish", "Soy", "Sesame"],
      "riskLevel": "High Risk",
      "image": "https://picsum.photos/300/200?random=4&keyword=cookies",
      "description": "Homemade peanut butter cookies with chocolate chips",
      "safeTags": [],
      "warningTags": ["Contains Peanuts", "Contains Eggs", "Contains Dairy", "Contains Gluten"],
      "crossContamination": "Made in facility that processes tree nuts"
    },
    {
      "id": 5,
      "name": "Shrimp Scampi",
      "category": "Main Course",
      "allergens": ["Shellfish", "Dairy", "Gluten"],
      "allergenFree": ["Nuts", "Eggs", "Fish", "Soy", "Sesame"],
      "riskLevel": "High Risk",
      "image": "https://picsum.photos/300/200?random=5&keyword=shrimp",
      "description": "Garlic butter shrimp served over linguine pasta",
      "safeTags": ["Nut-Free"],
      "warningTags": ["Contains Shellfish", "Contains Dairy", "Contains Gluten"],
      "crossContamination": "Prepared in kitchen that handles fish"
    },
    {
      "id": 6,
      "name": "Quinoa Power Bowl",
      "category": "Main Course",
      "allergens": [],
      "allergenFree": ["Nuts", "Dairy", "Gluten", "Eggs", "Fish", "Shellfish", "Soy", "Sesame"],
      "riskLevel": "Safe",
      "image": "https://picsum.photos/300/200?random=6&keyword=quinoa",
      "description": "Nutrient-packed quinoa bowl with roasted vegetables and tahini-free dressing",
      "safeTags": ["Vegan", "Gluten-Free", "Allergen-Free", "Nut-Free", "Dairy-Free"],
      "warningTags": [],
      "crossContamination": "Prepared in dedicated allergen-free area"
    }
  ];

  List<Map<String, dynamic>> get filteredMenuItems {
    return menuItems.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesAllergen = selectedAllergen == "All" || (item["allergens"] as List).contains(selectedAllergen);
      bool matchesRisk = selectedRisk == "All" || item["riskLevel"] == selectedRisk;
      bool matchesAllergenFree = !showOnlyAllergenFree || (item["allergens"] as List).isEmpty;
      
      return matchesSearch && matchesAllergen && matchesRisk && matchesAllergenFree;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Allergen Information",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Menu Items", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Allergen Guide", icon: Icon(Icons.warning)),
        Tab(text: "Safety Protocols", icon: Icon(Icons.security)),
      ],
      tabChildren: [
        _buildMenuItemsTab(),
        _buildAllergenGuideTab(),
        _buildSafetyProtocolsTab(),
      ],
    );
  }

  Widget _buildMenuItemsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildAllergenOverview(),
          _buildMenuItemsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search menu items...",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Filter by Allergen",
                items: allergenItems,
                value: selectedAllergen,
                onChanged: (value, label) {
                  selectedAllergen = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Risk Level",
                items: riskItems,
                value: selectedRisk,
                onChanged: (value, label) {
                  selectedRisk = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        QSwitch(
          items: [
            {
              "label": "Show Only Allergen-Free Items",
              "value": true,
              "checked": showOnlyAllergenFree,
            }
          ],
          value: [if (showOnlyAllergenFree) {"label": "Show Only Allergen-Free Items", "value": true, "checked": true}],
          onChanged: (values, ids) {
            showOnlyAllergenFree = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildAllergenOverview() {
    int safeItems = menuItems.where((item) => item["riskLevel"] == "Safe").length;
    int lowRiskItems = menuItems.where((item) => item["riskLevel"] == "Low Risk").length;
    int mediumRiskItems = menuItems.where((item) => item["riskLevel"] == "Medium Risk").length;
    int highRiskItems = menuItems.where((item) => item["riskLevel"] == "High Risk").length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "$safeItems",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Safe Items",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "$lowRiskItems",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Low Risk",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "$mediumRiskItems",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Medium Risk",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "$highRiskItems",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "High Risk",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItemsList() {
    return Column(
      spacing: spSm,
      children: filteredMenuItems.map((item) {
        return _buildMenuItemCard(item);
      }).toList(),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    Color riskColor = _getRiskColor(item["riskLevel"] as String);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: (item["allergens"] as List).isNotEmpty ? Border.all(color: riskColor.withAlpha(100), width: 1) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: riskColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["riskLevel"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${item["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${item["category"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.info,
                size: bs.sm,
                onPressed: () {
                  _showItemDetails(item);
                },
              ),
            ],
          ),
          
          // Allergen Warning Tags
          if ((item["warningTags"] as List).isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "⚠️ Allergen Warnings:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (item["warningTags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: dangerColor.withAlpha(100)),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 9,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          
          // Safe Tags
          if ((item["safeTags"] as List).isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "✅ Safe for:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (item["safeTags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: successColor.withAlpha(100)),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 9,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          
          // Cross Contamination Warning
          if (item["crossContamination"] != null && (item["crossContamination"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, size: 12, color: warningColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${item["crossContamination"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAllergenGuideTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAllergenStatistics(),
          _buildAllergenCards(),
        ],
      ),
    );
  }

  Widget _buildAllergenStatistics() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Allergen Prevalence & Risk Levels",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("High Risk", allergenInfo.where((a) => a["severity"] == "High Risk").length, dangerColor),
              _buildStatCard("Medium Risk", allergenInfo.where((a) => a["severity"] == "Medium Risk").length, warningColor),
              _buildStatCard("Low Risk", allergenInfo.where((a) => a["severity"] == "Low Risk").length, successColor),
              _buildStatCard("Total Allergens", allergenInfo.length, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAllergenCards() {
    return Column(
      spacing: spSm,
      children: allergenInfo.map((allergen) {
        return _buildAllergenCard(allergen);
      }).toList(),
    );
  }

  Widget _buildAllergenCard(Map<String, dynamic> allergen) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: (allergen["color"] as Color).withAlpha(100), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: allergen["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  allergen["icon"] as IconData,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${allergen["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: allergen["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${allergen["severity"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.expand_more,
                size: bs.sm,
                onPressed: () {
                  _showAllergenDetails(allergen);
                },
              ),
            ],
          ),
          Text(
            "${allergen["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.people, size: 14, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "Affects: ${allergen["prevalence"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.warning, size: 14, color: warningColor),
              SizedBox(width: 4),
              Text(
                "${allergen["crossContamination"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyProtocolsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEmergencyProcedures(),
          _buildKitchenSafety(),
          _buildStaffTraining(),
          _buildCustomerGuidelines(),
        ],
      ),
    );
  }

  Widget _buildEmergencyProcedures() {
    final emergencySteps = [
      "Recognize symptoms: difficulty breathing, swelling, hives, nausea",
      "Call emergency services immediately if anaphylaxis is suspected",
      "Administer epinephrine auto-injector if available",
      "Keep patient calm and lying down with legs elevated",
      "Monitor breathing and consciousness until help arrives",
      "Never leave patient alone",
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: dangerColor.withAlpha(100), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.emergency, color: dangerColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Emergency Procedures",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          ...emergencySteps.asMap().entries.map((entry) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Center(
                    child: Text(
                      "${entry.key + 1}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildKitchenSafety() {
    final safetyProtocols = [
      {"title": "Separate Equipment", "description": "Use dedicated cutting boards, utensils, and preparation areas"},
      {"title": "Hand Washing", "description": "Wash hands thoroughly between handling different allergens"},
      {"title": "Clean Surfaces", "description": "Sanitize all work surfaces before preparing allergen-free meals"},
      {"title": "Ingredient Storage", "description": "Store allergen-containing ingredients in sealed, labeled containers"},
      {"title": "Order of Preparation", "description": "Prepare allergen-free items first to prevent contamination"},
      {"title": "Clear Labeling", "description": "Label all prepared items with allergen information"},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Kitchen Safety Protocols",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: safetyProtocols.map((protocol) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${protocol["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${protocol["description"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffTraining() {
    final trainingTopics = [
      "Allergen identification and sources",
      "Cross-contamination prevention",
      "Emergency response procedures",
      "Customer communication",
      "Menu ingredient knowledge",
      "Cleaning and sanitization",
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Staff Training Requirements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...trainingTopics.map((topic) {
            return Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    topic,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCustomerGuidelines() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Customer Guidelines",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildGuidelineItem("🗣️", "Always inform staff about allergies when ordering"),
          _buildGuidelineItem("📋", "Ask about ingredients and preparation methods"),
          _buildGuidelineItem("💊", "Carry prescribed medications (EpiPen) at all times"),
          _buildGuidelineItem("🚨", "Be aware of cross-contamination risks"),
          _buildGuidelineItem("📞", "Know emergency contact numbers"),
          _buildGuidelineItem("👥", "Inform dining companions about your allergies"),
        ],
      ),
    );
  }

  Widget _buildGuidelineItem(String icon, String text) {
    return Row(
      children: [
        Text(
          icon,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel) {
      case "High Risk": return dangerColor;
      case "Medium Risk": return warningColor;
      case "Low Risk": return primaryColor;
      case "Safe": return successColor;
      default: return disabledBoldColor;
    }
  }

  void _showItemDetails(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${item["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: spSm),
              Text("${item["description"]}"),
              SizedBox(height: spSm),
              Text(
                "Allergens:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              if ((item["allergens"] as List).isEmpty)
                Text("None", style: TextStyle(color: successColor))
              else
                ...(item["allergens"] as List).map((allergen) => Text("• $allergen")),
              SizedBox(height: spSm),
              if (item["crossContamination"] != null && (item["crossContamination"] as String).isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cross-Contamination Warning:",
                      style: TextStyle(fontWeight: FontWeight.bold, color: warningColor),
                    ),
                    Text("${item["crossContamination"]}", style: TextStyle(color: warningColor)),
                  ],
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showAllergenDetails(Map<String, dynamic> allergen) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${allergen["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${allergen["description"]}"),
              SizedBox(height: spSm),
              Text("Prevalence: ${allergen["prevalence"]}"),
              SizedBox(height: spSm),
              Text(
                "Common Sources:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...(allergen["commonSources"] as List).map((source) => Text("• $source")),
              SizedBox(height: spSm),
              Text(
                "Hidden Sources:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...(allergen["hiddenSources"] as List).map((source) => Text("• $source")),
              SizedBox(height: spSm),
              Text(
                "Symptoms:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...(allergen["symptoms"] as List).map((symptom) => Text("• $symptom")),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
