import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsCookingInstructionsView extends StatefulWidget {
  const RfsCookingInstructionsView({super.key});

  @override
  State<RfsCookingInstructionsView> createState() => _RfsCookingInstructionsViewState();
}

class _RfsCookingInstructionsViewState extends State<RfsCookingInstructionsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedCourse = "All";
  String selectedDifficulty = "All";
  bool showActiveOnly = false;

  List<Map<String, dynamic>> cookingInstructions = [
    {
      "id": "CI001",
      "dishName": "Beef Wellington",
      "category": "Main Course",
      "course": "Dinner",
      "difficulty": "Expert",
      "prepTime": 45,
      "cookTime": 35,
      "totalTime": 80,
      "servings": 6,
      "temperature": "400°F",
      "station": "Grill",
      "isActive": true,
      "allergens": ["Gluten", "Eggs"],
      "ingredients": [
        {"name": "Beef tenderloin", "amount": "2 lbs", "critical": true},
        {"name": "Puff pastry", "amount": "1 sheet", "critical": true},
        {"name": "Mushroom duxelles", "amount": "1 cup", "critical": false},
        {"name": "Prosciutto", "amount": "8 slices", "critical": false},
      ],
      "steps": [
        {"step": 1, "instruction": "Season beef tenderloin with salt and pepper", "time": 5, "critical": true},
        {"step": 2, "instruction": "Sear beef on all sides until golden brown", "time": 8, "critical": true},
        {"step": 3, "instruction": "Cool beef completely before wrapping", "time": 15, "critical": true},
        {"step": 4, "instruction": "Wrap in puff pastry with duxelles", "time": 12, "critical": true},
        {"step": 5, "instruction": "Bake at 400°F for 25-30 minutes", "time": 30, "critical": true},
        {"step": 6, "instruction": "Rest for 10 minutes before slicing", "time": 10, "critical": false},
      ],
      "techniques": ["Searing", "Wrapping", "Roasting"],
      "equipment": ["Cast iron pan", "Oven", "Thermometer"],
      "tips": "Use meat thermometer for perfect doneness",
      "plating": "Slice thick and arrange with sauce dots",
      "lastUpdated": "2024-01-15",
    },
    {
      "id": "CI002",
      "dishName": "Chocolate Soufflé",
      "category": "Dessert",
      "course": "Dinner",
      "difficulty": "Advanced",
      "prepTime": 30,
      "cookTime": 15,
      "totalTime": 45,
      "servings": 4,
      "temperature": "375°F",
      "station": "Pastry",
      "isActive": true,
      "allergens": ["Eggs", "Dairy"],
      "ingredients": [
        {"name": "Dark chocolate", "amount": "6 oz", "critical": true},
        {"name": "Egg whites", "amount": "6 large", "critical": true},
        {"name": "Egg yolks", "amount": "4 large", "critical": true},
        {"name": "Sugar", "amount": "1/2 cup", "critical": false},
      ],
      "steps": [
        {"step": 1, "instruction": "Melt chocolate in double boiler", "time": 8, "critical": true},
        {"step": 2, "instruction": "Whisk in egg yolks one at a time", "time": 5, "critical": true},
        {"step": 3, "instruction": "Beat egg whites to soft peaks", "time": 8, "critical": true},
        {"step": 4, "instruction": "Fold whites into chocolate mixture", "time": 4, "critical": true},
        {"step": 5, "instruction": "Bake immediately for 12-15 minutes", "time": 15, "critical": true},
      ],
      "techniques": ["Melting", "Whisking", "Folding"],
      "equipment": ["Double boiler", "Electric mixer", "Ramekins"],
      "tips": "Never open oven door during baking",
      "plating": "Dust with powdered sugar, serve immediately",
      "lastUpdated": "2024-01-14",
    },
    {
      "id": "CI003",
      "dishName": "Pan-Seared Salmon",
      "category": "Main Course",
      "course": "Lunch",
      "difficulty": "Intermediate",
      "prepTime": 15,
      "cookTime": 12,
      "totalTime": 27,
      "servings": 4,
      "temperature": "Medium-High",
      "station": "Sauté",
      "isActive": true,
      "allergens": ["Fish"],
      "ingredients": [
        {"name": "Salmon fillets", "amount": "4 pieces", "critical": true},
        {"name": "Olive oil", "amount": "2 tbsp", "critical": false},
        {"name": "Lemon", "amount": "1 whole", "critical": false},
        {"name": "Fresh herbs", "amount": "2 tbsp", "critical": false},
      ],
      "steps": [
        {"step": 1, "instruction": "Pat salmon dry and season", "time": 3, "critical": true},
        {"step": 2, "instruction": "Heat oil in pan until shimmering", "time": 2, "critical": true},
        {"step": 3, "instruction": "Place salmon skin-side up", "time": 1, "critical": true},
        {"step": 4, "instruction": "Cook 4-5 minutes without moving", "time": 5, "critical": true},
        {"step": 5, "instruction": "Flip and cook 3-4 minutes more", "time": 4, "critical": true},
      ],
      "techniques": ["Pan-searing", "Temperature control"],
      "equipment": ["Non-stick pan", "Fish spatula"],
      "tips": "Don't move fish until ready to flip",
      "plating": "Skin-side down, garnish with lemon and herbs",
      "lastUpdated": "2024-01-13",
    },
    {
      "id": "CI004",
      "dishName": "Caesar Salad",
      "category": "Salad",
      "course": "Appetizer",
      "difficulty": "Beginner",
      "prepTime": 20,
      "cookTime": 0,
      "totalTime": 20,
      "servings": 4,
      "temperature": "Cold",
      "station": "Cold Prep",
      "isActive": true,
      "allergens": ["Eggs", "Dairy", "Anchovies"],
      "ingredients": [
        {"name": "Romaine lettuce", "amount": "2 heads", "critical": true},
        {"name": "Caesar dressing", "amount": "1/2 cup", "critical": true},
        {"name": "Parmesan cheese", "amount": "1/2 cup", "critical": false},
        {"name": "Croutons", "amount": "1 cup", "critical": false},
      ],
      "steps": [
        {"step": 1, "instruction": "Wash and chop romaine lettuce", "time": 8, "critical": true},
        {"step": 2, "instruction": "Prepare Caesar dressing", "time": 10, "critical": true},
        {"step": 3, "instruction": "Toss lettuce with dressing", "time": 2, "critical": true},
      ],
      "techniques": ["Knife skills", "Emulsification"],
      "equipment": ["Chef's knife", "Mixing bowl"],
      "tips": "Keep lettuce crisp and cold",
      "plating": "Top with parmesan and croutons",
      "lastUpdated": "2024-01-12",
    },
    {
      "id": "CI005",
      "dishName": "Mushroom Risotto",
      "category": "Main Course",
      "course": "Dinner",
      "difficulty": "Advanced",
      "prepTime": 15,
      "cookTime": 25,
      "totalTime": 40,
      "servings": 4,
      "temperature": "Medium",
      "station": "Sauté",
      "isActive": false,
      "allergens": ["Dairy"],
      "ingredients": [
        {"name": "Arborio rice", "amount": "1 cup", "critical": true},
        {"name": "Mushrooms", "amount": "8 oz", "critical": true},
        {"name": "Chicken stock", "amount": "4 cups", "critical": true},
        {"name": "Parmesan", "amount": "1/2 cup", "critical": false},
      ],
      "steps": [
        {"step": 1, "instruction": "Sauté mushrooms until golden", "time": 8, "critical": true},
        {"step": 2, "instruction": "Toast rice with onions", "time": 3, "critical": true},
        {"step": 3, "instruction": "Add stock ladle by ladle, stirring", "time": 18, "critical": true},
        {"step": 4, "instruction": "Finish with butter and cheese", "time": 2, "critical": false},
      ],
      "techniques": ["Sautéing", "Stirring", "Gradual addition"],
      "equipment": ["Heavy-bottom pan", "Ladle"],
      "tips": "Stir constantly for creamy texture",
      "plating": "Serve immediately while hot",
      "lastUpdated": "2024-01-11",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Appetizer", "value": "Appetizer"},
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Dessert", "value": "Dessert"},
    {"label": "Salad", "value": "Salad"},
    {"label": "Soup", "value": "Soup"},
  ];

  List<Map<String, dynamic>> courses = [
    {"label": "All", "value": "All"},
    {"label": "Breakfast", "value": "Breakfast"},
    {"label": "Lunch", "value": "Lunch"},
    {"label": "Dinner", "value": "Dinner"},
    {"label": "Brunch", "value": "Brunch"},
  ];

  List<Map<String, dynamic>> difficulties = [
    {"label": "All", "value": "All"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> get filteredInstructions {
    return cookingInstructions.where((instruction) {
      bool matchesSearch = instruction["dishName"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          instruction["id"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || instruction["category"] == selectedCategory;
      bool matchesCourse = selectedCourse == "All" || instruction["course"] == selectedCourse;
      bool matchesDifficulty = selectedDifficulty == "All" || instruction["difficulty"] == selectedDifficulty;
      bool matchesActive = !showActiveOnly || instruction["isActive"];

      return matchesSearch && matchesCategory && matchesCourse && matchesDifficulty && matchesActive;
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return infoColor;
      case "Advanced":
        return warningColor;
      case "Expert":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Appetizer":
        return Icons.restaurant_menu;
      case "Main Course":
        return Icons.dinner_dining;
      case "Dessert":
        return Icons.cake;
      case "Salad":
        return Icons.eco;
      case "Soup":
        return Icons.soup_kitchen;
      default:
        return Icons.fastfood;
    }
  }

  void _viewInstructionDetails(Map<String, dynamic> instruction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${instruction["dishName"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(instruction["difficulty"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${instruction["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${instruction["totalTime"]} min",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Overview
                    _buildDetailSection("Overview", [
                      _buildDetailRow("Station", "${instruction["station"]}"),
                      _buildDetailRow("Servings", "${instruction["servings"]} portions"),
                      _buildDetailRow("Temperature", "${instruction["temperature"]}"),
                      _buildDetailRow("Course", "${instruction["course"]}"),
                    ]),
                    
                    SizedBox(height: spMd),
                    
                    // Timing
                    _buildDetailSection("Timing", [
                      _buildDetailRow("Prep Time", "${instruction["prepTime"]} min"),
                      _buildDetailRow("Cook Time", "${instruction["cookTime"]} min"),
                      _buildDetailRow("Total Time", "${instruction["totalTime"]} min"),
                    ]),
                    
                    SizedBox(height: spMd),
                    
                    // Ingredients
                    Text(
                      "Ingredients",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...((instruction["ingredients"] as List).map((ingredient) => Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: ingredient["critical"] ? warningColor.withAlpha(30) : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: ingredient["critical"] ? Border.all(color: warningColor, width: 1) : null,
                      ),
                      child: Row(
                        children: [
                          if (ingredient["critical"])
                            Icon(
                              Icons.priority_high,
                              size: 16,
                              color: warningColor,
                            ),
                          if (ingredient["critical"])
                            SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${ingredient["name"]}",
                              style: TextStyle(
                                fontWeight: ingredient["critical"] ? FontWeight.w600 : FontWeight.normal,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "${ingredient["amount"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ))),
                    
                    SizedBox(height: spMd),
                    
                    // Steps
                    Text(
                      "Cooking Steps",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...((instruction["steps"] as List).map((step) => Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: step["critical"] ? primaryColor : disabledBoldColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "${step["step"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${step["instruction"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: step["critical"] ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${step["time"]} min",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
                    
                    SizedBox(height: spMd),
                    
                    // Tips & Plating
                    _buildDetailSection("Chef's Notes", [
                      _buildDetailRow("Tips", "${instruction["tips"]}"),
                      _buildDetailRow("Plating", "${instruction["plating"]}"),
                    ]),
                    
                    SizedBox(height: spMd),
                    
                    // Equipment & Techniques
                    Text(
                      "Equipment Needed",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: (instruction["equipment"] as List).map((equipment) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$equipment",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )).toList(),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "Techniques",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: (instruction["techniques"] as List).map((technique) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$technique",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cooking Instructions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Add new cooking instruction");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search
            QTextField(
              label: "Search instructions...",
              value: searchQuery,
              hint: "Enter dish name or ID",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Course",
                    items: courses,
                    value: selectedCourse,
                    onChanged: (value, label) {
                      selectedCourse = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Difficulty",
                    items: difficulties,
                    value: selectedDifficulty,
                    onChanged: (value, label) {
                      selectedDifficulty = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Active Only",
                        "value": true,
                        "checked": showActiveOnly,
                      }
                    ],
                    value: [
                      if (showActiveOnly)
                        {
                          "label": "Active Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showActiveOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Results Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: infoColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Found ${filteredInstructions.length} cooking instructions",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Instructions List
            if (filteredInstructions.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Instructions Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredInstructions.map((instruction) => Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: instruction["isActive"] 
                    ? Border.all(color: successColor.withAlpha(100))
                    : Border.all(color: dangerColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(instruction["difficulty"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            _getCategoryIcon(instruction["category"]),
                            color: _getDifficultyColor(instruction["difficulty"]),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${instruction["dishName"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: instruction["isActive"] ? successColor : dangerColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      instruction["isActive"] ? "Active" : "Inactive",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "${instruction["id"]} • ${instruction["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor(instruction["difficulty"]),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${instruction["difficulty"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Quick Info
                    Row(
                      children: [
                        _buildQuickInfo(Icons.access_time, "${instruction["totalTime"]} min", infoColor),
                        SizedBox(width: spMd),
                        _buildQuickInfo(Icons.restaurant, "${instruction["station"]}", warningColor),
                        SizedBox(width: spMd),
                        _buildQuickInfo(Icons.people, "${instruction["servings"]} portions", successColor),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Allergens
                    if ((instruction["allergens"] as List).isNotEmpty) ...[
                      Wrap(
                        spacing: spSm,
                        runSpacing: spSm,
                        children: (instruction["allergens"] as List).map((allergen) => Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: dangerColor.withAlpha(100)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.warning,
                                size: 12,
                                color: dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "$allergen",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                      SizedBox(height: spSm),
                    ],

                    // Actions
                    Row(
                      children: [
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () => _viewInstructionDetails(instruction),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            ss("Edit instruction: ${instruction["dishName"]}");
                          },
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.copy,
                          size: bs.sm,
                          onPressed: () {
                            ss("Instruction copied to clipboard");
                          },
                        ),
                        Spacer(),
                        Text(
                          "Updated: ${instruction["lastUpdated"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfo(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: color,
        ),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
