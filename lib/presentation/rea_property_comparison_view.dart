import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyComparisonView extends StatefulWidget {
  const ReaPropertyComparisonView({super.key});

  @override
  State<ReaPropertyComparisonView> createState() => _ReaPropertyComparisonViewState();
}

class _ReaPropertyComparisonViewState extends State<ReaPropertyComparisonView> {
  List<Map<String, dynamic>> selectedProperties = [];
  String comparisonType = "Basic";
  bool showFinancialAnalysis = false;

  final List<String> comparisonTypes = ["Basic", "Detailed", "Financial", "Location"];

  List<Map<String, dynamic>> availableProperties = [
    {
      "id": "prop_001",
      "title": "Luxury Villa",
      "address": "123 Beverly Hills, CA",
      "price": 2500000,
      "type": "Villa",
      "bedrooms": 5,
      "bathrooms": 4,
      "area": 4200,
      "yearBuilt": 2020,
      "parking": 3,
      "image": "https://picsum.photos/300/200?random=1&keyword=villa",
      "agent": "Sarah Johnson",
      "rating": 4.9,
      "pricePerSqft": 595,
      "maintenance": 2500,
      "propertyTax": 25000,
      "hoaFees": 0,
      "walkScore": 75,
      "transitScore": 60,
      "bikeScore": 80,
      "schoolRating": 9,
      "crimeRate": "Low",
      "amenities": ["Pool", "Garden", "Gym", "Wine Cellar", "Home Theater"],
      "utilities": {
        "electricity": 350,
        "water": 150,
        "gas": 100,
        "internet": 80
      },
      "financing": {
        "downPayment": 500000,
        "monthlyPayment": 12500,
        "interestRate": 3.5,
        "loanTerm": 30
      }
    },
    {
      "id": "prop_002",
      "title": "Modern Penthouse",
      "address": "456 Downtown, Manhattan",
      "price": 3200000,
      "type": "Penthouse",
      "bedrooms": 3,
      "bathrooms": 3,
      "area": 2800,
      "yearBuilt": 2019,
      "parking": 2,
      "image": "https://picsum.photos/300/200?random=2&keyword=penthouse",
      "agent": "Mike Wilson",
      "rating": 4.8,
      "pricePerSqft": 1143,
      "maintenance": 1200,
      "propertyTax": 32000,
      "hoaFees": 1500,
      "walkScore": 95,
      "transitScore": 90,
      "bikeScore": 70,
      "schoolRating": 8,
      "crimeRate": "Medium",
      "amenities": ["City View", "Terrace", "Concierge", "Rooftop", "Gym"],
      "utilities": {
        "electricity": 280,
        "water": 120,
        "gas": 80,
        "internet": 100
      },
      "financing": {
        "downPayment": 640000,
        "monthlyPayment": 16000,
        "interestRate": 3.5,
        "loanTerm": 30
      }
    },
    {
      "id": "prop_003",
      "title": "Suburban Family Home",
      "address": "789 Westfield, NJ",
      "price": 850000,
      "type": "House",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2600,
      "yearBuilt": 2018,
      "parking": 2,
      "image": "https://picsum.photos/300/200?random=3&keyword=house",
      "agent": "Emily Davis",
      "rating": 4.7,
      "pricePerSqft": 327,
      "maintenance": 800,
      "propertyTax": 18000,
      "hoaFees": 0,
      "walkScore": 60,
      "transitScore": 40,
      "bikeScore": 50,
      "schoolRating": 10,
      "crimeRate": "Very Low",
      "amenities": ["Garden", "Garage", "Deck", "Storage", "Fireplace"],
      "utilities": {
        "electricity": 220,
        "water": 100,
        "gas": 120,
        "internet": 75
      },
      "financing": {
        "downPayment": 170000,
        "monthlyPayment": 4250,
        "interestRate": 3.5,
        "loanTerm": 30
      }
    },
    {
      "id": "prop_004",
      "title": "Waterfront Condo",
      "address": "321 Harbor View, FL",
      "price": 1200000,
      "type": "Condo",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1500,
      "yearBuilt": 2021,
      "parking": 1,
      "image": "https://picsum.photos/300/200?random=4&keyword=condo",
      "agent": "David Brown",
      "rating": 4.6,
      "pricePerSqft": 800,
      "maintenance": 600,
      "propertyTax": 15000,
      "hoaFees": 800,
      "walkScore": 80,
      "transitScore": 70,
      "bikeScore": 85,
      "schoolRating": 7,
      "crimeRate": "Low",
      "amenities": ["Water View", "Balcony", "Pool", "Marina", "Beach Access"],
      "utilities": {
        "electricity": 200,
        "water": 80,
        "gas": 60,
        "internet": 85
      },
      "financing": {
        "downPayment": 240000,
        "monthlyPayment": 6000,
        "interestRate": 3.5,
        "loanTerm": 30
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Comparison"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showPropertySelector,
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: _showComparisonOptions,
          ),
        ],
      ),
      body: selectedProperties.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                // Comparison Type Selector
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Comparing ${selectedProperties.length} Properties",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          if (selectedProperties.length > 2)
                            QButton(
                              label: "Clear All",
                              size: bs.sm,
                              onPressed: () {
                                selectedProperties.clear();
                                setState(() {});
                              },
                            ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      QHorizontalScroll(
                        children: comparisonTypes.map((type) {
                          bool isSelected = comparisonType == type;
                          return Container(
                            margin: EdgeInsets.only(right: spSm),
                            child: GestureDetector(
                              onTap: () {
                                comparisonType = type;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                  ),
                                ),
                                child: Text(
                                  type,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : disabledBoldColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                
                // Comparison Content
                Expanded(
                  child: _buildComparisonContent(),
                ),
              ],
            ),
      floatingActionButton: selectedProperties.isNotEmpty
          ? FloatingActionButton(
              onPressed: _showPropertySelector,
              backgroundColor: primaryColor,
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.compare_arrows,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Properties to Compare",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Add 2-4 properties to see a detailed side-by-side comparison",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Add Properties",
              size: bs.md,
              onPressed: _showPropertySelector,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonContent() {
    switch (comparisonType) {
      case "Basic":
        return _buildBasicComparison();
      case "Detailed":
        return _buildDetailedComparison();
      case "Financial":
        return _buildFinancialComparison();
      case "Location":
        return _buildLocationComparison();
      default:
        return _buildBasicComparison();
    }
  }

  Widget _buildBasicComparison() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          // Property Images
          Container(
            height: 200,
            child: Row(
              children: selectedProperties.map<Widget>((property) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      image: DecorationImage(
                        image: NetworkImage("${property["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.white, size: 16),
                              onPressed: () {
                                selectedProperties.remove(property);
                                setState(() {});
                              },
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
                              color: Colors.black.withAlpha(178),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${property["title"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spMd),
          
          // Comparison Table
          _buildComparisonTable([
            _buildComparisonRow("Price", selectedProperties.map((p) => "\$${((p["price"] as int) / 1000000).toStringAsFixed(1)}M").toList()),
            _buildComparisonRow("Type", selectedProperties.map((p) => "${p["type"]}").toList()),
            _buildComparisonRow("Bedrooms", selectedProperties.map((p) => "${p["bedrooms"]}").toList()),
            _buildComparisonRow("Bathrooms", selectedProperties.map((p) => "${p["bathrooms"]}").toList()),
            _buildComparisonRow("Area", selectedProperties.map((p) => "${p["area"]} sqft").toList()),
            _buildComparisonRow("Year Built", selectedProperties.map((p) => "${p["yearBuilt"]}").toList()),
            _buildComparisonRow("Parking", selectedProperties.map((p) => "${p["parking"]} spaces").toList()),
            _buildComparisonRow("Price/sqft", selectedProperties.map((p) => "\$${p["pricePerSqft"]}").toList()),
            _buildComparisonRow("Rating", selectedProperties.map((p) => "${p["rating"]} ⭐").toList()),
          ]),
        ],
      ),
    );
  }

  Widget _buildDetailedComparison() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          _buildComparisonTable([
            _buildComparisonRow("Property", selectedProperties.map((p) => "${p["title"]}").toList()),
            _buildComparisonRow("Address", selectedProperties.map((p) => "${p["address"]}").toList()),
            _buildComparisonRow("Price", selectedProperties.map((p) => "\$${((p["price"] as int) / 1000000).toStringAsFixed(1)}M").toList()),
            _buildComparisonRow("Type", selectedProperties.map((p) => "${p["type"]}").toList()),
            _buildComparisonRow("Bedrooms", selectedProperties.map((p) => "${p["bedrooms"]}").toList()),
            _buildComparisonRow("Bathrooms", selectedProperties.map((p) => "${p["bathrooms"]}").toList()),
            _buildComparisonRow("Area", selectedProperties.map((p) => "${p["area"]} sqft").toList()),
            _buildComparisonRow("Year Built", selectedProperties.map((p) => "${p["yearBuilt"]}").toList()),
            _buildComparisonRow("Parking", selectedProperties.map((p) => "${p["parking"]} spaces").toList()),
            _buildComparisonRow("Price/sqft", selectedProperties.map((p) => "\$${p["pricePerSqft"]}").toList()),
            _buildComparisonRow("Maintenance", selectedProperties.map((p) => "\$${p["maintenance"]}/month").toList()),
            _buildComparisonRow("Property Tax", selectedProperties.map((p) => "\$${((p["propertyTax"] as int) / 1000).toInt()}k/year").toList()),
            _buildComparisonRow("HOA Fees", selectedProperties.map((p) => p["hoaFees"] == 0 ? "None" : "\$${p["hoaFees"]}/month").toList()),
            _buildComparisonRow("Agent", selectedProperties.map((p) => "${p["agent"]}").toList()),
            _buildComparisonRow("Rating", selectedProperties.map((p) => "${p["rating"]} ⭐").toList()),
          ]),
          SizedBox(height: spMd),
          
          // Amenities Comparison
          _buildAmenitiesComparison(),
        ],
      ),
    );
  }

  Widget _buildFinancialComparison() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          // Financial Overview
          _buildComparisonTable([
            _buildComparisonRow("Purchase Price", selectedProperties.map((p) => "\$${((p["price"] as int) / 1000000).toStringAsFixed(1)}M").toList()),
            _buildComparisonRow("Down Payment", selectedProperties.map((p) => "\$${((p["financing"]["downPayment"] as int) / 1000).toInt()}k").toList()),
            _buildComparisonRow("Monthly Payment", selectedProperties.map((p) => "\$${p["financing"]["monthlyPayment"]}").toList()),
            _buildComparisonRow("Interest Rate", selectedProperties.map((p) => "${p["financing"]["interestRate"]}%").toList()),
            _buildComparisonRow("Loan Term", selectedProperties.map((p) => "${p["financing"]["loanTerm"]} years").toList()),
          ]),
          SizedBox(height: spMd),
          
          // Monthly Costs
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monthly Costs Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                _buildComparisonTable([
                  _buildComparisonRow("Mortgage Payment", selectedProperties.map((p) => "\$${p["financing"]["monthlyPayment"]}").toList()),
                  _buildComparisonRow("Property Tax", selectedProperties.map((p) => "\$${((p["propertyTax"] as int) / 12).toInt()}").toList()),
                  _buildComparisonRow("HOA Fees", selectedProperties.map((p) => p["hoaFees"] == 0 ? "\$0" : "\$${p["hoaFees"]}").toList()),
                  _buildComparisonRow("Maintenance", selectedProperties.map((p) => "\$${p["maintenance"]}").toList()),
                  _buildComparisonRow("Utilities", selectedProperties.map((p) {
                    Map<String, dynamic> utilities = p["utilities"];
                    int total = (utilities["electricity"] as int) + (utilities["water"] as int) + (utilities["gas"] as int) + (utilities["internet"] as int);
                    return "\$${total}";
                  }).toList()),
                  _buildComparisonRow("Total Monthly", selectedProperties.map((p) {
                    Map<String, dynamic> utilities = p["utilities"];
                    int utilitiesTotal = (utilities["electricity"] as int) + (utilities["water"] as int) + (utilities["gas"] as int) + (utilities["internet"] as int);
                    int total = (p["financing"]["monthlyPayment"] as int) + 
                               ((p["propertyTax"] as int) / 12).round() + 
                               (p["hoaFees"] as int) + 
                               (p["maintenance"] as int) + 
                               utilitiesTotal;
                    return "\$${total}";
                  }).toList(), isHighlight: true),
                ]),
              ],
            ),
          ),
          SizedBox(height: spMd),
          
          // Investment Analysis
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Investment Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                _buildComparisonTable([
                  _buildComparisonRow("Price per sqft", selectedProperties.map((p) => "\$${p["pricePerSqft"]}").toList()),
                  _buildComparisonRow("Total Cost of Ownership (5 years)", selectedProperties.map((p) {
                    Map<String, dynamic> utilities = p["utilities"];
                    int utilitiesTotal = (utilities["electricity"] as int) + (utilities["water"] as int) + (utilities["gas"] as int) + (utilities["internet"] as int);
                    int monthlyTotal = (p["financing"]["monthlyPayment"] as int) + 
                                     ((p["propertyTax"] as int) / 12).round() + 
                                     (p["hoaFees"] as int) + 
                                     (p["maintenance"] as int) + 
                                     utilitiesTotal;
                    int fiveYearTotal = (p["financing"]["downPayment"] as int) + (monthlyTotal * 60);
                    return "\$${(fiveYearTotal / 1000000).toStringAsFixed(2)}M";
                  }).toList()),
                  _buildComparisonRow("Est. Appreciation (5%/year)", selectedProperties.map((p) {
                    double futureValue = (p["price"] as int) * 1.27628; // 5% compound for 5 years
                    return "\$${(futureValue / 1000000).toStringAsFixed(2)}M";
                  }).toList()),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationComparison() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          // Location Scores
          _buildComparisonTable([
            _buildComparisonRow("Address", selectedProperties.map((p) => "${p["address"]}").toList()),
            _buildComparisonRow("Walk Score", selectedProperties.map((p) => "${p["walkScore"]}/100").toList()),
            _buildComparisonRow("Transit Score", selectedProperties.map((p) => "${p["transitScore"]}/100").toList()),
            _buildComparisonRow("Bike Score", selectedProperties.map((p) => "${p["bikeScore"]}/100").toList()),
            _buildComparisonRow("School Rating", selectedProperties.map((p) => "${p["schoolRating"]}/10").toList()),
            _buildComparisonRow("Crime Rate", selectedProperties.map((p) => "${p["crimeRate"]}").toList()),
          ]),
          SizedBox(height: spMd),
          
          // Location Scores Visualization
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Location Scores Comparison",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ...selectedProperties.map<Widget>((property) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${property["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spSm),
                        _buildScoreBar("Walk Score", property["walkScore"], 100),
                        _buildScoreBar("Transit Score", property["transitScore"], 100),
                        _buildScoreBar("Bike Score", property["bikeScore"], 100),
                        _buildScoreBar("School Rating", property["schoolRating"] * 10, 100),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable(List<Widget> rows) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(children: rows),
    );
  }

  Widget _buildComparisonRow(String label, List<String> values, {bool isHighlight = false}) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isHighlight ? primaryColor.withAlpha(25) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isHighlight ? primaryColor : null,
              ),
            ),
          ),
          ...values.map<Widget>((value) {
            return Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: isHighlight ? primaryColor : disabledBoldColor,
                    fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAmenitiesComparison() {
    Set<String> allAmenities = {};
    for (var property in selectedProperties) {
      allAmenities.addAll((property["amenities"] as List).cast<String>());
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Amenities Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          ...allAmenities.map<Widget>((amenity) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      amenity,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ...selectedProperties.map<Widget>((property) {
                    bool hasAmenity = (property["amenities"] as List).contains(amenity);
                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Icon(
                          hasAmenity ? Icons.check_circle : Icons.cancel,
                          color: hasAmenity ? successColor : dangerColor,
                          size: 20,
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildScoreBar(String label, int score, int maxScore) {
    double percentage = score / maxScore;
    Color color = percentage >= 0.8 ? successColor : percentage >= 0.6 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12),
              ),
              Spacer(),
              Text(
                "$score/$maxScore",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPropertySelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Properties to Compare",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "You can compare up to 4 properties at once",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: ListView.builder(
                itemCount: availableProperties.length,
                itemBuilder: (context, index) {
                  final property = availableProperties[index];
                  bool isSelected = selectedProperties.any((p) => p["id"] == property["id"]);
                  bool canSelect = selectedProperties.length < 4;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${property["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text("${property["title"]}"),
                      subtitle: Text("\$${((property["price"] as int) / 1000000).toStringAsFixed(1)}M"),
                      trailing: isSelected
                          ? Icon(Icons.check_circle, color: primaryColor)
                          : canSelect
                              ? Icon(Icons.add_circle_outline, color: primaryColor)
                              : Icon(Icons.block, color: disabledBoldColor),
                      onTap: () {
                        if (isSelected) {
                          selectedProperties.removeWhere((p) => p["id"] == property["id"]);
                        } else if (canSelect) {
                          selectedProperties.add(property);
                        } else {
                          sw("You can only compare up to 4 properties");
                        }
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Done",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
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

  void _showComparisonOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Comparison Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Comparison Type",
              items: comparisonTypes.map((type) => {
                "label": type,
                "value": type,
              }).toList(),
              value: comparisonType,
              onChanged: (value, label) {
                comparisonType = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Text("Show Financial Analysis"),
                Spacer(),
                Switch(
                  value: showFinancialAnalysis,
                  onChanged: (value) {
                    showFinancialAnalysis = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export PDF",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Comparison exported to PDF");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Comparison shared successfully");
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
