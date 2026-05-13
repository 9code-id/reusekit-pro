import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSeedVarietiesView extends StatefulWidget {
  const AmaSeedVarietiesView({super.key});

  @override
  State<AmaSeedVarietiesView> createState() => _AmaSeedVarietiesViewState();
}

class _AmaSeedVarietiesViewState extends State<AmaSeedVarietiesView> {
  List<Map<String, dynamic>> seedVarieties = [
    {
      "id": 1,
      "name": "Golden Harvest Corn",
      "crop": "Corn",
      "variety": "Hybrid",
      "maturity": "90-95 days",
      "yield": "180-220 bu/acre",
      "resistance": "Drought, Pest",
      "image": "https://picsum.photos/80/80?random=1&keyword=corn",
      "description": "High-yielding hybrid corn variety with excellent drought tolerance",
      "seedsPerPound": 1800,
      "plantingDepth": "1.5-2 inches",
      "spacing": "8-12 inches",
      "soilType": "Well-drained loam",
      "price": 285.00,
      "supplier": "AgroSeeds Inc",
      "inStock": true,
      "rating": 4.7,
      "reviews": 124
    },
    {
      "id": 2,
      "name": "Premium Wheat Elite",
      "crop": "Wheat",
      "variety": "Winter Wheat",
      "maturity": "240-260 days",
      "yield": "70-85 bu/acre",
      "resistance": "Rust, Aphids",
      "image": "https://picsum.photos/80/80?random=2&keyword=wheat",
      "description": "Superior winter wheat variety with excellent disease resistance",
      "seedsPerPound": 14000,
      "plantingDepth": "1-1.5 inches",
      "spacing": "6-8 inches",
      "soilType": "Clay loam",
      "price": 95.50,
      "supplier": "GrainTech Seeds",
      "inStock": true,
      "rating": 4.5,
      "reviews": 89
    },
    {
      "id": 3,
      "name": "Emerald Soybean",
      "crop": "Soybean",
      "variety": "Determinate",
      "maturity": "110-120 days",
      "yield": "50-65 bu/acre",
      "resistance": "Nematode, Blight",
      "image": "https://picsum.photos/80/80?random=3&keyword=soybean",
      "description": "High-protein soybean variety with excellent pod retention",
      "seedsPerPound": 2800,
      "plantingDepth": "1-1.5 inches",
      "spacing": "4-6 inches",
      "soilType": "Well-drained sandy loam",
      "price": 165.00,
      "supplier": "Bean Genetics Co",
      "inStock": false,
      "rating": 4.8,
      "reviews": 156
    },
    {
      "id": 4,
      "name": "Victory Tomato",
      "crop": "Tomato",
      "variety": "Determinate",
      "maturity": "75-80 days",
      "yield": "25-30 tons/acre",
      "resistance": "Blight, Virus",
      "image": "https://picsum.photos/80/80?random=4&keyword=tomato",
      "description": "Compact determinate tomato perfect for commercial production",
      "seedsPerPound": 150000,
      "plantingDepth": "0.25 inches",
      "spacing": "18-24 inches",
      "soilType": "Rich organic soil",
      "price": 425.00,
      "supplier": "VegSeeds Pro",
      "inStock": true,
      "rating": 4.6,
      "reviews": 203
    },
    {
      "id": 5,
      "name": "Alpine Potato",
      "crop": "Potato",
      "variety": "Russet",
      "maturity": "90-110 days",
      "yield": "300-400 cwt/acre",
      "resistance": "Scab, Late Blight",
      "image": "https://picsum.photos/80/80?random=5&keyword=potato",
      "description": "Premium russet potato variety ideal for processing and fresh market",
      "seedsPerPound": 8,
      "plantingDepth": "4-6 inches",
      "spacing": "12-15 inches",
      "soilType": "Sandy loam",
      "price": 315.00,
      "supplier": "Tuber Tech",
      "inStock": true,
      "rating": 4.4,
      "reviews": 78
    }
  ];

  List<Map<String, dynamic>> filteredVarieties = [];
  String selectedCrop = "All";
  String selectedVariety = "All";
  String searchQuery = "";
  bool showOnlyInStock = false;

  List<String> cropOptions = ["All", "Corn", "Wheat", "Soybean", "Tomato", "Potato"];
  List<String> varietyOptions = ["All", "Hybrid", "Winter Wheat", "Determinate", "Russet"];

  @override
  void initState() {
    super.initState();
    filteredVarieties = seedVarieties;
  }

  void _filterVarieties() {
    filteredVarieties = seedVarieties.where((variety) {
      bool matchesCrop = selectedCrop == "All" || variety["crop"] == selectedCrop;
      bool matchesVariety = selectedVariety == "All" || variety["variety"] == selectedVariety;
      bool matchesSearch = searchQuery.isEmpty || 
          variety["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          variety["crop"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStock = !showOnlyInStock || variety["inStock"] == true;
      
      return matchesCrop && matchesVariety && matchesSearch && matchesStock;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seed Varieties"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add variety
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search varieties",
              value: searchQuery,
              hint: "Search by name or crop type",
              onChanged: (value) {
                searchQuery = value;
                _filterVarieties();
              },
            ),

            // Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Crop Type",
                    items: cropOptions.map((crop) => {
                      "label": crop,
                      "value": crop,
                    }).toList(),
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      _filterVarieties();
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Variety",
                    items: varietyOptions.map((variety) => {
                      "label": variety,
                      "value": variety,
                    }).toList(),
                    value: selectedVariety,
                    onChanged: (value, label) {
                      selectedVariety = value;
                      _filterVarieties();
                    },
                  ),
                ),
              ],
            ),

            // Stock Filter
            QSwitch(
              items: [
                {
                  "label": "Show only in stock",
                  "value": true,
                  "checked": showOnlyInStock,
                }
              ],
              value: [if (showOnlyInStock) {"label": "Show only in stock", "value": true, "checked": true}],
              onChanged: (values, ids) {
                showOnlyInStock = values.isNotEmpty;
                _filterVarieties();
              },
            ),

            // Statistics Cards
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${seedVarieties.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Varieties",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${seedVarieties.where((v) => v["inStock"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "In Stock",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${cropOptions.length - 1}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Crop Types",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Varieties List
            ...List.generate(filteredVarieties.length, (index) {
              final variety = filteredVarieties[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: variety["inStock"] == true ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      spacing: spSm,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${variety["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${variety["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: variety["inStock"] == true ? successColor : dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      variety["inStock"] == true ? "In Stock" : "Out of Stock",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${variety["crop"]} • ${variety["variety"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${variety["maturity"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.trending_up, size: 16, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${variety["yield"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ...List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < (variety["rating"] as double).floor()
                                          ? Icons.star
                                          : starIndex < (variety["rating"] as double)
                                              ? Icons.star_half
                                              : Icons.star_border,
                                      color: warningColor,
                                      size: 16,
                                    );
                                  }),
                                  SizedBox(width: 4),
                                  Text(
                                    "${(variety["rating"] as double).toStringAsFixed(1)} (${variety["reviews"]})",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "${variety["description"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  "Planting Details",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Depth: ${variety["plantingDepth"]} • Spacing: ${variety["spacing"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Soil: ${variety["soilType"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: primaryColor.withAlpha(30),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: 2,
                            children: [
                              Text(
                                "\$${((variety["price"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "per pound",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${variety["supplier"]}",
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

                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to variety details
                            },
                          ),
                        ),
                        if (variety["inStock"] == true)
                          Expanded(
                            child: QButton(
                              label: "Add to Cart",
                              size: bs.sm,
                              onPressed: () {
                                ss("Added ${variety["name"]} to cart");
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            if (filteredVarieties.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No varieties found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
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
