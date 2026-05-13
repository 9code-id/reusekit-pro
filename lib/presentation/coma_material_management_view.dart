import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaMaterialManagementView extends StatefulWidget {
  const ComaMaterialManagementView({super.key});

  @override
  State<ComaMaterialManagementView> createState() => _ComaMaterialManagementViewState();
}

class _ComaMaterialManagementViewState extends State<ComaMaterialManagementView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedLocation = "All";
  bool showLowStock = false;
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Structural Materials", "value": "Structural Materials"},
    {"label": "Finishing Materials", "value": "Finishing Materials"},
    {"label": "Electrical Supplies", "value": "Electrical Supplies"},
    {"label": "Plumbing Supplies", "value": "Plumbing Supplies"},
    {"label": "Safety Equipment", "value": "Safety Equipment"},
    {"label": "Tools & Equipment", "value": "Tools & Equipment"},
    {"label": "Hardware", "value": "Hardware"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "In Stock", "value": "In Stock"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Out of Stock", "value": "Out of Stock"},
    {"label": "On Order", "value": "On Order"},
    {"label": "Reserved", "value": "Reserved"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All", "value": "All"},
    {"label": "Main Warehouse", "value": "Main Warehouse"},
    {"label": "Site Storage A", "value": "Site Storage A"},
    {"label": "Site Storage B", "value": "Site Storage B"},
    {"label": "Tool Shed", "value": "Tool Shed"},
    {"label": "Vehicle Storage", "value": "Vehicle Storage"},
  ];

  List<Map<String, dynamic>> materials = [
    {
      "id": "MAT001",
      "name": "Portland Cement - Type I",
      "category": "Structural Materials",
      "description": "High-quality Portland cement for concrete construction",
      "currentStock": 45,
      "minStock": 20,
      "maxStock": 100,
      "unit": "bags (50 lbs)",
      "unitCost": 12.50,
      "totalValue": 562.50,
      "location": "Main Warehouse",
      "status": "In Stock",
      "supplier": "ABC Cement Co.",
      "lastRestocked": "2024-02-15",
      "expiryDate": "2024-08-15",
      "reservedQuantity": 0,
      "onOrderQuantity": 0,
      "usageRate": 8.5, // per week
      "specifications": {
        "grade": "Type I",
        "strength": "4000 PSI",
        "setting_time": "Initial: 45min, Final: 6hrs"
      }
    },
    {
      "id": "MAT002",
      "name": "Steel Rebar #4 (1/2 inch)",
      "category": "Structural Materials",
      "description": "Grade 60 deformed steel reinforcement bars",
      "currentStock": 8,
      "minStock": 15,
      "maxStock": 50,
      "unit": "pieces (20 ft)",
      "unitCost": 18.75,
      "totalValue": 150.00,
      "location": "Site Storage A",
      "status": "Low Stock",
      "supplier": "Steel Supply Inc.",
      "lastRestocked": "2024-02-10",
      "expiryDate": null,
      "reservedQuantity": 5,
      "onOrderQuantity": 25,
      "usageRate": 12.0,
      "specifications": {
        "grade": "Grade 60",
        "diameter": "1/2 inch",
        "length": "20 feet",
        "weight": "1.043 lbs/ft"
      }
    },
    {
      "id": "MAT003",
      "name": "Ceramic Floor Tiles - 12x12",
      "category": "Finishing Materials",
      "description": "Premium ceramic floor tiles with anti-slip surface",
      "currentStock": 0,
      "minStock": 100,
      "maxStock": 500,
      "unit": "square feet",
      "unitCost": 4.25,
      "totalValue": 0.00,
      "location": "Main Warehouse",
      "status": "Out of Stock",
      "supplier": "Tile World",
      "lastRestocked": "2024-01-28",
      "expiryDate": null,
      "reservedQuantity": 0,
      "onOrderQuantity": 200,
      "usageRate": 35.0,
      "specifications": {
        "size": "12x12 inches",
        "thickness": "8mm",
        "finish": "Anti-slip matte",
        "color": "Neutral beige"
      }
    },
    {
      "id": "MAT004",
      "name": "Electrical Wire - 12 AWG THHN",
      "category": "Electrical Supplies",
      "description": "Copper conductor electrical wire for residential/commercial use",
      "currentStock": 2500,
      "minStock": 1000,
      "maxStock": 5000,
      "unit": "feet",
      "unitCost": 0.85,
      "totalValue": 2125.00,
      "location": "Main Warehouse",
      "status": "In Stock",
      "supplier": "Electrical Supply Co.",
      "lastRestocked": "2024-02-18",
      "expiryDate": null,
      "reservedQuantity": 500,
      "onOrderQuantity": 0,
      "usageRate": 200.0,
      "specifications": {
        "gauge": "12 AWG",
        "type": "THHN/THWN",
        "material": "Copper",
        "insulation": "Nylon jacket"
      }
    },
    {
      "id": "MAT005",
      "name": "PVC Pipe - 4 inch Schedule 40",
      "category": "Plumbing Supplies",
      "description": "Heavy-duty PVC pipe for drainage and sewer applications",
      "currentStock": 28,
      "minStock": 25,
      "maxStock": 75,
      "unit": "pieces (10 ft)",
      "unitCost": 24.50,
      "totalValue": 686.00,
      "location": "Site Storage B",
      "status": "In Stock",
      "supplier": "Plumbing Plus",
      "lastRestocked": "2024-02-12",
      "expiryDate": null,
      "reservedQuantity": 10,
      "onOrderQuantity": 0,
      "usageRate": 6.0,
      "specifications": {
        "diameter": "4 inches",
        "schedule": "Schedule 40",
        "length": "10 feet",
        "pressure_rating": "220 PSI"
      }
    },
    {
      "id": "MAT006",
      "name": "Safety Hard Hats - Class E",
      "category": "Safety Equipment",
      "description": "ANSI-compliant hard hats with electrical protection",
      "currentStock": 12,
      "minStock": 30,
      "maxStock": 100,
      "unit": "pieces",
      "unitCost": 28.95,
      "totalValue": 347.40,
      "location": "Tool Shed",
      "status": "Low Stock",
      "supplier": "Safety First Supply",
      "lastRestocked": "2024-02-05",
      "expiryDate": "2027-02-05",
      "reservedQuantity": 0,
      "onOrderQuantity": 50,
      "usageRate": 2.0,
      "specifications": {
        "class": "Class E (Electrical)",
        "standard": "ANSI Z89.1",
        "color": "High-visibility yellow",
        "adjustable": "4-point suspension"
      }
    },
    {
      "id": "MAT007",
      "name": "Circular Saw Blades - 7.25 inch",
      "category": "Tools & Equipment",
      "description": "Carbide-tipped saw blades for construction lumber",
      "currentStock": 0,
      "minStock": 10,
      "maxStock": 50,
      "unit": "pieces",
      "unitCost": 45.75,
      "totalValue": 0.00,
      "location": "Tool Shed",
      "status": "On Order",
      "supplier": "Tool Depot",
      "lastRestocked": "2024-01-20",
      "expiryDate": null,
      "reservedQuantity": 0,
      "onOrderQuantity": 25,
      "usageRate": 3.5,
      "specifications": {
        "diameter": "7.25 inches",
        "teeth": "24 carbide tips",
        "arbor": "5/8 inch",
        "material": "C-6 carbide"
      }
    },
    {
      "id": "MAT008",
      "name": "Galvanized Bolts - 1/2 x 6 inch",
      "category": "Hardware",
      "description": "Hot-dipped galvanized hex bolts with nuts and washers",
      "currentStock": 450,
      "minStock": 200,
      "maxStock": 1000,
      "unit": "pieces",
      "unitCost": 2.85,
      "totalValue": 1282.50,
      "location": "Main Warehouse",
      "status": "Reserved",
      "supplier": "Hardware Solutions",
      "lastRestocked": "2024-02-14",
      "expiryDate": null,
      "reservedQuantity": 150,
      "onOrderQuantity": 0,
      "usageRate": 25.0,
      "specifications": {
        "size": "1/2 x 6 inches",
        "grade": "Grade 5",
        "coating": "Hot-dipped galvanized",
        "includes": "Hex nut and washer"
      }
    }
  ];

  List<Map<String, dynamic>> get filteredMaterials {
    return materials.where((material) {
      bool matchesSearch = searchQuery.isEmpty ||
          (material["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (material["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (material["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || material["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || material["status"] == selectedStatus;
      bool matchesLocation = selectedLocation == "All" || material["location"] == selectedLocation;
      bool matchesLowStock = !showLowStock || (material["currentStock"] as int) <= (material["minStock"] as int);
      
      return matchesSearch && matchesCategory && matchesStatus && matchesLocation && matchesLowStock;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Stock":
        return successColor;
      case "Low Stock":
        return warningColor;
      case "Out of Stock":
        return dangerColor;
      case "On Order":
        return infoColor;
      case "Reserved":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "In Stock":
        return Icons.check_circle;
      case "Low Stock":
        return Icons.warning;
      case "Out of Stock":
        return Icons.cancel;
      case "On Order":
        return Icons.local_shipping;
      case "Reserved":
        return Icons.lock;
      default:
        return Icons.help;
    }
  }

  void _showMaterialDetails(Map<String, dynamic> material) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getStatusColor(material["status"] as String),
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${material["id"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                        Text(
                          "${material["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${material["category"]} • ${material["status"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => back(),
                    icon: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stock Information
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Stock",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${material["currentStock"]} ${material["unit"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: secondaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Value",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                                Text(
                                  "\$${((material["totalValue"] as double).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Stock Level Indicator
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Stock Level",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${((material["currentStock"] as int) / (material["maxStock"] as int) * 100).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (material["currentStock"] as int) / (material["maxStock"] as int),
                          backgroundColor: disabledColor.withAlpha(50),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getStatusColor(material["status"] as String),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Min: ${material["minStock"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                              ),
                            ),
                            Text(
                              "Max: ${material["maxStock"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spLg),
                    
                    // Description
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${material["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Inventory Details
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 150,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Reserved",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "${material["reservedQuantity"]} ${material["unit"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "On Order",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "${material["onOrderQuantity"]} ${material["unit"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Usage Rate",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "${material["usageRate"]}/week",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Unit Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "\$${((material["unitCost"] as double).toDouble()).currency}",
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
                    SizedBox(height: spLg),
                    
                    // Location and Supplier
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.location_on, color: primaryColor, size: 20),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Location",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${material["location"]}",
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
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.business, color: primaryColor, size: 20),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Supplier",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${material["supplier"]}",
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
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spLg),
                    
                    // Dates
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Restocked",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${material["lastRestocked"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: material["expiryDate"] != null 
                                  ? warningColor.withAlpha(20)
                                  : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expiry Date",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: material["expiryDate"] != null 
                                        ? warningColor
                                        : disabledColor,
                                  ),
                                ),
                                Text(
                                  material["expiryDate"] ?? "N/A",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spLg),
                    
                    // Specifications
                    Text(
                      "Specifications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (material["specifications"] as Map<String, dynamic>).entries.map((entry) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    "${entry.key.replaceAll('_', ' ').toUpperCase()}:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${entry.value}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Update Stock",
                            size: bs.sm,
                            onPressed: () {
                              // Update stock quantity
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Order More",
                            size: bs.sm,
                            onPressed: () {
                              // Create purchase order
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search materials...",
                  value: searchQuery,
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
                  _showFilterDialog();
                },
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
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Show Low Stock Toggle
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Low Stock Only",
                      "value": true,
                      "checked": showLowStock,
                    }
                  ],
                  value: [if (showLowStock) {"label": "Show Low Stock Only", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    showLowStock = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Materials List
          Text(
            "Materials (${filteredMaterials.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          if (filteredMaterials.isEmpty)
            Container(
              padding: EdgeInsets.all(sp2xl),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No materials found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filters",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredMaterials.map((material) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor(material["status"] as String).withAlpha(20),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getStatusIcon(material["status"] as String),
                            color: _getStatusColor(material["status"] as String),
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(material["status"] as String),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${material["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${material["id"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${material["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${material["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${material["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spSm),
                          
                          // Stock Level Progress
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Stock: ${material["currentStock"]} ${material["unit"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${((material["totalValue"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: (material["currentStock"] as int) / (material["maxStock"] as int),
                                backgroundColor: disabledColor.withAlpha(50),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _getStatusColor(material["status"] as String),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: disabledColor),
                              SizedBox(width: spXs),
                              Text(
                                "${material["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.business, size: 16, color: disabledColor),
                              SizedBox(width: spXs),
                              Text(
                                "${material["supplier"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () => _showMaterialDetails(material),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    int totalMaterials = materials.length;
    int lowStockCount = materials.where((m) => (m["currentStock"] as int) <= (m["minStock"] as int)).length;
    int outOfStockCount = materials.where((m) => m["status"] == "Out of Stock").length;
    int onOrderCount = materials.where((m) => (m["onOrderQuantity"] as int) > 0).length;
    
    double totalValue = materials.fold(0.0, (sum, material) => sum + (material["totalValue"] as double));
    double avgStockLevel = materials.fold(0.0, (sum, material) => 
        sum + ((material["currentStock"] as int) / (material["maxStock"] as int))) / totalMaterials;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Statistics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.inventory, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Total Materials",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$totalMaterials",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Low Stock",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$lowStockCount",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: dangerColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.cancel, color: dangerColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Out of Stock",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$outOfStockCount",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_shipping, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "On Order",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$onOrderCount",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Inventory Value",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalValue.toDouble()).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Avg. Stock Level",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(avgStockLevel * 100).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Low Stock Alerts
          Text(
            "Low Stock Alerts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...materials.where((m) => (m["currentStock"] as int) <= (m["minStock"] as int)).map((material) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(100)),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.warning,
                      color: warningColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${material["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Stock: ${material["currentStock"]} ${material["unit"]} (Min: ${material["minStock"]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.add_shopping_cart,
                    size: bs.sm,
                    onPressed: () {
                      // Order more stock
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Material Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildInventoryTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Materials"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Location",
              items: locationOptions,
              value: selectedLocation,
              onChanged: (value, label) {
                selectedLocation = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedCategory = "All";
              selectedStatus = "All";
              selectedLocation = "All";
              showLowStock = false;
              setState(() {});
              back();
            },
            child: Text("Clear All"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}
