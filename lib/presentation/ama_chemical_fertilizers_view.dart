import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaChemicalFertilizersView extends StatefulWidget {
  const AmaChemicalFertilizersView({super.key});

  @override
  State<AmaChemicalFertilizersView> createState() => _AmaChemicalFertilizersViewState();
}

class _AmaChemicalFertilizersViewState extends State<AmaChemicalFertilizersView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedCrop = "all";
  String selectedFormulation = "all";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Complete NPK", "value": "complete_npk"},
    {"label": "Nitrogen", "value": "nitrogen"},
    {"label": "Phosphorus", "value": "phosphorus"},
    {"label": "Potassium", "value": "potassium"},
    {"label": "Micronutrients", "value": "micronutrients"},
    {"label": "Specialty", "value": "specialty"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "All Crops", "value": "all"},
    {"label": "Cereals", "value": "cereals"},
    {"label": "Vegetables", "value": "vegetables"},
    {"label": "Fruits", "value": "fruits"},
    {"label": "Legumes", "value": "legumes"},
    {"label": "Cash Crops", "value": "cash_crops"},
  ];

  List<Map<String, dynamic>> formulationOptions = [
    {"label": "All Forms", "value": "all"},
    {"label": "Granular", "value": "granular"},
    {"label": "Liquid", "value": "liquid"},
    {"label": "Water Soluble", "value": "water_soluble"},
    {"label": "Slow Release", "value": "slow_release"},
  ];

  List<Map<String, dynamic>> chemicalFertilizers = [
    {
      "id": "1",
      "name": "NPK 16-16-16",
      "category": "Complete NPK",
      "formulation": "Granular",
      "description": "Balanced complete fertilizer for general crop nutrition",
      "nutrients": {"N": 16, "P": 16, "K": 16, "S": 0, "Mg": 0},
      "application_rate": "200-400 kg/ha",
      "suitable_crops": ["Rice", "Wheat", "Corn", "Vegetables"],
      "growth_stages": ["Vegetative", "Flowering", "Reproductive"],
      "application_method": ["Broadcasting", "Band placement", "Side dressing"],
      "solubility": "Moderate",
      "release_pattern": "Quick release",
      "cost_per_ton": 450.0,
      "availability": "High",
      "storage_requirements": "Cool, dry place away from moisture",
      "shelf_life": "3 years when properly stored",
      "safety_precautions": [
        "Wear protective equipment during application",
        "Avoid skin and eye contact",
        "Store away from children and animals",
        "Do not mix with organic matter"
      ],
      "application_timing": "Before planting and during active growth",
      "soil_ph_range": "6.0-7.5",
      "image": "https://picsum.photos/150/150?random=41&keyword=fertilizer"
    },
    {
      "id": "2",
      "name": "Urea (46-0-0)",
      "category": "Nitrogen",
      "formulation": "Granular",
      "description": "High nitrogen fertilizer for vegetative growth",
      "nutrients": {"N": 46, "P": 0, "K": 0, "S": 0, "Mg": 0},
      "application_rate": "100-200 kg/ha",
      "suitable_crops": ["All crops requiring nitrogen"],
      "growth_stages": ["Vegetative", "Tillering"],
      "application_method": ["Broadcasting", "Side dressing", "Top dressing"],
      "solubility": "High",
      "release_pattern": "Quick release",
      "cost_per_ton": 380.0,
      "availability": "Very High",
      "storage_requirements": "Moisture-proof containers",
      "shelf_life": "Indefinite if kept dry",
      "safety_precautions": [
        "Handle with care to prevent dust inhalation",
        "Use protective masks in windy conditions",
        "Avoid application before heavy rain",
        "Do not store near heat sources"
      ],
      "application_timing": "Split applications during growing season",
      "soil_ph_range": "5.5-8.0",
      "image": "https://picsum.photos/150/150?random=42&keyword=urea"
    },
    {
      "id": "3",
      "name": "DAP (18-46-0)",
      "category": "Phosphorus",
      "formulation": "Granular",
      "description": "Diammonium phosphate for root development and flowering",
      "nutrients": {"N": 18, "P": 46, "K": 0, "S": 0, "Mg": 0},
      "application_rate": "150-250 kg/ha",
      "suitable_crops": ["Cereals", "Legumes", "Vegetables", "Fruits"],
      "growth_stages": ["Planting", "Early vegetative", "Flowering"],
      "application_method": ["Band placement", "Broadcasting", "Drill application"],
      "solubility": "High",
      "release_pattern": "Moderate release",
      "cost_per_ton": 520.0,
      "availability": "High",
      "storage_requirements": "Dry storage to prevent caking",
      "shelf_life": "2 years under proper storage",
      "safety_precautions": [
        "Avoid direct contact with skin",
        "Use in well-ventilated areas",
        "Keep away from combustible materials",
        "Wash hands thoroughly after handling"
      ],
      "application_timing": "At planting or early growth stages",
      "soil_ph_range": "6.0-7.5",
      "image": "https://picsum.photos/150/150?random=43&keyword=phosphate"
    },
    {
      "id": "4",
      "name": "Muriate of Potash (0-0-60)",
      "category": "Potassium",
      "formulation": "Granular",
      "description": "Potassium chloride for fruit quality and disease resistance",
      "nutrients": {"N": 0, "P": 0, "K": 60, "S": 0, "Mg": 0, "Cl": 47},
      "application_rate": "100-200 kg/ha",
      "suitable_crops": ["Fruits", "Vegetables", "Cash crops"],
      "growth_stages": ["Flowering", "Fruit development", "Maturity"],
      "application_method": ["Broadcasting", "Side dressing", "Fertigation"],
      "solubility": "Very High",
      "release_pattern": "Quick release",
      "cost_per_ton": 420.0,
      "availability": "High",
      "storage_requirements": "Dry, ventilated storage",
      "shelf_life": "Indefinite if kept dry",
      "safety_precautions": [
        "Avoid application on chloride-sensitive crops",
        "Prevent dust formation during handling",
        "Store separately from other fertilizers",
        "Use protective equipment"
      ],
      "application_timing": "Before flowering and fruit development",
      "soil_ph_range": "5.5-7.0",
      "image": "https://picsum.photos/150/150?random=44&keyword=potash"
    },
    {
      "id": "5",
      "name": "20-20-20 Water Soluble",
      "category": "Complete NPK",
      "formulation": "Water Soluble",
      "description": "Balanced water-soluble fertilizer for fertigation and foliar spray",
      "nutrients": {"N": 20, "P": 20, "K": 20, "Mg": 0.5, "S": 2},
      "application_rate": "5-10 kg/ha (foliar), 25-50 kg/ha (fertigation)",
      "suitable_crops": ["Vegetables", "Fruits", "Ornamentals"],
      "growth_stages": ["All stages"],
      "application_method": ["Fertigation", "Foliar spray", "Hydroponic"],
      "solubility": "Complete",
      "release_pattern": "Immediate",
      "cost_per_ton": 980.0,
      "availability": "Medium",
      "storage_requirements": "Moisture-proof packaging essential",
      "shelf_life": "2 years in original packaging",
      "safety_precautions": [
        "Prepare fresh solutions for each use",
        "Avoid mixing with incompatible chemicals",
        "Use clean water for dilution",
        "Apply during cooler parts of the day"
      ],
      "application_timing": "Weekly applications during growing season",
      "soil_ph_range": "5.5-7.0",
      "image": "https://picsum.photos/150/150?random=45&keyword=soluble"
    },
    {
      "id": "6",
      "name": "Calcium Ammonium Nitrate",
      "category": "Nitrogen",
      "formulation": "Granular",
      "description": "Nitrogen with calcium for cell wall development",
      "nutrients": {"N": 26, "P": 0, "K": 0, "Ca": 10, "Mg": 0},
      "application_rate": "150-300 kg/ha",
      "suitable_crops": ["Vegetables", "Fruits", "Cereals"],
      "growth_stages": ["Vegetative", "Fruit development"],
      "application_method": ["Top dressing", "Side dressing", "Fertigation"],
      "solubility": "High",
      "release_pattern": "Quick release",
      "cost_per_ton": 460.0,
      "availability": "Medium",
      "storage_requirements": "Cool, dry storage away from heat",
      "shelf_life": "1 year under proper conditions",
      "safety_precautions": [
        "Store away from combustible materials",
        "Handle with care due to oxidizing properties",
        "Use protective equipment",
        "Avoid contamination with organic matter"
      ],
      "application_timing": "During active growth periods",
      "soil_ph_range": "6.0-7.5",
      "image": "https://picsum.photos/150/150?random=46&keyword=calcium"
    },
    {
      "id": "7",
      "name": "Zinc Sulfate",
      "category": "Micronutrients",
      "formulation": "Water Soluble",
      "description": "Zinc micronutrient for enzyme activation and growth",
      "nutrients": {"Zn": 36, "S": 18, "N": 0, "P": 0, "K": 0},
      "application_rate": "10-25 kg/ha (soil), 0.5-1.0 kg/ha (foliar)",
      "suitable_crops": ["Rice", "Corn", "Citrus", "Vegetables"],
      "growth_stages": ["Early vegetative", "Pre-flowering"],
      "application_method": ["Soil application", "Foliar spray", "Seed treatment"],
      "solubility": "High",
      "release_pattern": "Quick release",
      "cost_per_ton": 1200.0,
      "availability": "Medium",
      "storage_requirements": "Dry storage in sealed containers",
      "shelf_life": "3 years when properly stored",
      "safety_precautions": [
        "Avoid excessive application",
        "Use precise measurement for foliar spray",
        "Do not mix with alkaline solutions",
        "Wear protective clothing"
      ],
      "application_timing": "Early morning or evening for foliar application",
      "soil_ph_range": "5.0-7.0",
      "image": "https://picsum.photos/150/150?random=47&keyword=zinc"
    },
    {
      "id": "8",
      "name": "Controlled Release NPK 15-15-15",
      "category": "Specialty",
      "formulation": "Slow Release",
      "description": "Polymer-coated fertilizer for sustained nutrient release",
      "nutrients": {"N": 15, "P": 15, "K": 15, "Mg": 2, "S": 3},
      "application_rate": "300-500 kg/ha",
      "suitable_crops": ["Fruits", "Ornamentals", "High-value crops"],
      "growth_stages": ["All stages"],
      "application_method": ["Band placement", "Broadcasting", "Container growing"],
      "solubility": "Controlled",
      "release_pattern": "3-6 months release",
      "cost_per_ton": 1800.0,
      "availability": "Low",
      "storage_requirements": "Climate-controlled storage",
      "shelf_life": "2 years under controlled conditions",
      "safety_precautions": [
        "Handle gently to avoid coating damage",
        "Store at stable temperatures",
        "Avoid mechanical damage during application",
        "Use calibrated equipment"
      ],
      "application_timing": "Single application at planting",
      "soil_ph_range": "5.5-7.5",
      "image": "https://picsum.photos/150/150?random=48&keyword=coated"
    },
  ];

  List<Map<String, dynamic>> applicationGuidelines = [
    {
      "stage": "Soil Preparation",
      "timing": "2-3 weeks before planting",
      "fertilizers": ["Complete NPK", "Phosphorus fertilizers"],
      "methods": ["Broadcasting", "Deep placement"],
      "precautions": [
        "Test soil pH before application",
        "Incorporate fertilizer into soil",
        "Avoid over-application"
      ]
    },
    {
      "stage": "Planting",
      "timing": "At time of planting",
      "fertilizers": ["Starter fertilizers", "DAP"],
      "methods": ["Band placement", "Seed drill"],
      "precautions": [
        "Keep fertilizer away from direct seed contact",
        "Use recommended spacing",
        "Ensure proper seed-fertilizer separation"
      ]
    },
    {
      "stage": "Early Growth",
      "timing": "2-4 weeks after emergence",
      "fertilizers": ["Nitrogen fertilizers", "Complete NPK"],
      "methods": ["Side dressing", "Top dressing"],
      "precautions": [
        "Apply when soil moisture is adequate",
        "Avoid application during stress periods",
        "Consider split applications"
      ]
    },
    {
      "stage": "Reproductive",
      "timing": "Flowering to fruit development",
      "fertilizers": ["Potassium fertilizers", "Micronutrients"],
      "methods": ["Fertigation", "Foliar spray"],
      "precautions": [
        "Monitor plant nutrient status",
        "Adjust application based on soil tests",
        "Avoid late-season nitrogen"
      ]
    },
  ];

  List<Map<String, dynamic>> _getFilteredFertilizers() {
    return chemicalFertilizers.where((fertilizer) {
      bool matchesSearch = searchQuery.isEmpty ||
          fertilizer["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          fertilizer["description"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" ||
          fertilizer["category"].toLowerCase().replaceAll(' ', '_') == selectedCategory;
      
      bool matchesCrop = selectedCrop == "all" ||
          (fertilizer["suitable_crops"] as List).any((crop) => 
            crop.toLowerCase().contains(selectedCrop) || selectedCrop.contains(crop.toLowerCase()));
            
      bool matchesFormulation = selectedFormulation == "all" ||
          fertilizer["formulation"].toLowerCase().replaceAll(' ', '_') == selectedFormulation;
      
      return matchesSearch && matchesCategory && matchesCrop && matchesFormulation;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'complete npk':
        return primaryColor;
      case 'nitrogen':
        return Colors.blue;
      case 'phosphorus':
        return Colors.orange;
      case 'potassium':
        return Colors.green;
      case 'micronutrients':
        return Colors.purple;
      case 'specialty':
        return Colors.red;
      default:
        return disabledBoldColor;
    }
  }

  Color _getFormulationColor(String formulation) {
    switch (formulation.toLowerCase()) {
      case 'granular':
        return Colors.brown;
      case 'liquid':
        return Colors.blue;
      case 'water soluble':
        return Colors.cyan;
      case 'slow release':
        return Colors.green;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredFertilizers = _getFilteredFertilizers();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Chemical Fertilizers"),
        actions: [
          IconButton(
            icon: Icon(Icons.science),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.warning),
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
            // Safety Warning
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Safety & Environmental Guidelines",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Always read and follow label instructions\n• Use protective equipment during handling\n• Store away from children and animals\n• Avoid over-application to prevent environmental damage\n• Consider soil testing before application",
                    style: TextStyle(
                      color: warningColor,
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
                          hint: "Enter fertilizer name or NPK ratio",
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
                          label: "Formulation",
                          items: formulationOptions,
                          value: selectedFormulation,
                          onChanged: (value, label) {
                            selectedFormulation = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QDropdownField(
                    label: "Suitable for Crop Type",
                    items: cropOptions,
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
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
                        Icons.science,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Chemical Fertilizers (${filteredFertilizers.length})",
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
                                ],
                              ),

                              // Category and Formulation Tags
                              Row(
                                children: [
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
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getFormulationColor(fertilizer["formulation"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${fertilizer["formulation"]}",
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
                                  color: primaryColor.withAlpha(20),
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
                                        color: primaryColor,
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
                                        if ((fertilizer["nutrients"] as Map).containsKey("S") && (fertilizer["nutrients"] as Map)["S"] > 0)
                                          Column(
                                            children: [
                                              Text(
                                                "S",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Colors.yellow.shade800,
                                                ),
                                              ),
                                              Text(
                                                "${(fertilizer["nutrients"] as Map)["S"]}%",
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
                                    "Rate: ${fertilizer["application_rate"]}",
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
                                    "Release: ${fertilizer["release_pattern"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    "Solubility: ${fertilizer["solubility"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),

                              // Application Methods
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
                                      "Application Methods:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${(fertilizer["application_method"] as List).join(", ")}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Safety Warning
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      color: warningColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "Follow safety precautions",
                                        style: TextStyle(
                                          color: warningColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
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

            // Application Guidelines
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
                        Icons.schedule,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Application Guidelines",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Timing and method guidelines for different growth stages",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  ...applicationGuidelines.map((guideline) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(40)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${guideline["stage"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${guideline["timing"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          
                          Text(
                            "Recommended fertilizers: ${(guideline["fertilizers"] as List).join(", ")}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                            ),
                          ),
                          
                          Text(
                            "Methods: ${(guideline["methods"] as List).join(", ")}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                          
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Precautions:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: warningColor,
                                  ),
                                ),
                                ...(guideline["precautions"] as List).map((precaution) {
                                  return Text(
                                    "• $precaution",
                                    style: TextStyle(
                                      color: warningColor,
                                      fontSize: 9,
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Important Notes
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.priority_high,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Important Considerations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Conduct soil testing before selecting fertilizers\n• Follow recommended application rates to avoid crop damage\n• Consider environmental conditions and weather forecast\n• Store fertilizers in proper conditions to maintain quality\n• Keep records of applications for future reference\n• Consider integrated nutrient management approaches",
                    style: TextStyle(
                      color: dangerColor,
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
