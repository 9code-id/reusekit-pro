import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaMealSelectionView extends StatefulWidget {
  const TtaMealSelectionView({super.key});

  @override
  State<TtaMealSelectionView> createState() => _TtaMealSelectionViewState();
}

class _TtaMealSelectionViewState extends State<TtaMealSelectionView> {
  String selectedMeal = "";
  double mealPrice = 0.0;
  String selectedDietary = "none";

  Map<String, dynamic> flightInfo = {
    "airline": "Emirates",
    "flightNumber": "EK 201",
    "route": "New York → Paris",
    "duration": "7h 15m",
    "date": "June 25, 2024",
    "class": "Economy",
  };

  List<Map<String, dynamic>> mealOptions = [
    {
      "id": "standard",
      "name": "Standard Meal",
      "description": "Regular airline meal with meat, vegetables, and dessert",
      "price": 0.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=airline-meal",
      "dietary": "Standard",
      "ingredients": "Chicken, rice, vegetables, bread, dessert",
      "calories": 650,
      "available": true,
    },
    {
      "id": "vegetarian",
      "name": "Vegetarian Meal",
      "description": "Plant-based meal with fresh vegetables and grains",
      "price": 15.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=vegetarian-meal",
      "dietary": "Vegetarian",
      "ingredients": "Quinoa, roasted vegetables, salad, fruit",
      "calories": 580,
      "available": true,
    },
    {
      "id": "halal",
      "name": "Halal Meal",
      "description": "Certified halal meal prepared according to Islamic guidelines",
      "price": 20.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=halal-meal",
      "dietary": "Halal",
      "ingredients": "Halal beef, rice pilaf, vegetables, dates",
      "calories": 720,
      "available": true,
    },
    {
      "id": "kosher",
      "name": "Kosher Meal",
      "description": "Kosher certified meal following Jewish dietary laws",
      "price": 25.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=kosher-meal",
      "dietary": "Kosher",
      "ingredients": "Kosher chicken, potatoes, green beans, challah",
      "calories": 690,
      "available": true,
    },
    {
      "id": "vegan",
      "name": "Vegan Meal",
      "description": "Completely plant-based meal with no animal products",
      "price": 18.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=vegan-meal",
      "dietary": "Vegan",
      "ingredients": "Lentil curry, brown rice, steamed broccoli, nuts",
      "calories": 520,
      "available": true,
    },
    {
      "id": "gluten_free",
      "name": "Gluten-Free Meal",
      "description": "Specially prepared meal without gluten ingredients",
      "price": 22.0,
      "image": "https://picsum.photos/300/200?random=6&keyword=gluten-free-meal",
      "dietary": "Gluten-Free",
      "ingredients": "Grilled salmon, quinoa, asparagus, rice crackers",
      "calories": 610,
      "available": true,
    },
    {
      "id": "low_sodium",
      "name": "Low Sodium Meal",
      "description": "Heart-healthy meal with reduced sodium content",
      "price": 20.0,
      "image": "https://picsum.photos/300/200?random=7&keyword=healthy-meal",
      "dietary": "Low Sodium",
      "ingredients": "Herb-crusted fish, steamed vegetables, fruit salad",
      "calories": 540,
      "available": true,
    },
    {
      "id": "diabetic",
      "name": "Diabetic-Friendly Meal",
      "description": "Balanced meal suitable for diabetic passengers",
      "price": 25.0,
      "image": "https://picsum.photos/300/200?random=8&keyword=diabetic-meal",
      "dietary": "Diabetic",
      "ingredients": "Lean protein, whole grains, fiber-rich vegetables",
      "calories": 480,
      "available": false, // Out of stock
    },
  ];

  List<Map<String, dynamic>> beverageOptions = [
    {"name": "Water", "price": 0.0, "icon": Icons.water_drop},
    {"name": "Coffee", "price": 0.0, "icon": Icons.coffee},
    {"name": "Tea", "price": 0.0, "icon": Icons.emoji_food_beverage},
    {"name": "Soft Drinks", "price": 0.0, "icon": Icons.local_drink},
    {"name": "Premium Wine", "price": 12.0, "icon": Icons.wine_bar},
    {"name": "Premium Beer", "price": 8.0, "icon": Icons.sports_bar},
    {"name": "Fresh Juice", "price": 5.0, "icon": Icons.local_bar},
  ];

  List<String> selectedBeverages = [];

  List<Map<String, dynamic>> dietaryFilters = [
    {"label": "All Meals", "value": "none"},
    {"label": "Vegetarian", "value": "vegetarian"},
    {"label": "Vegan", "value": "vegan"},
    {"label": "Halal", "value": "halal"},
    {"label": "Kosher", "value": "kosher"},
    {"label": "Gluten-Free", "value": "gluten_free"},
    {"label": "Special Diet", "value": "special"},
  ];

  double get totalBeveragePrice {
    double total = 0.0;
    for (String beverage in selectedBeverages) {
      var option = beverageOptions.firstWhere((b) => b["name"] == beverage);
      total += option["price"] as double;
    }
    return total;
  }

  double get totalMealCost {
    return mealPrice + totalBeveragePrice;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredMeals = mealOptions.where((meal) {
      if (selectedDietary == "none") return true;
      if (selectedDietary == "special") {
        return ["diabetic", "low_sodium"].contains(meal["id"]);
      }
      return meal["id"] == selectedDietary;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Selection"),
        actions: [
          IconButton(
            icon: Icon(Icons.restaurant_menu),
            onPressed: () {
              _showMealInfo();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Flight Info Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              border: Border(
                bottom: BorderSide(color: primaryColor.withAlpha(30)),
              ),
            ),
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
                            "${flightInfo["airline"]} ${flightInfo["flightNumber"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${flightInfo["route"]} • ${flightInfo["duration"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${flightInfo["date"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${flightInfo["class"]} Class",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (selectedMeal.isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Selected: $selectedMeal",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (totalMealCost > 0)
                          Text(
                            "+\$${totalMealCost.currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Dietary Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QDropdownField(
              label: "Dietary Preference",
              items: dietaryFilters,
              value: selectedDietary,
              onChanged: (value, label) {
                selectedDietary = value;
                setState(() {});
              },
            ),
          ),

          // Meal Options
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Choose Your Meal",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ...filteredMeals.map((meal) {
                    bool isSelected = selectedMeal == meal["name"];
                    bool isAvailable = meal["available"] as bool;

                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowMd],
                        border: Border.all(
                          color: isSelected
                              ? primaryColor
                              : isAvailable
                                  ? Colors.transparent
                                  : disabledColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Meal Image
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusMd),
                                  topRight: Radius.circular(radiusMd),
                                ),
                                child: Image.network(
                                  "${meal["image"]}",
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  color: isAvailable ? null : Colors.grey,
                                  colorBlendMode: isAvailable ? null : BlendMode.saturation,
                                ),
                              ),
                              if (!isAvailable)
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(100),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radiusMd),
                                        topRight: Radius.circular(radiusMd),
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spMd,
                                          vertical: spSm,
                                        ),
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "OUT OF STOCK",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${meal["dietary"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Meal Details
                          Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spSm,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${meal["name"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isAvailable ? primaryColor : disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                    if ((meal["price"] as double) > 0)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "+\$${((meal["price"] as double)).currency}",
                                          style: TextStyle(
                                            color: warningColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      )
                                    else
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "INCLUDED",
                                          style: TextStyle(
                                            color: successColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  "${meal["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    height: 1.4,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.restaurant,
                                      color: infoColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${meal["ingredients"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_fire_department,
                                      color: dangerColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${meal["calories"]} calories",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                      ),
                                    ),
                                    Spacer(),
                                    if (isAvailable)
                                      GestureDetector(
                                        onTap: () {
                                          if (isSelected) {
                                            selectedMeal = "";
                                            mealPrice = 0.0;
                                          } else {
                                            selectedMeal = meal["name"];
                                            mealPrice = meal["price"] as double;
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spMd,
                                            vertical: spSm,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected ? primaryColor : primaryColor.withAlpha(10),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                            border: Border.all(
                                              color: primaryColor,
                                            ),
                                          ),
                                          child: Text(
                                            isSelected ? "Selected" : "Select",
                                            style: TextStyle(
                                              color: isSelected ? Colors.white : primaryColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
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
                    );
                  }),

                  // Beverage Selection
                  if (selectedMeal.isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Text(
                      "Beverages",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowMd],
                      ),
                      child: Column(
                        spacing: spSm,
                        children: beverageOptions.map((beverage) {
                          bool isSelected = selectedBeverages.contains(beverage["name"]);
                          return Row(
                            children: [
                              Icon(
                                beverage["icon"],
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Text(
                                  "${beverage["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              if ((beverage["price"] as double) > 0)
                                Text(
                                  "+\$${((beverage["price"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              else
                                Text(
                                  "Free",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  if (isSelected) {
                                    selectedBeverages.remove(beverage["name"]);
                                  } else {
                                    selectedBeverages.add(beverage["name"]);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : Colors.transparent,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedMeal.isNotEmpty ? selectedMeal : "No meal selected",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  if (totalMealCost > 0)
                    Text(
                      "Total cost: \$${totalMealCost.currency}",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: spMd),
            QButton(
              label: selectedMeal.isNotEmpty ? "Confirm Meal" : "Skip",
              size: bs.md,
              onPressed: () {
                if (selectedMeal.isNotEmpty) {
                  ss("Meal selection confirmed");
                }
                back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMealInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Meal Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "• All meals are prepared fresh in our certified kitchen\n"
              "• Special dietary meals must be ordered 24 hours in advance\n"
              "• Meal service begins 1 hour after takeoff\n"
              "• Vegetarian and halal options are always available\n"
              "• Additional beverages can be purchased onboard\n"
              "• Meals include bread, dessert, and basic beverage",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () {
              back();
            },
          ),
        ],
      ),
    );
  }
}
