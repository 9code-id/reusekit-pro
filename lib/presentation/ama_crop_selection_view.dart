import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaCropSelectionView extends StatefulWidget {
  const AmaCropSelectionView({super.key});

  @override
  State<AmaCropSelectionView> createState() => _AmaCropSelectionViewState();
}

class _AmaCropSelectionViewState extends State<AmaCropSelectionView> {
  String selectedCropCategory = "Cereals";
  String selectedField = "Main Field A";
  String searchQuery = "";
  
  List<Map<String, dynamic>> cropCategories = [
    {"label": "Cereals", "value": "Cereals"},
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Fruits", "value": "Fruits"},
    {"label": "Legumes", "value": "Legumes"},
    {"label": "Root Crops", "value": "Root Crops"},
    {"label": "Herbs", "value": "Herbs"},
  ];

  List<Map<String, dynamic>> fieldOptions = [
    {"label": "Main Field A", "value": "Main Field A"},
    {"label": "South Pasture", "value": "South Pasture"},
    {"label": "North Field", "value": "North Field"},
    {"label": "East Garden", "value": "East Garden"},
  ];

  List<Map<String, dynamic>> availableCrops = [
    {
      "id": 1,
      "name": "Rice",
      "category": "Cereals",
      "variety": "Basmati",
      "season": "Kharif",
      "duration": "120-150 days",
      "yield": "4-6 tons/hectare",
      "difficulty": "Medium",
      "waterReq": "High",
      "image": "https://picsum.photos/80/80?random=1&keyword=rice",
      "selected": false,
    },
    {
      "id": 2,
      "name": "Wheat",
      "category": "Cereals",
      "variety": "Hard Red",
      "season": "Rabi",
      "duration": "110-130 days",
      "yield": "3-5 tons/hectare",
      "difficulty": "Easy",
      "waterReq": "Medium",
      "image": "https://picsum.photos/80/80?random=2&keyword=wheat",
      "selected": true,
    },
    {
      "id": 3,
      "name": "Corn",
      "category": "Cereals",
      "variety": "Sweet Corn",
      "season": "Summer",
      "duration": "90-120 days",
      "yield": "8-12 tons/hectare",
      "difficulty": "Easy",
      "waterReq": "Medium",
      "image": "https://picsum.photos/80/80?random=3&keyword=corn",
      "selected": false,
    },
    {
      "id": 4,
      "name": "Tomatoes",
      "category": "Vegetables",
      "variety": "Cherry",
      "season": "All Season",
      "duration": "70-80 days",
      "yield": "40-60 tons/hectare",
      "difficulty": "Medium",
      "waterReq": "High",
      "image": "https://picsum.photos/80/80?random=4&keyword=tomato",
      "selected": false,
    },
    {
      "id": 5,
      "name": "Potatoes",
      "category": "Root Crops",
      "variety": "Russet",
      "season": "Cool Season",
      "duration": "90-120 days",
      "yield": "20-40 tons/hectare",
      "difficulty": "Easy",
      "waterReq": "Medium",
      "image": "https://picsum.photos/80/80?random=5&keyword=potato",
      "selected": true,
    },
    {
      "id": 6,
      "name": "Soybeans",
      "category": "Legumes",
      "variety": "Glycine Max",
      "season": "Summer",
      "duration": "100-130 days",
      "yield": "2-4 tons/hectare",
      "difficulty": "Easy",
      "waterReq": "Medium",
      "image": "https://picsum.photos/80/80?random=6&keyword=soybean",
      "selected": false,
    },
  ];

  List<Map<String, dynamic>> get filteredCrops {
    return availableCrops.where((crop) {
      final matchesCategory = selectedCropCategory == "All" || 
                             crop["category"] == selectedCropCategory;
      final matchesSearch = searchQuery.isEmpty ||
                           crop["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                           crop["variety"].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get selectedCrops {
    return availableCrops.where((crop) => crop["selected"] == true).toList();
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return successColor;
      case 'medium':
        return warningColor;
      case 'hard':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getWaterReqColor(String waterReq) {
    switch (waterReq.toLowerCase()) {
      case 'low':
        return successColor;
      case 'medium':
        return warningColor;
      case 'high':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Selection"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              si("Get crop recommendations based on your region");
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
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.eco,
                    color: successColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose Your Crops",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Select crops suitable for your field conditions and farming goals",
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

            if (selectedCrops.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Selected Crops (${selectedCrops.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    label: "Plan Planting",
                    size: bs.sm,
                    onPressed: () {
                      si("Navigate to planting schedule");
                    },
                  ),
                ],
              ),
              
              QHorizontalScroll(
                children: selectedCrops.map((crop) {
                  return Container(
                    width: 140,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${crop["image"]}",
                                width: double.infinity,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  crop["selected"] = false;
                                  setState(() {});
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${crop["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${crop["variety"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Crops",
                    value: searchQuery,
                    hint: "Search by name or variety",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    si("Open advanced filters");
                  },
                ),
              ],
            ),
            
            QCategoryPicker(
              label: "Crop Category",
              items: [
                {"label": "All", "value": "All"},
                ...cropCategories,
              ],
              value: selectedCropCategory,
              onChanged: (index, label, value, item) {
                selectedCropCategory = value;
                setState(() {});
              },
            ),
            
            QDropdownField(
              label: "Target Field",
              items: fieldOptions,
              value: selectedField,
              onChanged: (value, label) {
                selectedField = value;
                setState(() {});
              },
            ),
            
            Text(
              "Available Crops (${filteredCrops.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            if (filteredCrops.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      color: disabledBoldColor,
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No crops found",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or category filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            else
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredCrops.map((crop) {
                  final isSelected = crop["selected"] == true;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              child: Image.network(
                                "${crop["image"]}",
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${crop["season"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${crop["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${crop["variety"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spSm),
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Duration",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${crop["duration"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Yield",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${crop["yield"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getDifficultyColor(crop["difficulty"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${crop["difficulty"]}",
                                      style: TextStyle(
                                        color: getDifficultyColor(crop["difficulty"]),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getWaterReqColor(crop["waterReq"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${crop["waterReq"]} Water",
                                      style: TextStyle(
                                        color: getWaterReqColor(crop["waterReq"]),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: isSelected ? "Remove" : "Select Crop",
                                  size: bs.sm,
                                  onPressed: () {
                                    crop["selected"] = !isSelected;
                                    setState(() {});
                                    if (crop["selected"]) {
                                      ss("${crop["name"]} added to selection");
                                    } else {
                                      si("${crop["name"]} removed from selection");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
