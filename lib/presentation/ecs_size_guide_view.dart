import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsSizeGuideView extends StatefulWidget {
  const EcsSizeGuideView({super.key});

  @override
  State<EcsSizeGuideView> createState() => _EcsSizeGuideViewState();
}

class _EcsSizeGuideViewState extends State<EcsSizeGuideView> {
  String selectedCategory = "Clothing";
  String selectedGender = "Women";
  String selectedRegion = "US";

  List<Map<String, dynamic>> categories = [
    {"label": "Women's Clothing", "value": "Women's Clothing"},
    {"label": "Men's Clothing", "value": "Men's Clothing"},
    {"label": "Shoes", "value": "Shoes"},
    {"label": "Accessories", "value": "Accessories"},
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "US", "value": "US"},
    {"label": "EU", "value": "EU"},
    {"label": "UK", "value": "UK"},
    {"label": "Asia", "value": "Asia"},
  ];

  Map<String, Map<String, List<Map<String, dynamic>>>> sizeCharts = {
    "Women's Clothing": {
      "US": [
        {"size": "XS", "bust": "32-33", "waist": "24-25", "hips": "34-35"},
        {"size": "S", "bust": "34-35", "waist": "26-27", "hips": "36-37"},
        {"size": "M", "bust": "36-37", "waist": "28-29", "hips": "38-39"},
        {"size": "L", "bust": "38-40", "waist": "30-32", "hips": "40-42"},
        {"size": "XL", "bust": "41-43", "waist": "33-35", "hips": "43-45"},
        {"size": "XXL", "bust": "44-46", "waist": "36-38", "hips": "46-48"},
      ],
      "EU": [
        {"size": "32", "bust": "32-33", "waist": "24-25", "hips": "34-35"},
        {"size": "34", "bust": "34-35", "waist": "26-27", "hips": "36-37"},
        {"size": "36", "bust": "36-37", "waist": "28-29", "hips": "38-39"},
        {"size": "38", "bust": "38-40", "waist": "30-32", "hips": "40-42"},
        {"size": "40", "bust": "41-43", "waist": "33-35", "hips": "43-45"},
        {"size": "42", "bust": "44-46", "waist": "36-38", "hips": "46-48"},
      ],
    },
    "Men's Clothing": {
      "US": [
        {"size": "XS", "chest": "32-34", "waist": "28-30", "sleeve": "32-33"},
        {"size": "S", "chest": "35-37", "waist": "30-32", "sleeve": "33-34"},
        {"size": "M", "chest": "38-40", "waist": "32-34", "sleeve": "34-35"},
        {"size": "L", "chest": "41-43", "waist": "34-36", "sleeve": "35-36"},
        {"size": "XL", "chest": "44-46", "waist": "36-38", "sleeve": "36-37"},
        {"size": "XXL", "chest": "47-49", "waist": "38-40", "sleeve": "37-38"},
      ],
    },
    "Shoes": {
      "US": [
        {"size": "5", "women": "5", "men": "3.5", "eu": "35.5", "uk": "2.5"},
        {"size": "6", "women": "6", "men": "4.5", "eu": "36", "uk": "3.5"},
        {"size": "7", "women": "7", "men": "5.5", "eu": "37.5", "uk": "4.5"},
        {"size": "8", "women": "8", "men": "6.5", "eu": "38.5", "uk": "5.5"},
        {"size": "9", "women": "9", "men": "7.5", "eu": "40", "uk": "6.5"},
        {"size": "10", "women": "10", "men": "8.5", "eu": "41", "uk": "7.5"},
        {"size": "11", "women": "11", "men": "9.5", "eu": "42.5", "uk": "8.5"},
      ],
    },
  };

  List<Map<String, dynamic>> measurementTips = [
    {
      "title": "Bust/Chest Measurement",
      "description": "Measure around the fullest part of your bust/chest, keeping the tape parallel to the floor.",
      "icon": Icons.straighten,
    },
    {
      "title": "Waist Measurement",
      "description": "Measure around your natural waistline, which is typically the narrowest part of your torso.",
      "icon": Icons.crop_free,
    },
    {
      "title": "Hip Measurement",
      "description": "Measure around the fullest part of your hips, typically 7-9 inches below your waistline.",
      "icon": Icons.height,
    },
    {
      "title": "Inseam (Pants)",
      "description": "Measure from the crotch to the bottom of the leg along the inside seam.",
      "icon": Icons.vertical_align_bottom,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>>? currentChart = sizeCharts[selectedCategory]?[selectedRegion];

    return Scaffold(
      appBar: AppBar(
        title: Text("Size Guide"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Need help? Contact our customer service");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📏 Size Guide",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Find your perfect fit with our comprehensive size guide. All measurements are in inches.",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Category and Region Selection
            Row(
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Region",
                    items: regions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Size Chart
            if (currentChart != null) ...[
              Text(
                "Size Chart - $selectedCategory ($selectedRegion)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Table Header
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      ),
                      child: Row(
                        children: currentChart.first.keys.map((key) {
                          return Expanded(
                            child: Text(
                              key.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    // Table Rows
                    ...currentChart.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> row = entry.value;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: index % 2 == 0 ? Colors.grey.withAlpha(25) : Colors.white,
                          borderRadius: index == currentChart.length - 1 
                            ? BorderRadius.vertical(bottom: Radius.circular(radiusMd))
                            : null,
                        ),
                        child: Row(
                          children: row.values.map((value) {
                            return Expanded(
                              child: Text(
                                "$value",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              SizedBox(height: spLg),
            ],

            // Measurement Tips
            Text(
              "How to Measure",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...measurementTips.map((tip) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        tip["icon"],
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${tip["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${tip["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),

            // Size Converter
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "💡 Pro Tip",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Always refer to the size chart for each brand as sizes may vary\n• When in doubt, size up for a more comfortable fit\n• Check the product description for fit details (slim, regular, relaxed)\n• Read customer reviews for sizing feedback",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Contact Support Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Still Need Help? Contact Support",
                size: bs.md,
                onPressed: () {
                  si("Redirecting to customer support...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
