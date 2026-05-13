import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmPartsCatalogView extends StatefulWidget {
  const FsmPartsCatalogView({super.key});

  @override
  State<FsmPartsCatalogView> createState() => _FsmPartsCatalogViewState();
}

class _FsmPartsCatalogViewState extends State<FsmPartsCatalogView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedBrand = "All";
  String sortBy = "Name";
  bool isGridView = true;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "Mechanical", "value": "Mechanical"},
    {"label": "Hydraulic", "value": "Hydraulic"},
    {"label": "Pneumatic", "value": "Pneumatic"},
    {"label": "Safety", "value": "Safety"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Consumables", "value": "Consumables"},
  ];

  List<Map<String, dynamic>> brands = [
    {"label": "All", "value": "All"},
    {"label": "Siemens", "value": "Siemens"},
    {"label": "ABB", "value": "ABB"},
    {"label": "Schneider", "value": "Schneider"},
    {"label": "Parker", "value": "Parker"},
    {"label": "Bosch", "value": "Bosch"},
    {"label": "Fluke", "value": "Fluke"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "Name"},
    {"label": "Part Number", "value": "Part Number"},
    {"label": "Price", "value": "Price"},
    {"label": "Availability", "value": "Availability"},
  ];

  List<Map<String, dynamic>> parts = [
    {
      "id": "ELC001",
      "name": "Variable Frequency Drive",
      "description": "3-phase VFD for motor speed control, 5HP rating with built-in safety features",
      "category": "Electrical",
      "brand": "Siemens",
      "partNumber": "SINAMICS-G120C-5HP",
      "price": 1250.00,
      "availability": "In Stock",
      "leadTime": "2-3 days",
      "image": "https://picsum.photos/300/200?random=1&keyword=electrical",
      "specifications": {
        "voltage": "480V",
        "power": "5HP",
        "frequency": "50/60Hz",
        "protection": "IP20"
      },
      "supplier": "Siemens AG",
      "warranty": "24 months",
      "lastUpdated": "2025-06-18",
    },
    {
      "id": "MEC002",
      "name": "Ball Bearing Assembly",
      "description": "High-precision ball bearing for industrial machinery with sealed design",
      "category": "Mechanical",
      "brand": "SKF",
      "partNumber": "SKF-6205-2RS1",
      "price": 45.99,
      "availability": "In Stock", 
      "leadTime": "1-2 days",
      "image": "https://picsum.photos/300/200?random=2&keyword=bearing",
      "specifications": {
        "innerDiameter": "25mm",
        "outerDiameter": "52mm",
        "width": "15mm",
        "sealType": "2RS1"
      },
      "supplier": "SKF Group",
      "warranty": "12 months",
      "lastUpdated": "2025-06-17",
    },
    {
      "id": "HYD003",
      "name": "Hydraulic Pump",
      "description": "Variable displacement hydraulic pump for construction equipment",
      "category": "Hydraulic",
      "brand": "Parker",
      "partNumber": "PARKER-PV140R1K1T1NMMC",
      "price": 2850.00,
      "availability": "Low Stock",
      "leadTime": "5-7 days",
      "image": "https://picsum.photos/300/200?random=3&keyword=hydraulic",
      "specifications": {
        "displacement": "140cc/rev",
        "maxPressure": "420 bar",
        "speed": "1800 rpm",
        "flow": "252 L/min"
      },
      "supplier": "Parker Hannifin",
      "warranty": "18 months",
      "lastUpdated": "2025-06-16",
    },
    {
      "id": "SAF004",
      "name": "Safety Relay Module",
      "description": "Dual-channel safety relay for emergency stop circuits",
      "category": "Safety",
      "brand": "ABB",
      "partNumber": "ABB-RT6-24VDC",
      "price": 189.50,
      "availability": "In Stock",
      "leadTime": "1-2 days",
      "image": "https://picsum.photos/300/200?random=4&keyword=safety",
      "specifications": {
        "voltage": "24VDC",
        "contacts": "4NO+2NC",
        "safetyCategory": "Category 4",
        "response": "<5ms"
      },
      "supplier": "ABB Ltd",
      "warranty": "36 months",
      "lastUpdated": "2025-06-18",
    },
    {
      "id": "TOL005",
      "name": "Digital Multimeter",
      "description": "Professional digital multimeter with data logging capability",
      "category": "Tools",
      "brand": "Fluke",
      "partNumber": "FLUKE-87V-MAX",
      "price": 425.00,
      "availability": "In Stock",
      "leadTime": "2-3 days",
      "image": "https://picsum.photos/300/200?random=5&keyword=multimeter",
      "specifications": {
        "accuracy": "0.05%",
        "display": "6000 counts",
        "bandwidth": "100kHz",
        "safety": "CAT IV 600V"
      },
      "supplier": "Fluke Corporation",
      "warranty": "36 months",
      "lastUpdated": "2025-06-18",
    },
    {
      "id": "CON006",
      "name": "Industrial Lubricant",
      "description": "High-performance synthetic lubricant for extreme conditions",
      "category": "Consumables",
      "brand": "Shell",
      "partNumber": "SHELL-OMALA-S4-220",
      "price": 78.99,
      "availability": "In Stock",
      "leadTime": "1 day",
      "image": "https://picsum.photos/300/200?random=6&keyword=lubricant",
      "specifications": {
        "viscosity": "220 cSt",
        "temperature": "-40°C to +120°C",
        "volume": "20L",
        "type": "Synthetic"
      },
      "supplier": "Shell Lubricants",
      "warranty": "N/A",
      "lastUpdated": "2025-06-17",
    },
  ];

  List<Map<String, dynamic>> get filteredParts {
    var filtered = parts.where((part) {
      bool matchesSearch = "${part["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${part["partNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${part["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || part["category"] == selectedCategory;
      bool matchesBrand = selectedBrand == "All" || part["brand"] == selectedBrand;
      
      return matchesSearch && matchesCategory && matchesBrand;
    }).toList();

    // Sort the filtered results
    switch (sortBy) {
      case "Name":
        filtered.sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));
        break;
      case "Part Number":
        filtered.sort((a, b) => "${a["partNumber"]}".compareTo("${b["partNumber"]}"));
        break;
      case "Price":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "Availability":
        filtered.sort((a, b) => "${a["availability"]}".compareTo("${b["availability"]}"));
        break;
    }

    return filtered;
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "In Stock":
        return successColor;
      case "Low Stock":
        return warningColor;
      case "Out of Stock":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildPartCard(Map<String, dynamic> part) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Image.network(
              "${part["image"]}",
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Brand
                Text(
                  "${part["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${part["brand"]} • ${part["partNumber"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                // Price
                Text(
                  "\$${(part["price"] as double).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
                
                // Availability
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getAvailabilityColor("${part["availability"]}"),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${part["availability"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getAvailabilityColor("${part["availability"]}"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Details",
                        size: bs.sm,
                        onPressed: () {
                          // View details
                        },
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.add_shopping_cart,
                      size: bs.sm,
                      onPressed: () {
                        // Add to cart
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartListItem(Map<String, dynamic> part) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${part["image"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${part["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${part["brand"]} • ${part["partNumber"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${part["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "\$${(part["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getAvailabilityColor("${part["availability"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${part["availability"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getAvailabilityColor("${part["availability"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Actions
          Column(
            children: [
              QButton(
                icon: Icons.info,
                size: bs.sm,
                onPressed: () {
                  // View details
                },
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.add_shopping_cart,
                size: bs.sm,
                onPressed: () {
                  // Add to cart
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parts Catalog"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Search Field
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search parts, brands, or descriptions",
                          value: searchQuery,
                          hint: "Enter search terms",
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
                        onPressed: () {
                          // Perform search
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Filter Row
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
                          label: "Brand",
                          items: brands,
                          value: selectedBrand,
                          onChanged: (value, label) {
                            selectedBrand = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: sortOptions,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Parts Found (${filteredParts.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  isGridView ? "Grid View" : "List View",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            // Parts Grid/List
            if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredParts.map((part) => _buildPartCard(part)).toList(),
              )
            else
              Column(
                children: filteredParts.map((part) => _buildPartListItem(part)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
