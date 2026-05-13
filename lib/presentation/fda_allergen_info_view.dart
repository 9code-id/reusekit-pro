import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaAllergenInfoView extends StatefulWidget {
  const FdaAllergenInfoView({super.key});

  @override
  State<FdaAllergenInfoView> createState() => _FdaAllergenInfoViewState();
}

class _FdaAllergenInfoViewState extends State<FdaAllergenInfoView> {
  String selectedDish = "Chicken Tikka Masala";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> dishes = [
    {
      "name": "Chicken Tikka Masala",
      "image": "https://picsum.photos/300/200?random=1&keyword=curry",
      "restaurant": "Spice Garden",
      "allergens": ["Dairy", "Gluten"],
      "mayContain": ["Nuts"],
      "safeFor": ["Egg-Free", "Soy-Free"],
      "severity": "Medium",
    },
    {
      "name": "Caesar Salad",
      "image": "https://picsum.photos/300/200?random=2&keyword=salad",
      "restaurant": "Green Leaf",
      "allergens": ["Dairy", "Eggs", "Gluten"],
      "mayContain": ["Fish"],
      "safeFor": ["Nut-Free", "Soy-Free"],
      "severity": "Medium",
    },
    {
      "name": "Pad Thai",
      "image": "https://picsum.photos/300/200?random=3&keyword=noodles",
      "restaurant": "Thai Palace",
      "allergens": ["Eggs", "Peanuts", "Soy"],
      "mayContain": ["Shellfish"],
      "safeFor": ["Dairy-Free", "Gluten-Free"],
      "severity": "High",
    },
  ];

  final List<Map<String, dynamic>> allergenDetails = [
    {
      "name": "Dairy",
      "icon": Icons.local_drink,
      "color": Colors.blue,
      "description": "Contains milk, cheese, butter, cream, or other dairy products",
      "commonSources": ["Milk", "Cheese", "Butter", "Cream", "Yogurt", "Ice Cream"],
      "severity": "Medium",
      "symptoms": ["Digestive issues", "Skin reactions", "Respiratory problems"],
    },
    {
      "name": "Gluten",
      "icon": Icons.grain,
      "color": Colors.amber,
      "description": "Contains wheat, barley, rye, or other gluten-containing grains",
      "commonSources": ["Wheat", "Barley", "Rye", "Bread", "Pasta", "Beer"],
      "severity": "High",
      "symptoms": ["Digestive problems", "Fatigue", "Headaches", "Joint pain"],
    },
    {
      "name": "Nuts",
      "icon": Icons.eco,
      "color": Colors.brown,
      "description": "Contains tree nuts such as almonds, walnuts, cashews, etc.",
      "commonSources": ["Almonds", "Walnuts", "Cashews", "Pistachios", "Hazelnuts"],
      "severity": "Severe",
      "symptoms": ["Anaphylaxis", "Swelling", "Difficulty breathing", "Skin reactions"],
    },
    {
      "name": "Peanuts",
      "icon": Icons.scatter_plot,
      "color": Colors.orange,
      "description": "Contains peanuts or peanut-derived ingredients",
      "commonSources": ["Peanuts", "Peanut Oil", "Peanut Butter", "Groundnuts"],
      "severity": "Severe",
      "symptoms": ["Anaphylaxis", "Swelling", "Hives", "Respiratory distress"],
    },
    {
      "name": "Eggs",
      "icon": Icons.egg,
      "color": Colors.yellow[700],
      "description": "Contains eggs or egg-derived ingredients",
      "commonSources": ["Whole Eggs", "Egg Whites", "Egg Yolks", "Mayonnaise"],
      "severity": "Medium",
      "symptoms": ["Skin reactions", "Digestive issues", "Respiratory problems"],
    },
    {
      "name": "Soy",
      "icon": Icons.blur_circular,
      "color": Colors.green[700],
      "description": "Contains soy or soy-derived ingredients",
      "commonSources": ["Soybeans", "Soy Sauce", "Tofu", "Edamame", "Soy Milk"],
      "severity": "Medium",
      "symptoms": ["Digestive problems", "Skin reactions", "Respiratory issues"],
    },
    {
      "name": "Shellfish",
      "icon": Icons.set_meal,
      "color": Colors.cyan,
      "description": "Contains shellfish such as shrimp, crab, lobster, etc.",
      "commonSources": ["Shrimp", "Crab", "Lobster", "Clams", "Oysters", "Mussels"],
      "severity": "Severe",
      "symptoms": ["Anaphylaxis", "Swelling", "Difficulty breathing", "Vomiting"],
    },
    {
      "name": "Fish",
      "icon": Icons.phishing,
      "color": Colors.teal,
      "description": "Contains fish or fish-derived ingredients",
      "commonSources": ["Salmon", "Tuna", "Cod", "Fish Sauce", "Anchovy Paste"],
      "severity": "High",
      "symptoms": ["Anaphylaxis", "Hives", "Swelling", "Digestive issues"],
    },
  ];

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Severe":
        return dangerColor;
      case "High":
        return Colors.red[600]!;
      case "Medium":
        return warningColor;
      default:
        return infoColor;
    }
  }

  Widget _buildDishOverview() {
    final dish = dishes.firstWhere((d) => d["name"] == selectedDish);
    
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Image.network(
              "${dish["image"]}",
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${dish["name"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "from ${dish["restaurant"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getSeverityColor(dish["severity"]),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${dish["severity"]} Risk",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildAllergenSummary(dish),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergenSummary(Map<String, dynamic> dish) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((dish["allergens"] as List).isNotEmpty) ...[
          Text(
            "Contains Allergens:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: dangerColor,
            ),
          ),
          SizedBox(height: spXs),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (dish["allergens"] as List).map((allergen) => Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: dangerColor),
              ),
              child: Text(
                "$allergen",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: dangerColor,
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: spMd),
        ],
        if ((dish["mayContain"] as List).isNotEmpty) ...[
          Text(
            "May Contain:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: warningColor,
            ),
          ),
          SizedBox(height: spXs),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (dish["mayContain"] as List).map((allergen) => Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: warningColor),
              ),
              child: Text(
                "$allergen",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: warningColor,
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: spMd),
        ],
        if ((dish["safeFor"] as List).isNotEmpty) ...[
          Text(
            "Safe For:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: successColor,
            ),
          ),
          SizedBox(height: spXs),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (dish["safeFor"] as List).map((safe) => Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: successColor),
              ),
              child: Text(
                "$safe",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: successColor,
                ),
              ),
            )).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildAllergenGuide() {
    List<Map<String, dynamic>> filteredAllergens = allergenDetails.where((allergen) {
      return searchQuery.isEmpty || 
             allergen["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search allergens",
                  value: searchQuery,
                  hint: "Type allergen name...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.clear,
                size: bs.sm,
                onPressed: searchQuery.isEmpty ? null : () {
                  searchQuery = "";
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Allergen Information Guide",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Learn about common food allergens and their symptoms",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ...filteredAllergens.map((allergen) => _buildAllergenCard(allergen)),
        ],
      ),
    );
  }

  Widget _buildAllergenCard(Map<String, dynamic> allergen) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: ExpansionTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: (allergen["color"] as Color).withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            allergen["icon"],
            color: allergen["color"],
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                "${allergen["name"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: _getSeverityColor(allergen["severity"]),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${allergen["severity"]}",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(
          "${allergen["description"]}",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoSection("Common Sources", allergen["commonSources"]),
                SizedBox(height: spMd),
                _buildInfoSection("Symptoms", allergen["symptoms"]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: items.map((item) => Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "$item",
              style: TextStyle(
                fontSize: 12,
                color: infoColor,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildDishSelector() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Select Dish to Check",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          ...dishes.map((dish) => ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(radiusXs),
              child: Image.network(
                "${dish["image"]}",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              "${dish["name"]}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
            subtitle: Text("${dish["restaurant"]}"),
            trailing: selectedDish == dish["name"] 
                ? Icon(Icons.check_circle, color: primaryColor)
                : null,
            onTap: () {
              selectedDish = dish["name"];
              setState(() {});
            },
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Allergen Information",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Dish Check", icon: Icon(Icons.restaurant)),
        Tab(text: "Allergen Guide", icon: Icon(Icons.info)),
      ],
      tabChildren: [
        SingleChildScrollView(
          child: Column(
            children: [
              _buildDishSelector(),
              _buildDishOverview(),
            ],
          ),
        ),
        _buildAllergenGuide(),
      ],
    );
  }
}
