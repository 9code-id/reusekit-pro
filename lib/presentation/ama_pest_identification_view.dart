import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaPestIdentificationView extends StatefulWidget {
  const AmaPestIdentificationView({super.key});

  @override
  State<AmaPestIdentificationView> createState() => _AmaPestIdentificationViewState();
}

class _AmaPestIdentificationViewState extends State<AmaPestIdentificationView> {
  String selectedImage = "";
  String selectedCrop = "";
  String pestResults = "";
  bool isAnalyzing = false;
  String searchQuery = "";
  int currentTab = 0;
  
  List<Map<String, dynamic>> cropTypes = [
    {"label": "All Crops", "value": "all"},
    {"label": "Rice", "value": "rice"},
    {"label": "Wheat", "value": "wheat"},
    {"label": "Corn", "value": "corn"},
    {"label": "Tomato", "value": "tomato"},
    {"label": "Cotton", "value": "cotton"},
  ];

  List<Map<String, dynamic>> recentIdentifications = [
    {
      "id": "1",
      "pest": "Aphids",
      "crop": "Tomato",
      "severity": "High",
      "confidence": 94.2,
      "date": "2025-06-14",
      "image": "https://picsum.photos/150/150?random=11&keyword=insect",
      "treatment": "Apply insecticidal soap or neem oil",
      "status": "Critical",
      "type": "Insect"
    },
    {
      "id": "2",
      "pest": "Brown Planthopper",
      "crop": "Rice",
      "severity": "Medium",
      "confidence": 89.7,
      "date": "2025-06-13",
      "image": "https://picsum.photos/150/150?random=12&keyword=bug",
      "treatment": "Use resistant varieties and biological control",
      "status": "Moderate",
      "type": "Insect"
    },
    {
      "id": "3",
      "pest": "Cutworm",
      "crop": "Corn",
      "severity": "Medium",
      "confidence": 86.3,
      "date": "2025-06-12",
      "image": "https://picsum.photos/150/150?random=13&keyword=worm",
      "treatment": "Apply Bt-based insecticide in evening",
      "status": "Moderate",
      "type": "Larvae"
    },
    {
      "id": "4",
      "pest": "Spider Mites",
      "crop": "Cotton",
      "severity": "Low",
      "confidence": 82.1,
      "date": "2025-06-11",
      "image": "https://picsum.photos/150/150?random=14&keyword=mite",
      "treatment": "Increase humidity and use predatory mites",
      "status": "Watch",
      "type": "Mite"
    },
  ];

  List<Map<String, dynamic>> pestLibrary = [
    {
      "name": "Aphids",
      "type": "Insect",
      "crops": ["Tomato", "Pepper", "Cabbage", "Rose"],
      "symptoms": "Curled leaves, sticky honeydew, yellowing",
      "lifecycle": "7-10 days, multiple generations per year",
      "damage": "Sucks plant sap, transmits viruses",
      "prevention": "Encourage beneficial insects, reflective mulch",
      "treatment": "Insecticidal soap, neem oil, ladybugs",
      "image": "https://picsum.photos/120/120?random=21&keyword=aphid"
    },
    {
      "name": "Brown Planthopper",
      "type": "Insect",
      "crops": ["Rice"],
      "symptoms": "Hopperburn, yellowing from base, stunted growth",
      "lifecycle": "25-30 days, 4-6 generations per year",
      "damage": "Sucks plant sap, transmits viruses",
      "prevention": "Resistant varieties, balanced fertilization",
      "treatment": "Biological control, targeted insecticides",
      "image": "https://picsum.photos/120/120?random=22&keyword=hopper"
    },
    {
      "name": "Cutworm",
      "type": "Larvae",
      "crops": ["Corn", "Tomato", "Cabbage", "Bean"],
      "symptoms": "Cut seedlings at soil level, holes in leaves",
      "lifecycle": "30-40 days, 2-3 generations per year",
      "damage": "Cuts stems, feeds on leaves and fruit",
      "prevention": "Clean cultivation, collar barriers",
      "treatment": "Bt insecticides, handpicking, pheromone traps",
      "image": "https://picsum.photos/120/120?random=23&keyword=caterpillar"
    },
    {
      "name": "Spider Mites",
      "type": "Mite",
      "crops": ["Cotton", "Bean", "Tomato", "Strawberry"],
      "symptoms": "Fine webbing, stippled leaves, yellowing",
      "lifecycle": "5-20 days depending on temperature",
      "damage": "Sucks cell contents, reduces photosynthesis",
      "prevention": "Adequate moisture, avoid dust",
      "treatment": "Predatory mites, miticides, water spray",
      "image": "https://picsum.photos/120/120?random=24&keyword=spider"
    },
    {
      "name": "Whitefly",
      "type": "Insect",
      "crops": ["Tomato", "Cotton", "Bean", "Cabbage"],
      "symptoms": "Yellowing leaves, sticky honeydew, sooty mold",
      "lifecycle": "25-30 days, continuous generations",
      "damage": "Sucks plant sap, transmits viruses",
      "prevention": "Yellow sticky traps, silver mulch",
      "treatment": "Insecticidal soap, beneficial insects",
      "image": "https://picsum.photos/120/120?random=25&keyword=fly"
    },
    {
      "name": "Thrips",
      "type": "Insect",
      "crops": ["Onion", "Tomato", "Pepper", "Cotton"],
      "symptoms": "Silver streaks on leaves, black specks",
      "lifecycle": "15-30 days, multiple generations",
      "damage": "Rasps leaf surface, transmits viruses",
      "prevention": "Blue sticky traps, reflective mulch",
      "treatment": "Beneficial mites, systemic insecticides",
      "image": "https://picsum.photos/120/120?random=26&keyword=thrip"
    },
  ];

  List<Map<String, dynamic>> treatmentGuides = [
    {
      "method": "Biological Control",
      "description": "Use of natural enemies to control pests",
      "examples": ["Ladybugs for aphids", "Parasitic wasps", "Predatory mites"],
      "pros": "Environmentally safe, sustainable, target-specific",
      "cons": "Slower action, weather dependent",
      "icon": Icons.eco,
      "color": successColor
    },
    {
      "method": "Chemical Control",
      "description": "Use of pesticides for quick pest elimination",
      "examples": ["Insecticidal soap", "Neem oil", "Synthetic pesticides"],
      "pros": "Fast action, effective, broad spectrum",
      "cons": "Environmental impact, resistance development",
      "icon": Icons.science,
      "color": warningColor
    },
    {
      "method": "Cultural Control",
      "description": "Agricultural practices to prevent pest problems",
      "examples": ["Crop rotation", "Clean cultivation", "Resistant varieties"],
      "pros": "Preventive, cost-effective, sustainable",
      "cons": "Long-term approach, requires planning",
      "icon": Icons.agriculture,
      "color": primaryColor
    },
    {
      "method": "Physical Control",
      "description": "Mechanical methods to exclude or remove pests",
      "examples": ["Row covers", "Sticky traps", "Handpicking"],
      "pros": "No chemicals, immediate effect, precise",
      "cons": "Labor intensive, limited scale",
      "icon": Icons.build,
      "color": infoColor
    },
  ];

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
      case 'critical':
        return dangerColor;
      case 'medium':
      case 'moderate':
        return warningColor;
      case 'low':
      case 'watch':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPestTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'insect':
        return Colors.orange;
      case 'larvae':
        return Colors.red;
      case 'mite':
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  void _startIdentification() async {
    if (selectedImage.isEmpty) {
      se("Please select an image first");
      return;
    }
    
    isAnalyzing = true;
    setState(() {});
    
    // Simulate AI analysis
    await Future.delayed(Duration(seconds: 3));
    
    pestResults = "Identification Complete";
    isAnalyzing = false;
    setState(() {});
    
    ss("Pest identification completed successfully");
  }

  Widget _buildIdentificationTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // AI Identification Card
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
                    Icons.bug_report,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "AI Pest Identification",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Upload a photo of the pest to identify species and get treatment recommendations",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Select Crop Type",
                items: cropTypes,
                value: selectedCrop,
                onChanged: (value, label) {
                  selectedCrop = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QImagePicker(
                label: "Upload Pest Image",
                value: selectedImage,
                hint: "Take a clear photo of the pest",
                onChanged: (value) {
                  selectedImage = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              if (isAnalyzing)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: Colors.blue.withAlpha(40)),
                  ),
                  child: Column(
                    children: [
                      CircularProgressIndicator(color: primaryColor),
                      SizedBox(height: spSm),
                      Text(
                        "Identifying pest with AI...",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Analyzing image features and patterns",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Start Identification",
                    size: bs.md,
                    onPressed: _startIdentification,
                  ),
                ),
            ],
          ),
        ),

        // Recent Identifications
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
                    Icons.history,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Recent Identifications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              ...recentIdentifications.take(3).map((identification) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${identification["image"]}",
                          width: 60,
                          height: 60,
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
                                    "${identification["pest"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getPestTypeColor(identification["type"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${identification["type"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${identification["crop"]} • ${(identification["confidence"] as num).toStringAsFixed(1)}% confidence",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${identification["treatment"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 11,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getSeverityColor(identification["status"]),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${identification["status"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
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
      ],
    );
  }

  Widget _buildLibraryTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Search
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
                    Icons.local_library,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Pest Library",
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
                      label: "Search pests...",
                      value: searchQuery,
                      hint: "Enter pest name or crop",
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
            ],
          ),
        ),

        // Pest Cards
        ResponsiveGridView(
          padding: EdgeInsets.all(spSm),
          minItemWidth: 200,
          children: pestLibrary.map((pest) {
            return Container(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${pest["image"]}",
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${pest["name"]}",
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
                          color: _getPestTypeColor(pest["type"]),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${pest["type"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Affects: ${(pest["crops"] as List).join(", ")}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "${pest["symptoms"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 11,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
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
    );
  }

  Widget _buildTreatmentTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Treatment Methods
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
            spacing: spMd,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.healing,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Treatment Methods",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              ...treatmentGuides.map((guide) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: (guide["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: (guide["color"] as Color).withAlpha(40)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(
                            guide["icon"] as IconData,
                            color: guide["color"] as Color,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${guide["method"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: guide["color"] as Color,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${guide["description"]}",
                        style: TextStyle(
                          color: guide["color"] as Color,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Examples: ${(guide["examples"] as List).join(", ")}",
                        style: TextStyle(
                          color: (guide["color"] as Color).withAlpha(180),
                          fontSize: 11,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pros: ${guide["pros"]}",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Cons: ${guide["cons"]}",
                                  style: TextStyle(
                                    color: dangerColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // IPM Guidelines
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: primaryColor.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.integration_instructions,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Integrated Pest Management (IPM)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "IPM combines multiple pest control strategies for sustainable and effective pest management:",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                ),
              ),
              Text(
                "1. Prevention: Use resistant varieties and cultural practices\n2. Monitoring: Regular scouting and pest identification\n3. Threshold: Apply control only when needed\n4. Multiple tactics: Combine biological, cultural, and chemical controls\n5. Evaluation: Assess effectiveness and environmental impact",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Pest Identification",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Identify", icon: Icon(Icons.camera_alt)),
        Tab(text: "Library", icon: Icon(Icons.local_library)),
        Tab(text: "Treatment", icon: Icon(Icons.healing)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildIdentificationTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildLibraryTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTreatmentTab(),
        ),
      ],
    );
  }
}
