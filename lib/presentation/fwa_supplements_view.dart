import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaSupplementsView extends StatefulWidget {
  const FwaSupplementsView({super.key});

  @override
  State<FwaSupplementsView> createState() => _FwaSupplementsViewState();
}

class _FwaSupplementsViewState extends State<FwaSupplementsView> {
  String selectedFilter = "All";
  bool showCompleted = true;  
  final List<String> filterOptions = ["All", "Vitamins", "Minerals", "Protein", "Herbs", "Others"];
  
  final List<Map<String, dynamic>> supplements = [
    {
      "id": "1",
      "name": "Vitamin D3",
      "brand": "Nature Made",
      "category": "Vitamins",
      "dosage": "2000 IU",
      "form": "Capsule",
      "frequency": "Once daily",
      "timeOfDay": ["Morning"],
      "withFood": true,
      "stock": 45,
      "lowStockThreshold": 10,
      "notes": "Take with breakfast for better absorption",
      "image": "https://picsum.photos/80/80?random=1&keyword=vitamin",
      "isActive": true,
      "nextDose": DateTime.now().add(Duration(hours: 8)),
      "completedToday": true,
      "benefits": ["Bone health", "Immune support", "Mood regulation"],
      "sideEffects": ["Nausea if taken on empty stomach"],
      "price": 25.99,
      "expiryDate": DateTime.now().add(Duration(days: 365)),
    },
    {
      "id": "2",
      "name": "Omega-3 Fish Oil",
      "brand": "Nordic Naturals",
      "category": "Others",
      "dosage": "1000mg EPA/DHA",
      "form": "Softgel",
      "frequency": "Twice daily",
      "timeOfDay": ["Morning", "Evening"],
      "withFood": true,
      "stock": 28,
      "lowStockThreshold": 15,
      "notes": "Take with meals to reduce fishy aftertaste",
      "image": "https://picsum.photos/80/80?random=2&keyword=omega3",
      "isActive": true,
      "nextDose": DateTime.now().add(Duration(hours: 2)),
      "completedToday": false,
      "benefits": ["Heart health", "Brain function", "Joint support"],
      "sideEffects": ["Fishy aftertaste", "Stomach upset"],
      "price": 42.50,
      "expiryDate": DateTime.now().add(Duration(days: 300)),
    },
    {
      "id": "3",
      "name": "Magnesium Glycinate",
      "brand": "Doctor's Best",
      "category": "Minerals",
      "dosage": "200mg",
      "form": "Tablet",
      "frequency": "Once daily",
      "timeOfDay": ["Evening"],
      "withFood": false,
      "stock": 8,
      "lowStockThreshold": 10,
      "notes": "Take before bedtime for better sleep",
      "image": "https://picsum.photos/80/80?random=3&keyword=magnesium",
      "isActive": true,
      "nextDose": DateTime.now().add(Duration(hours: 10)),
      "completedToday": true,
      "benefits": ["Sleep quality", "Muscle relaxation", "Stress relief"],
      "sideEffects": ["Drowsiness", "Diarrhea if overdosed"],
      "price": 18.95,
      "expiryDate": DateTime.now().add(Duration(days: 400)),
    },
    {
      "id": "4",
      "name": "Whey Protein Isolate",
      "brand": "Optimum Nutrition",
      "category": "Protein",
      "dosage": "30g",
      "form": "Powder",
      "frequency": "As needed",
      "timeOfDay": ["Post-workout"],
      "withFood": false,
      "stock": 22,
      "lowStockThreshold": 5,
      "notes": "Mix with water or milk post-workout",
      "image": "https://picsum.photos/80/80?random=4&keyword=protein",
      "isActive": true,
      "nextDose": null,
      "completedToday": false,
      "benefits": ["Muscle recovery", "Protein synthesis", "Weight management"],
      "sideEffects": ["Bloating", "Gas"],
      "price": 65.00,
      "expiryDate": DateTime.now().add(Duration(days: 500)),
    },
    {
      "id": "5",
      "name": "Ashwagandha",
      "brand": "KSM-66",
      "category": "Herbs",
      "dosage": "600mg",
      "form": "Capsule",
      "frequency": "Twice daily",
      "timeOfDay": ["Morning", "Evening"],
      "withFood": true,
      "stock": 35,
      "lowStockThreshold": 10,
      "notes": "Take with food to avoid stomach irritation",
      "image": "https://picsum.photos/80/80?random=5&keyword=ashwagandha",
      "isActive": false,
      "nextDose": null,
      "completedToday": false,
      "benefits": ["Stress reduction", "Cortisol balance", "Energy levels"],
      "sideEffects": ["Drowsiness", "Stomach upset"],
      "price": 32.75,
      "expiryDate": DateTime.now().add(Duration(days: 450)),
    },
  ];

  final List<Map<String, dynamic>> todaySchedule = [
    {
      "time": "08:00",
      "supplements": ["Vitamin D3", "Omega-3 Fish Oil"],
      "completed": [true, false],
    },
    {
      "time": "12:00",
      "supplements": ["Post-workout Protein"],
      "completed": [false],
    },
    {
      "time": "20:00",
      "supplements": ["Omega-3 Fish Oil", "Magnesium Glycinate"],
      "completed": [true, true],
    },
  ];

  List<Map<String, dynamic>> get filteredSupplements {
    return supplements.where((supplement) {
      if (selectedFilter != "All" && supplement["category"] != selectedFilter) {
        return false;
      }
      if (!showCompleted && supplement["completedToday"] == true) {
        return false;
      }
      return true;
    }).toList();
  }

  int get totalActiveSupplements => supplements.where((s) => s["isActive"] == true).length;
  int get completedToday => supplements.where((s) => s["completedToday"] == true && s["isActive"] == true).length;
  int get lowStockCount => supplements.where((s) => (s["stock"] as int) <= (s["lowStockThreshold"] as int)).length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplements"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Add supplement opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              ss("Settings opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.medical_services, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "$totalActiveSupplements",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "$completedToday",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning,
                          color: lowStockCount > 0 ? warningColor : disabledColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$lowStockCount",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: lowStockCount > 0 ? warningColor : disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Low Stock",
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
            SizedBox(height: spMd),

            // Today's Schedule
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Schedule",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ss("Schedule settings opened");
                        },
                        child: Icon(Icons.edit, color: primaryColor, size: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  ...todaySchedule.map((schedule) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            child: Text(
                              "${schedule["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...(schedule["supplements"] as List<String>).asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final supplement = entry.value;
                                  final isCompleted = (schedule["completed"] as List<bool>)[index];
                                  
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: spXs),
                                    child: Row(
                                      children: [
                                        Icon(
                                          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                          color: isCompleted ? successColor : disabledColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Text(
                                            supplement,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: primaryColor,
                                              decoration: isCompleted ? TextDecoration.lineThrough : null,
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
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Filter and Toggle Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: filterOptions.map((option) => {
                            "label": option,
                            "value": option,
                          }).toList(),
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show Completed",
                              "value": true,
                              "checked": showCompleted,
                            }
                          ],
                          value: [if (showCompleted) {"label": "Show Completed", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            showCompleted = values.isNotEmpty;
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

            // Supplements List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Supplements",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredSupplements.length} items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  ...filteredSupplements.map((supplement) {
                    final isLowStock = (supplement["stock"] as int) <= (supplement["lowStockThreshold"] as int);
                    final isExpiringSoon = (supplement["expiryDate"] as DateTime).isBefore(DateTime.now().add(Duration(days: 30)));
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: supplement["isActive"] ? Colors.white : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: supplement["completedToday"] ? successColor.withAlpha(100) : disabledColor,
                        ),
                        boxShadow: supplement["completedToday"] ? [
                          BoxShadow(
                            color: successColor.withAlpha(30),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ] : [],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${supplement["image"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${supplement["name"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        if (supplement["completedToday"])
                                          Icon(Icons.check_circle, color: successColor, size: 20),
                                      ],
                                    ),
                                    Text(
                                      "${supplement["brand"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${supplement["dosage"]} • ${supplement["frequency"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getCategoryColor(supplement["category"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${supplement["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getCategoryColor(supplement["category"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          
                          // Stock and warnings
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.inventory,
                                      color: isLowStock ? warningColor : disabledBoldColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Stock: ${supplement["stock"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isLowStock ? warningColor : disabledBoldColor,
                                        fontWeight: isLowStock ? FontWeight.w600 : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isExpiringSoon) ...[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Expires Soon",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: dangerColor,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          
                          if (supplement["notes"] != null && supplement["notes"].isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline, color: infoColor, size: 16),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${supplement["notes"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          // Action buttons
                          Row(
                            children: [
                              if (supplement["isActive"] && !supplement["completedToday"]) ...[
                                Expanded(
                                  child: QButton(
                                    label: "Mark Taken",
                                    size: bs.sm,
                                    onPressed: () {
                                      supplement["completedToday"] = true;
                                      setState(() {});
                                      ss("${supplement["name"]} marked as taken!");
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                              ],
                              Expanded(
                                child: QButton(
                                  label: "Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    _showSupplementDetails(supplement);
                                  },
                                ),
                              ),
                              if (isLowStock) ...[
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Reorder",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Reorder ${supplement["name"]} opened");
                                    },
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  if (filteredSupplements.isEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.medical_services_outlined,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No supplements found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Add your supplements to start tracking",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ss("Add supplement opened");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'vitamins':
        return successColor;
      case 'minerals':
        return infoColor;
      case 'protein':
        return warningColor;
      case 'herbs':
        return primaryColor;
      case 'others':
      default:
        return disabledBoldColor;
    }
  }

  void _showSupplementDetails(Map<String, dynamic> supplement) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${supplement["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${supplement["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${supplement["brand"]}",
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
            SizedBox(height: spMd),
            
            Text(
              "Benefits:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...(supplement["benefits"] as List<String>).map((benefit) {
              return Padding(
                padding: EdgeInsets.only(left: spSm, bottom: spXs),
                child: Row(
                  children: [
                    Icon(Icons.check, color: successColor, size: 16),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        benefit,
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            SizedBox(height: spSm),
            
            Text(
              "Side Effects:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...(supplement["sideEffects"] as List<String>).map((effect) {
              return Padding(
                padding: EdgeInsets.only(left: spSm, bottom: spXs),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: warningColor, size: 16),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        effect,
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Edit",
                    size: bs.sm,
                    onPressed: () {
                      back();
                      ss("Edit supplement opened");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Delete",
                    size: bs.sm,
                    onPressed: () async {
                      back();
                      bool isConfirmed = await confirm("Delete ${supplement["name"]} from your supplements?");
                      if (isConfirmed) {
                        supplements.remove(supplement);
                        setState(() {});
                        ss("Supplement deleted");
                      }
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
