import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaOrganicFertilizersView extends StatefulWidget {
  const AmaOrganicFertilizersView({super.key});

  @override
  State<AmaOrganicFertilizersView> createState() => _AmaOrganicFertilizersViewState();
}

class _AmaOrganicFertilizersViewState extends State<AmaOrganicFertilizersView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedCrop = "all";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Animal Manure", "value": "animal_manure"},
    {"label": "Compost", "value": "compost"},
    {"label": "Green Manure", "value": "green_manure"},
    {"label": "Bio-fertilizer", "value": "bio_fertilizer"},
    {"label": "Liquid Organic", "value": "liquid_organic"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "All Crops", "value": "all"},
    {"label": "Rice", "value": "rice"},
    {"label": "Wheat", "value": "wheat"},
    {"label": "Vegetables", "value": "vegetables"},
    {"label": "Fruits", "value": "fruits"},
    {"label": "Legumes", "value": "legumes"},
  ];

  List<Map<String, dynamic>> organicFertilizers = [
    {
      "id": "1",
      "name": "Cow Manure",
      "category": "Animal Manure",
      "type": "Solid",
      "description": "Well-decomposed cow dung rich in organic matter",
      "nutrients": {"N": 2.5, "P": 1.0, "K": 2.0, "organic_matter": 35},
      "application_rate": "5-10 ton/ha",
      "suitable_crops": ["Rice", "Wheat", "Vegetables", "Fruits"],
      "application_time": "Before planting or during land preparation",
      "benefits": [
        "Improves soil structure",
        "Enhances water retention",
        "Provides slow-release nutrients",
        "Increases microbial activity"
      ],
      "preparation": "Compost for 3-6 months before application",
      "cost_per_ton": 150.0,
      "availability": "High",
      "storage_requirements": "Dry, covered area",
      "shelf_life": "6 months when properly stored",
      "image": "https://picsum.photos/150/150?random=31&keyword=manure"
    },
    {
      "id": "2",
      "name": "Chicken Manure",
      "category": "Animal Manure",
      "type": "Solid",
      "description": "High-nitrogen organic fertilizer from poultry",
      "nutrients": {"N": 4.0, "P": 2.5, "K": 1.5, "organic_matter": 25},
      "application_rate": "2-4 ton/ha",
      "suitable_crops": ["Vegetables", "Fruits", "Legumes"],
      "application_time": "2-3 weeks before planting",
      "benefits": [
        "High nitrogen content",
        "Quick nutrient release",
        "Improves soil fertility",
        "Rich in micronutrients"
      ],
      "preparation": "Must be composted to reduce odor and pathogens",
      "cost_per_ton": 200.0,
      "availability": "Medium",
      "storage_requirements": "Well-ventilated, dry area",
      "shelf_life": "4 months when composted",
      "image": "https://picsum.photos/150/150?random=32&keyword=chicken"
    },
    {
      "id": "3",
      "name": "Garden Compost",
      "category": "Compost",
      "type": "Solid",
      "description": "Decomposed organic matter from kitchen and garden waste",
      "nutrients": {"N": 1.5, "P": 0.8, "K": 1.2, "organic_matter": 45},
      "application_rate": "3-5 ton/ha",
      "suitable_crops": ["All crops"],
      "application_time": "Any time during growing season",
      "benefits": [
        "Excellent soil conditioner",
        "Balanced nutrient supply",
        "Enhances soil biology",
        "Improves soil pH"
      ],
      "preparation": "Compost kitchen scraps and yard waste for 6-12 months",
      "cost_per_ton": 80.0,
      "availability": "High",
      "storage_requirements": "Outdoor pile or bin",
      "shelf_life": "Indefinite when maintained properly",
      "image": "https://picsum.photos/150/150?random=33&keyword=compost"
    },
    {
      "id": "4",
      "name": "Vermicompost",
      "category": "Compost",
      "type": "Solid",
      "description": "High-quality compost produced by earthworms",
      "nutrients": {"N": 2.0, "P": 1.5, "K": 1.8, "organic_matter": 40},
      "application_rate": "1-2 ton/ha",
      "suitable_crops": ["Vegetables", "Fruits", "Herbs"],
      "application_time": "Before planting and as top dressing",
      "benefits": [
        "Superior nutrient quality",
        "Rich in beneficial microbes",
        "Excellent water retention",
        "Pest and disease suppression"
      ],
      "preparation": "Worm farming setup required, 2-3 months production cycle",
      "cost_per_ton": 300.0,
      "availability": "Medium",
      "storage_requirements": "Cool, moist environment",
      "shelf_life": "8 months when stored properly",
      "image": "https://picsum.photos/150/150?random=34&keyword=worms"
    },
    {
      "id": "5",
      "name": "Seaweed Extract",
      "category": "Liquid Organic",
      "type": "Liquid",
      "description": "Concentrated liquid fertilizer from marine algae",
      "nutrients": {"N": 1.0, "P": 0.3, "K": 4.0, "micronutrients": "High"},
      "application_rate": "2-5 L/ha diluted 1:200",
      "suitable_crops": ["All crops"],
      "application_time": "Foliar spray during growing season",
      "benefits": [
        "Rich in growth hormones",
        "Improves stress tolerance",
        "Enhances root development",
        "Natural growth stimulant"
      ],
      "preparation": "Ready to use, dilute before application",
      "cost_per_ton": 1200.0,
      "availability": "Medium",
      "storage_requirements": "Cool, dark place",
      "shelf_life": "2 years unopened, 6 months after opening",
      "image": "https://picsum.photos/150/150?random=35&keyword=seaweed"
    },
    {
      "id": "6",
      "name": "Fish Emulsion",
      "category": "Liquid Organic",
      "type": "Liquid",
      "description": "Liquid fertilizer made from fish waste",
      "nutrients": {"N": 5.0, "P": 2.0, "K": 2.0, "micronutrients": "Medium"},
      "application_rate": "10-20 L/ha diluted 1:50",
      "suitable_crops": ["Vegetables", "Fruits", "Legumes"],
      "application_time": "Every 2-3 weeks during growing season",
      "benefits": [
        "Fast-acting nitrogen",
        "Easy plant uptake",
        "Improves plant vigor",
        "Natural and safe"
      ],
      "preparation": "Dilute with water before application",
      "cost_per_ton": 800.0,
      "availability": "Medium",
      "storage_requirements": "Refrigerated storage recommended",
      "shelf_life": "1 year unopened, 3 months after opening",
      "image": "https://picsum.photos/150/150?random=36&keyword=fish"
    },
    {
      "id": "7",
      "name": "Bone Meal",
      "category": "Animal Byproduct",
      "type": "Solid",
      "description": "Ground animal bones rich in phosphorus",
      "nutrients": {"N": 3.0, "P": 15.0, "K": 0.0, "calcium": "High"},
      "application_rate": "500-1000 kg/ha",
      "suitable_crops": ["Fruits", "Vegetables", "Flowering plants"],
      "application_time": "Before planting or early growth",
      "benefits": [
        "Slow-release phosphorus",
        "Promotes root development",
        "Enhances flowering",
        "Long-lasting effect"
      ],
      "preparation": "Apply directly to soil and mix well",
      "cost_per_ton": 600.0,
      "availability": "High",
      "storage_requirements": "Dry, pest-proof containers",
      "shelf_life": "2 years when stored properly",
      "image": "https://picsum.photos/150/150?random=37&keyword=bone"
    },
    {
      "id": "8",
      "name": "Green Manure (Legumes)",
      "category": "Green Manure",
      "type": "Living",
      "description": "Nitrogen-fixing cover crops grown and incorporated into soil",
      "nutrients": {"N": 3.5, "P": 0.8, "K": 2.5, "organic_matter": 30},
      "application_rate": "15-25 kg seeds/ha",
      "suitable_crops": ["Rice", "Wheat", "Vegetables"],
      "application_time": "Grow for 6-8 weeks then incorporate",
      "benefits": [
        "Fixes atmospheric nitrogen",
        "Improves soil structure",
        "Prevents soil erosion",
        "Suppresses weeds"
      ],
      "preparation": "Plant cover crop, allow to grow, then till into soil",
      "cost_per_ton": 100.0,
      "availability": "High",
      "storage_requirements": "Seed storage in dry conditions",
      "shelf_life": "Growing season, immediate incorporation",
      "image": "https://picsum.photos/150/150?random=38&keyword=legumes"
    },
  ];

  List<Map<String, dynamic>> compostRecipes = [
    {
      "name": "Basic Compost Mix",
      "materials": [
        {"item": "Kitchen scraps", "ratio": "30%", "carbon_nitrogen": "Green"},
        {"item": "Dry leaves", "ratio": "40%", "carbon_nitrogen": "Brown"},
        {"item": "Grass clippings", "ratio": "20%", "carbon_nitrogen": "Green"},
        {"item": "Paper/cardboard", "ratio": "10%", "carbon_nitrogen": "Brown"}
      ],
      "time_to_compost": "3-6 months",
      "turning_frequency": "Every 2 weeks",
      "moisture_level": "60-70%",
      "temperature_range": "40-60°C",
      "yield": "30-50% of original volume"
    },
    {
      "name": "Quick Compost Mix",
      "materials": [
        {"item": "Fresh manure", "ratio": "25%", "carbon_nitrogen": "Green"},
        {"item": "Shredded leaves", "ratio": "35%", "carbon_nitrogen": "Brown"},
        {"item": "Food scraps", "ratio": "25%", "carbon_nitrogen": "Green"},
        {"item": "Wood chips", "ratio": "15%", "carbon_nitrogen": "Brown"}
      ],
      "time_to_compost": "6-8 weeks",
      "turning_frequency": "Weekly",
      "moisture_level": "65-75%",
      "temperature_range": "50-70°C",
      "yield": "25-40% of original volume"
    },
  ];

  List<Map<String, dynamic>> _getFilteredFertilizers() {
    return organicFertilizers.where((fertilizer) {
      bool matchesSearch = searchQuery.isEmpty ||
          fertilizer["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          fertilizer["description"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" ||
          fertilizer["category"].toLowerCase().replaceAll(' ', '_') == selectedCategory;
      
      bool matchesCrop = selectedCrop == "all" ||
          (fertilizer["suitable_crops"] as List).any((crop) => 
            crop.toLowerCase() == selectedCrop);
      
      return matchesSearch && matchesCategory && matchesCrop;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'animal manure':
        return Colors.brown;
      case 'compost':
        return Colors.green;
      case 'green manure':
        return Colors.lightGreen;
      case 'bio-fertilizer':
        return Colors.blue;
      case 'liquid organic':
        return Colors.cyan;
      case 'animal byproduct':
        return Colors.orange;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredFertilizers = _getFilteredFertilizers();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Organic Fertilizers"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Benefits Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.eco,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Benefits of Organic Fertilizers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Improves soil structure and water retention\n• Provides slow-release nutrients for sustained growth\n• Increases beneficial microbial activity\n• Environmentally safe and sustainable\n• Reduces chemical residues in crops",
                    style: TextStyle(
                      color: successColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Search and Filter
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Search & Filter",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search fertilizers...",
                          value: searchQuery,
                          hint: "Enter fertilizer name or description",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryOptions,
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
                          label: "Suitable for Crop",
                          items: cropOptions,
                          value: selectedCrop,
                          onChanged: (value, label) {
                            selectedCrop = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Fertilizer Cards
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.grass,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Organic Fertilizers (${filteredFertilizers.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if (filteredFertilizers.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No fertilizers found",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filter criteria",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ResponsiveGridView(
                      padding: EdgeInsets.all(spSm),
                      minItemWidth: 200,
                      children: filteredFertilizers.map((fertilizer) {
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              // Image and Title
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${fertilizer["image"]}",
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${fertilizer["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getCategoryColor(fertilizer["category"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${fertilizer["category"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                "${fertilizer["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Nutrients
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.green.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Nutrients (%)",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: successColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "N",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Text(
                                              "${(fertilizer["nutrients"] as Map)["N"]}%",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "P",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Colors.orange,
                                              ),
                                            ),
                                            Text(
                                              "${(fertilizer["nutrients"] as Map)["P"]}%",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "K",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Text(
                                              "${(fertilizer["nutrients"] as Map)["K"]}%",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if ((fertilizer["nutrients"] as Map).containsKey("organic_matter"))
                                          Column(
                                            children: [
                                              Text(
                                                "OM",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Colors.brown,
                                                ),
                                              ),
                                              Text(
                                                "${(fertilizer["nutrients"] as Map)["organic_matter"]}%",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Application Details
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Application Rate: ${fertilizer["application_rate"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Cost: \$${((fertilizer["cost_per_ton"] as double).toDouble()).currency}/ton",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Suitable for: ${(fertilizer["suitable_crops"] as List).take(3).join(", ")}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),

                              // Benefits (first 2)
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Key Benefits:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: primaryColor,
                                      ),
                                    ),
                                    ...(fertilizer["benefits"] as List).take(2).map((benefit) {
                                      return Text(
                                        "• $benefit",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 9,
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),

                              // Action Button
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {},
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

            // Compost Recipes
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.receipt,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "DIY Compost Recipes",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Make your own organic fertilizer at home",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  ...compostRecipes.map((recipe) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.green.withAlpha(40)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "${recipe["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: successColor,
                            ),
                          ),
                          
                          Text(
                            "Materials:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                          
                          ...(recipe["materials"] as List).map((material) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${material["item"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: material["carbon_nitrogen"] == "Green" 
                                          ? Colors.green 
                                          : Colors.brown,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${material["ratio"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),

                          // Recipe Details
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Time: ${recipe["time_to_compost"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Turn: ${recipe["turning_frequency"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Moisture: ${recipe["moisture_level"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Temp: ${recipe["temperature_range"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Try This Recipe",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Tips for Organic Fertilizing
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Organic Fertilizing Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Apply organic fertilizers 2-3 weeks before planting\n• Mix with soil thoroughly for better nutrient distribution\n• Consider soil pH when selecting organic fertilizers\n• Combine different organic sources for balanced nutrition\n• Store organic fertilizers in dry, well-ventilated areas\n• Test soil regularly to monitor nutrient levels",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
