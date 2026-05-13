import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBackgroundReplacementView extends StatefulWidget {
  const PpaBackgroundReplacementView({super.key});

  @override
  State<PpaBackgroundReplacementView> createState() => _PpaBackgroundReplacementViewState();
}

class _PpaBackgroundReplacementViewState extends State<PpaBackgroundReplacementView> {
  String selectedBackground = "";
  double edgeSmoothing = 0.5;
  double featherRadius = 0.3;
  bool autoDetect = true;
  String selectedPreset = "Natural";
  
  List<Map<String, dynamic>> backgroundCategories = [
    {"label": "Nature", "value": "nature"},
    {"label": "City", "value": "city"},
    {"label": "Abstract", "value": "abstract"},
    {"label": "Gradient", "value": "gradient"},
    {"label": "Solid Color", "value": "solid"},
  ];
  
  List<Map<String, dynamic>> backgrounds = [
    {
      "id": "1",
      "name": "Mountain Landscape",
      "category": "nature",
      "url": "https://picsum.photos/400/600?random=1&keyword=mountain",
      "premium": false,
    },
    {
      "id": "2", 
      "name": "City Skyline",
      "category": "city",
      "url": "https://picsum.photos/400/600?random=2&keyword=city",
      "premium": true,
    },
    {
      "id": "3",
      "name": "Ocean Sunset",
      "category": "nature", 
      "url": "https://picsum.photos/400/600?random=3&keyword=ocean",
      "premium": false,
    },
    {
      "id": "4",
      "name": "Forest Path",
      "category": "nature",
      "url": "https://picsum.photos/400/600?random=4&keyword=forest", 
      "premium": true,
    },
    {
      "id": "5",
      "name": "Studio Lighting",
      "category": "solid",
      "url": "https://picsum.photos/400/600?random=5&keyword=studio",
      "premium": false,
    },
    {
      "id": "6",
      "name": "Abstract Pattern",
      "category": "abstract",
      "url": "https://picsum.photos/400/600?random=6&keyword=abstract",
      "premium": true,
    },
  ];

  List<Map<String, dynamic>> presets = [
    {"label": "Natural", "value": "Natural"},
    {"label": "Dramatic", "value": "Dramatic"},
    {"label": "Soft", "value": "Soft"},
    {"label": "Sharp", "value": "Sharp"},
  ];

  String selectedCategory = "nature";

  List<Map<String, dynamic>> get filteredBackgrounds {
    return backgrounds.where((bg) => bg["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Background Replacement"),
        actions: [
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () {
              si("Undo last action");
            },
          ),
          IconButton(
            icon: Icon(Icons.redo),
            onPressed: () {
              si("Redo last action");
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
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Image.network(
                      "https://picsum.photos/400/300?random=100&keyword=portrait",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  if (selectedBackground.isNotEmpty)
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Background Applied",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.auto_fix_high,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Tap on areas to refine selection",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Text(
              "Background Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QCategoryPicker(
              items: backgroundCategories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            Text(
              "Available Backgrounds",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: filteredBackgrounds.map((background) {
                final isSelected = selectedBackground == background["id"];
                final isPremium = background["premium"] as bool;
                
                return GestureDetector(
                  onTap: () {
                    selectedBackground = background["id"];
                    setState(() {});
                    ss("Background '${background["name"]}' applied");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusSm),
                                topRight: Radius.circular(radiusSm),
                              ),
                              child: Image.network(
                                "${background["url"]}",
                                height: 80,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (isPremium)
                              Positioned(
                                top: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            if (isSelected)
                              Positioned(
                                top: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(spXs),
                          child: Text(
                            "${background["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            Text(
              "Replacement Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QSwitch(
              label: "Auto Detection",
              items: [
                {
                  "label": "Automatically detect subject edges",
                  "value": true,
                  "checked": autoDetect,
                }
              ],
              value: [
                if (autoDetect)
                  {
                    "label": "Automatically detect subject edges",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                autoDetect = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            QDropdownField(
              label: "Edge Preset",
              items: presets,
              value: selectedPreset,
              onChanged: (value, label) {
                selectedPreset = value;
                setState(() {});
              },
            ),
            
            Text(
              "Edge Smoothing: ${(edgeSmoothing * 100).toInt()}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Slider(
              value: edgeSmoothing,
              onChanged: (value) {
                edgeSmoothing = value;
                setState(() {});
              },
              activeColor: primaryColor,
              inactiveColor: disabledColor,
            ),
            
            Text(
              "Feather Radius: ${(featherRadius * 100).toInt()}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Slider(
              value: featherRadius,
              onChanged: (value) {
                featherRadius = value;
                setState(() {});
              },
              activeColor: primaryColor,
              inactiveColor: disabledColor,
            ),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset",
                    size: bs.md,
                    onPressed: () {
                      selectedBackground = "";
                      edgeSmoothing = 0.5;
                      featherRadius = 0.3;
                      autoDetect = true;
                      selectedPreset = "Natural";
                      setState(() {});
                      si("Settings reset to default");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Background",
                    size: bs.md,
                    onPressed: () {
                      if (selectedBackground.isEmpty) {
                        se("Please select a background first");
                        return;
                      }
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Background replacement completed!");
                      });
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
