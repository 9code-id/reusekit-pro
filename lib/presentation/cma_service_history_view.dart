import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaServiceHistoryView extends StatefulWidget {
  const CmaServiceHistoryView({super.key});

  @override
  State<CmaServiceHistoryView> createState() => _CmaServiceHistoryViewState();
}

class _CmaServiceHistoryViewState extends State<CmaServiceHistoryView> {
  List<Map<String, dynamic>> serviceHistory = [
    {
      "id": 1,
      "date": "2024-06-15",
      "service_type": "Oil Change",
      "mileage": 82000,
      "cost": 45.99,
      "shop": "Quick Lube Express",
      "address": "123 Main St, Downtown",
      "technician": "Mike Johnson",
      "parts_used": ["Oil Filter", "5W-30 Motor Oil"],
      "labor_hours": 0.5,
      "notes": "Regular maintenance oil change. Vehicle running smoothly.",
      "warranty": "3 months / 3,000 miles",
      "rating": 5,
      "receipt_image": "https://picsum.photos/300/400?random=1",
    },
    {
      "id": 2,
      "date": "2024-05-20",
      "service_type": "Brake Inspection",
      "mileage": 81200,
      "cost": 125.50,
      "shop": "AutoCare Center",
      "address": "456 Oak Ave, Midtown",
      "technician": "Sarah Wilson",
      "parts_used": ["Brake Fluid"],
      "labor_hours": 1.0,
      "notes": "Brake pads at 40% wear. Good for another 10,000 miles.",
      "warranty": "6 months",
      "rating": 4,
      "receipt_image": "https://picsum.photos/300/400?random=2",
    },
    {
      "id": 3,
      "date": "2024-04-10",
      "service_type": "Tire Rotation",
      "mileage": 80500,
      "cost": 35.00,
      "shop": "Tire Center Pro",
      "address": "789 Pine Rd, Uptown",
      "technician": "Carlos Martinez",
      "parts_used": [],
      "labor_hours": 0.75,
      "notes": "Tires rotated and balanced. Tire pressure adjusted.",
      "warranty": "30 days",
      "rating": 5,
      "receipt_image": "https://picsum.photos/300/400?random=3",
    },
    {
      "id": 4,
      "date": "2024-03-25",
      "service_type": "Air Filter Replacement",
      "mileage": 79800,
      "cost": 28.75,
      "shop": "Quick Lube Express",
      "address": "123 Main St, Downtown",
      "technician": "David Lee",
      "parts_used": ["Engine Air Filter"],
      "labor_hours": 0.25,
      "notes": "Old filter was very dirty. New filter installed.",
      "warranty": "12 months / 12,000 miles",
      "rating": 5,
      "receipt_image": "https://picsum.photos/300/400?random=4",
    },
    {
      "id": 5,
      "date": "2024-02-18",
      "service_type": "Battery Test",
      "mileage": 79200,
      "cost": 0.00,
      "shop": "AutoZone",
      "address": "321 Elm St, Central",
      "technician": "Store Associate",
      "parts_used": [],
      "labor_hours": 0.25,
      "notes": "Battery tested good. Terminals cleaned.",
      "warranty": "N/A",
      "rating": 4,
      "receipt_image": "https://picsum.photos/300/400?random=5",
    },
  ];

  List<Map<String, dynamic>> serviceCategories = [
    {"label": "All Services", "value": "All", "count": 15},
    {"label": "Oil Changes", "value": "Oil Change", "count": 4},
    {"label": "Brake Services", "value": "Brake", "count": 3},
    {"label": "Tire Services", "value": "Tire", "count": 2},
    {"label": "Engine Services", "value": "Engine", "count": 3},
    {"label": "Electrical", "value": "Battery", "count": 1},
    {"label": "Other", "value": "Other", "count": 2},
  ];

  String selectedCategory = "All";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredHistory = _getFilteredHistory();

    return Scaffold(
      appBar: AppBar(
        title: Text("Service History"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _showAddServiceDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search services...",
                        value: searchQuery,
                        hint: "Service type, shop, technician...",
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
                
                QHorizontalScroll(
                  children: serviceCategories.map((category) => GestureDetector(
                    onTap: () {
                      selectedCategory = category["value"];
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: selectedCategory == category["value"] 
                            ? primaryColor 
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedCategory == category["value"] 
                              ? primaryColor 
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${category["label"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedCategory == category["value"] 
                                  ? Colors.white 
                                  : disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: selectedCategory == category["value"] 
                                  ? Colors.white.withAlpha(50) 
                                  : primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${category["count"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: selectedCategory == category["value"] 
                                    ? Colors.white 
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildServiceSummary(),
                  
                  Text(
                    "Service Records (${filteredHistory.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ...filteredHistory.map((service) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getServiceTypeColor(service["service_type"]),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${service["service_type"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${DateTime.parse(service["date"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.store,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${service["shop"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${service["technician"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mileage",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${(service["mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
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
                                    "Cost",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    service["cost"] == 0.0 
                                        ? "Free" 
                                        : "\$${(service["cost"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: service["cost"] == 0.0 ? successColor : primaryColor,
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
                                    "Rating",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(5, (index) => Icon(
                                      index < (service["rating"] as int) 
                                          ? Icons.star 
                                          : Icons.star_border,
                                      color: warningColor,
                                      size: 16,
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Text(
                          "${service["notes"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        if ((service["parts_used"] as List).isNotEmpty) ...[
                          SizedBox(height: spSm),
                          Text(
                            "Parts Used:",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (service["parts_used"] as List).map((part) => Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "$part",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            )).toList(),
                          ),
                        ],
                        
                        SizedBox(height: spSm),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Receipt",
                                size: bs.sm,
                                onPressed: () {
                                  _viewReceipt(service);
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Repeat Service",
                              size: bs.sm,
                              onPressed: () {
                                _repeatService(service);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSummary() {
    double totalSpent = serviceHistory.fold(0.0, (sum, service) => sum + (service["cost"] as double));
    int totalServices = serviceHistory.length;
    double averageCost = totalServices > 0 ? totalSpent / totalServices : 0.0;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            "Service Summary",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "$totalServices",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Services",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${totalSpent.currency}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Spent",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${averageCost.currency}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Average Cost",
                      textAlign: TextAlign.center,
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
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredHistory() {
    List<Map<String, dynamic>> filtered = serviceHistory;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((service) => 
          service["service_type"].toString().contains(selectedCategory) ||
          selectedCategory == "Brake" && service["service_type"].toString().contains("Brake") ||
          selectedCategory == "Tire" && service["service_type"].toString().contains("Tire") ||
          selectedCategory == "Engine" && service["service_type"].toString().contains("Air Filter") ||
          selectedCategory == "Battery" && service["service_type"].toString().contains("Battery")
      ).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((service) => 
          service["service_type"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          service["shop"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          service["technician"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getServiceTypeColor(String serviceType) {
    switch (serviceType) {
      case "Oil Change":
        return primaryColor;
      case "Brake Inspection":
        return dangerColor;
      case "Tire Rotation":
        return warningColor;
      case "Air Filter Replacement":
        return successColor;
      case "Battery Test":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showAddServiceDialog() {
    si("Add manual service record feature coming soon");
  }

  void _showFilterDialog() {
    si("Advanced filter options coming soon");
  }

  void _viewReceipt(Map<String, dynamic> service) {
    si("Viewing receipt for ${service["service_type"]}");
  }

  void _repeatService(Map<String, dynamic> service) {
    si("Scheduling repeat service for ${service["service_type"]}");
  }
}
