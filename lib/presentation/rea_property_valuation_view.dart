import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyValuationView extends StatefulWidget {
  const ReaPropertyValuationView({super.key});

  @override
  State<ReaPropertyValuationView> createState() => _ReaPropertyValuationViewState();
}

class _ReaPropertyValuationViewState extends State<ReaPropertyValuationView> {
  final formKey = GlobalKey<FormState>();
  
  String propertyType = "Apartment";
  String propertyArea = "";
  String bedrooms = "2";
  String bathrooms = "2";
  String propertyAge = "";
  String location = "";
  String neighborhood = "";
  String floorLevel = "";
  String parkingSpaces = "1";
  String amenities = "";
  
  bool showValuation = false;
  Map<String, dynamic> valuationResults = {};
  int selectedTab = 0;

  List<Map<String, dynamic>> propertyTypes = [
    {"label": "Apartment", "value": "Apartment"},
    {"label": "House", "value": "House"},
    {"label": "Condo", "value": "Condo"},
    {"label": "Townhouse", "value": "Townhouse"},
    {"label": "Villa", "value": "Villa"},
  ];

  List<Map<String, dynamic>> bedroomOptions = [
    {"label": "Studio", "value": "0"},
    {"label": "1 Bedroom", "value": "1"},
    {"label": "2 Bedrooms", "value": "2"},
    {"label": "3 Bedrooms", "value": "3"},
    {"label": "4+ Bedrooms", "value": "4"},
  ];

  List<Map<String, dynamic>> bathroomOptions = [
    {"label": "1 Bathroom", "value": "1"},
    {"label": "2 Bathrooms", "value": "2"},
    {"label": "3 Bathrooms", "value": "3"},
    {"label": "4+ Bathrooms", "value": "4"},
  ];

  List<Map<String, dynamic>> comparableProperties = [
    {
      "address": "123 Oak Street",
      "type": "Apartment",
      "area": 1200,
      "bedrooms": 2,
      "bathrooms": 2,
      "price": 485000,
      "pricePerSqft": 404,
      "soldDate": "2024-01-15",
      "distance": 0.3,
    },
    {
      "address": "456 Pine Avenue",
      "type": "Apartment",
      "area": 1150,
      "bedrooms": 2,
      "bathrooms": 2,
      "price": 465000,
      "pricePerSqft": 404,
      "soldDate": "2024-02-03",
      "distance": 0.5,
    },
    {
      "address": "789 Maple Drive",
      "type": "Apartment",
      "area": 1280,
      "bedrooms": 2,
      "bathrooms": 2,
      "price": 520000,
      "pricePerSqft": 406,
      "soldDate": "2024-01-28",
      "distance": 0.4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Valuation"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              ss("Valuation report shared");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              _buildPropertyBasicsCard(),
              _buildPropertyDetailsCard(),
              _buildLocationCard(),
              _buildFeaturesCard(),
              _buildValuateButton(),
              if (showValuation) _buildTabSection(),
              if (showValuation && selectedTab == 0) _buildValuationResultsCard(),
              if (showValuation && selectedTab == 1) _buildComparablePropertiesCard(),
              if (showValuation && selectedTab == 2) _buildMarketAnalysisCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyBasicsCard() {
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
          Row(
            children: [
              Icon(
                Icons.home,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Property Basics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Property Type",
            items: propertyTypes,
            value: propertyType,
            onChanged: (value, label) {
              propertyType = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Area (sq ft)",
                  value: propertyArea,
                  validator: Validator.required,
                  hint: "Total built-up area",
                  onChanged: (value) {
                    propertyArea = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Property Age (years)",
                  value: propertyAge,
                  validator: Validator.required,
                  onChanged: (value) {
                    propertyAge = value;
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
                  label: "Bedrooms",
                  items: bedroomOptions,
                  value: bedrooms,
                  onChanged: (value, label) {
                    bedrooms = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Bathrooms",
                  items: bathroomOptions,
                  value: bathrooms,
                  onChanged: (value, label) {
                    bathrooms = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetailsCard() {
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
          Text(
            "Property Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Floor Level",
                  value: floorLevel,
                  hint: "Which floor (for apartments)",
                  onChanged: (value) {
                    floorLevel = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Parking Spaces",
                  value: parkingSpaces,
                  onChanged: (value) {
                    parkingSpaces = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Additional Features",
            value: amenities,
            hint: "Balcony, swimming pool, gym, security, etc.",
            onChanged: (value) {
              amenities = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
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
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Location Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Full Address",
            value: location,
            validator: Validator.required,
            hint: "Street address, city, zip code",
            onChanged: (value) {
              location = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Neighborhood",
            value: neighborhood,
            hint: "Area or district name",
            onChanged: (value) {
              neighborhood = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Location is a major factor in property valuation. Nearby amenities, transport, and schools affect value.",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesCard() {
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
          Text(
            "Value-Adding Features",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: [
              _buildFeatureChip("Sea View", false),
              _buildFeatureChip("Garden", false),
              _buildFeatureChip("Swimming Pool", false),
              _buildFeatureChip("Gym", true),
              _buildFeatureChip("24/7 Security", true),
              _buildFeatureChip("Elevator", true),
              _buildFeatureChip("Balcony", true),
              _buildFeatureChip("Central AC", false),
              _buildFeatureChip("Furnished", false),
              _buildFeatureChip("Near Metro", true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String feature, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: selected 
              ? primaryColor.withValues(alpha: 0.1) 
              : disabledColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(radiusXs),
          border: Border.all(
            color: selected ? primaryColor : disabledColor,
            width: 1,
          ),
        ),
        child: Text(
          feature,
          style: TextStyle(
            fontSize: 12,
            color: selected ? primaryColor : disabledBoldColor,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildValuateButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Get Property Valuation",
        icon: Icons.assessment,
        size: bs.md,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _generateValuation();
          }
        },
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Valuation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Comparables",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 2;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 2 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Market Analysis",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValuationResultsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.assessment,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Property Valuation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: successColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Estimated Market Value",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "\$${valuationResults['estimatedValue']?.currency ?? '0'}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "\$${valuationResults['pricePerSqft']} per sq ft",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Confidence: ${valuationResults['confidence']}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lower Range:",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${valuationResults['lowerRange']?.currency ?? '0'}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upper Range:",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${valuationResults['upperRange']?.currency ?? '0'}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard(
                "Market Trend",
                "${valuationResults['marketTrend']}",
                Icons.trending_up,
                primaryColor,
              ),
              _buildMetricCard(
                "Days on Market",
                "${valuationResults['daysOnMarket']} days",
                Icons.schedule,
                infoColor,
              ),
              _buildMetricCard(
                "Property Score",
                "${valuationResults['propertyScore']}/10",
                Icons.star,
                warningColor,
              ),
              _buildMetricCard(
                "Investment Rating",
                "${valuationResults['investmentRating']}",
                Icons.assessment,
                successColor,
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save Report",
                  icon: Icons.save,
                  size: bs.sm,
                  onPressed: () {
                    ss("Valuation report saved");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Get Full Report",
                  icon: Icons.file_download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Downloading detailed report");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparablePropertiesCard() {
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
          Text(
            "Comparable Properties",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Recent sales of similar properties in your area",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ...comparableProperties.map((property) {
            DateTime soldDate = DateTime.parse("${property["soldDate"]}");
            String dateStr = "${soldDate.day}/${soldDate.month}/${soldDate.year}";
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: disabledColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: disabledColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${property["address"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(property["price"] as num).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${property["area"]} sq ft • ${property["bedrooms"]}BR • ${property["bathrooms"]}BA",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${property["pricePerSqft"]}/sq ft",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sold: $dateStr",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${property["distance"]} miles away",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildMarketAnalysisCard() {
    return Container(
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
          Text(
            "Market Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildAnalysisSection(
            "Price Trends",
            Icons.trending_up,
            "Property values in this area have increased by 8.5% over the past year. The neighborhood shows strong growth potential.",
            successColor,
          ),
          _buildAnalysisSection(
            "Market Activity",
            Icons.local_activity,
            "Average days on market: 28 days. Market is moderately active with good buyer interest.",
            primaryColor,
          ),
          _buildAnalysisSection(
            "Investment Outlook",
            Icons.insights,
            "Good investment potential with steady rental demand and capital appreciation expected.",
            infoColor,
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Market Factors",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "• New infrastructure projects planned\n• School district ratings improving\n• Low inventory driving prices up\n• Strong job growth in area",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisSection(String title, IconData icon, String description, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _generateValuation() {
    double area = double.tryParse(propertyArea) ?? 0;
    double age = double.tryParse(propertyAge) ?? 0;
    
    // Simple valuation algorithm (in real app, this would be more sophisticated)
    double basePrice = 400; // Base price per sq ft
    
    // Adjust for property type
    double typeMultiplier = propertyType == "Villa" ? 1.3 
        : propertyType == "House" ? 1.2 
        : propertyType == "Condo" ? 1.1 
        : 1.0;
    
    // Adjust for age
    double ageMultiplier = age < 5 ? 1.1 : age < 10 ? 1.05 : age < 20 ? 1.0 : 0.95;
    
    // Calculate estimated value
    double pricePerSqft = basePrice * typeMultiplier * ageMultiplier;
    double estimatedValue = area * pricePerSqft;
    
    valuationResults = {
      'estimatedValue': estimatedValue.toInt(),
      'pricePerSqft': pricePerSqft.toInt(),
      'lowerRange': (estimatedValue * 0.9).toInt(),
      'upperRange': (estimatedValue * 1.1).toInt(),
      'confidence': 85,
      'marketTrend': "Increasing",
      'daysOnMarket': 28,
      'propertyScore': 8.2,
      'investmentRating': "Good",
    };
    
    showValuation = true;
    setState(() {});
  }
}
