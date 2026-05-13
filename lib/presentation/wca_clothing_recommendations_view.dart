import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaClothingRecommendationsView extends StatefulWidget {
  const WcaClothingRecommendationsView({super.key});

  @override
  State<WcaClothingRecommendationsView> createState() => _WcaClothingRecommendationsViewState();
}

class _WcaClothingRecommendationsViewState extends State<WcaClothingRecommendationsView> {
  String selectedGender = "Unisex";
  String selectedActivity = "Daily Wear";
  String currentTemp = "68°F";
  String weatherCondition = "Partly Cloudy";

  List<Map<String, dynamic>> genderItems = [
    {"label": "Unisex", "value": "Unisex"},
    {"label": "Men", "value": "Men"},
    {"label": "Women", "value": "Women"},
    {"label": "Kids", "value": "Kids"},
  ];

  List<Map<String, dynamic>> activityItems = [
    {"label": "Daily Wear", "value": "Daily Wear"},
    {"label": "Business", "value": "Business"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Evening Out", "value": "Evening Out"},
    {"label": "Outdoor Activities", "value": "Outdoor Activities"},
    {"label": "Beach/Pool", "value": "Beach/Pool"},
  ];

  List<Map<String, dynamic>> clothingRecommendations = [
    {
      "category": "Upper Body",
      "items": [
        {
          "name": "Light Cotton T-Shirt",
          "description": "Breathable and comfortable for mild weather",
          "temperature": "65-75°F",
          "conditions": ["Sunny", "Partly Cloudy"],
          "activity": "Daily Wear",
          "priority": "Essential",
          "image": "https://picsum.photos/200/250?random=1&keyword=tshirt",
          "color": "success",
        },
        {
          "name": "Light Cardigan",
          "description": "Easy to remove if it gets warmer",
          "temperature": "60-70°F",
          "conditions": ["Cloudy", "Cool"],
          "activity": "Daily Wear",
          "priority": "Recommended",
          "image": "https://picsum.photos/200/250?random=2&keyword=cardigan",
          "color": "info",
        },
        {
          "name": "Long Sleeve Shirt",
          "description": "Versatile for changing weather",
          "temperature": "55-70°F",
          "conditions": ["Cool", "Windy"],
          "activity": "Business",
          "priority": "Optional",
          "image": "https://picsum.photos/200/250?random=3&keyword=shirt",
          "color": "warning",
        },
      ],
    },
    {
      "category": "Lower Body",
      "items": [
        {
          "name": "Comfortable Jeans",
          "description": "Classic and versatile for most activities",
          "temperature": "50-75°F",
          "conditions": ["Any"],
          "activity": "Daily Wear",
          "priority": "Essential",
          "image": "https://picsum.photos/200/250?random=4&keyword=jeans",
          "color": "success",
        },
        {
          "name": "Chinos",
          "description": "Smart casual option for various occasions",
          "temperature": "60-80°F",
          "conditions": ["Sunny", "Partly Cloudy"],
          "activity": "Business",
          "priority": "Recommended",
          "image": "https://picsum.photos/200/250?random=5&keyword=chinos",
          "color": "info",
        },
      ],
    },
    {
      "category": "Outerwear",
      "items": [
        {
          "name": "Light Rain Jacket",
          "description": "Essential for unpredictable weather",
          "temperature": "50-70°F",
          "conditions": ["Rainy", "Drizzle"],
          "activity": "Outdoor Activities",
          "priority": "Essential",
          "image": "https://picsum.photos/200/250?random=6&keyword=rainjacket",
          "color": "success",
        },
        {
          "name": "Denim Jacket",
          "description": "Stylish layering option",
          "temperature": "55-65°F",
          "conditions": ["Cool", "Windy"],
          "activity": "Daily Wear",
          "priority": "Optional",
          "image": "https://picsum.photos/200/250?random=7&keyword=denimjacket",
          "color": "warning",
        },
      ],
    },
    {
      "category": "Footwear",
      "items": [
        {
          "name": "Comfortable Sneakers",
          "description": "Perfect for walking and daily activities",
          "temperature": "Any",
          "conditions": ["Dry"],
          "activity": "Daily Wear",
          "priority": "Essential",
          "image": "https://picsum.photos/200/250?random=8&keyword=sneakers",
          "color": "success",
        },
        {
          "name": "Waterproof Boots",
          "description": "Keep feet dry in wet conditions",
          "temperature": "40-65°F",
          "conditions": ["Rainy", "Wet"],
          "activity": "Outdoor Activities",
          "priority": "Recommended",
          "image": "https://picsum.photos/200/250?random=9&keyword=boots",
          "color": "info",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> weatherAdvice = [
    {
      "condition": "Partly Cloudy",
      "temperature": "68°F",
      "advice": "Perfect weather for layers. Start with a light base and add as needed.",
      "tips": [
        "Bring a light jacket for evening",
        "Comfortable walking shoes recommended",
        "Sunglasses still needed for bright periods"
      ],
      "icon": Icons.wb_cloudy,
      "color": "info",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clothing Recommendations"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              si("Save clothing preferences");
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {
              si("View shopping suggestions");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), warningColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.checkroom,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weather-Based Clothing",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Smart clothing suggestions based on current weather",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_cloudy,
                    color: infoColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Weather",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "$currentTemp - $weatherCondition",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Mild",
                      style: TextStyle(
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Preferences",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Gender",
                    items: genderItems,
                    value: selectedGender,
                    onChanged: (value, label) {
                      selectedGender = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Activity",
                    items: activityItems,
                    value: selectedActivity,
                    onChanged: (value, label) {
                      selectedActivity = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.wb_cloudy,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weather Advice",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Perfect weather for layers. Start with a light base and add as needed.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...weatherAdvice[0]["tips"].map<Widget>((tip) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              tip,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            Text(
              "Recommended Clothing",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...clothingRecommendations.map((category) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.checkroom,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${category["category"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: QHorizontalScroll(
                        children: (category["items"] as List<Map<String, dynamic>>).map((item) {
                          Color priorityColor = primaryColor;
                          if (item["color"] == "success") priorityColor = successColor;
                          if (item["color"] == "info") priorityColor = infoColor;
                          if (item["color"] == "warning") priorityColor = warningColor;

                          return Container(
                            width: 200,
                            margin: EdgeInsets.only(right: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                              border: Border.all(color: priorityColor.withAlpha(50)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                                  child: Image.network(
                                    "${item["image"]}",
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(spSm),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${item["name"]}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: priorityColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${item["priority"]}",
                                              style: TextStyle(
                                                color: priorityColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spSm),
                                      Text(
                                        "${item["description"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: spSm),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.thermostat,
                                            color: priorityColor,
                                            size: 14,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${item["temperature"]}",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.sports,
                                            color: priorityColor,
                                            size: 14,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${item["activity"]}",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 11,
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
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Styling Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Layer lighter clothes that can be easily removed",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Choose breathable fabrics like cotton or linen",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Neutral colors work well in variable weather",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Keep a light jacket handy for temperature changes",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Outfit",
                    size: bs.md,
                    onPressed: () {
                      ss("Outfit saved to favorites");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Shop Items",
                    size: bs.md,
                    onPressed: () {
                      si("Opening shopping suggestions");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
