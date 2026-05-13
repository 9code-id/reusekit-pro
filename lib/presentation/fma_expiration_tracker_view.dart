import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaExpirationTrackerView extends StatefulWidget {
  const FmaExpirationTrackerView({super.key});

  @override
  State<FmaExpirationTrackerView> createState() => _FmaExpirationTrackerViewState();
}

class _FmaExpirationTrackerViewState extends State<FmaExpirationTrackerView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedPriority = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Bakery", "value": "Bakery"},
    {"label": "Frozen", "value": "Frozen"},
    {"label": "Condiments", "value": "Condiments"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Warning", "value": "Warning"},
    {"label": "Good", "value": "Good"},
  ];

  List<Map<String, dynamic>> expiringItems = [
    {
      "id": "1",
      "name": "Fresh Milk",
      "category": "Dairy",
      "expiryDate": "2024-06-20",
      "daysUntilExpiry": 1,
      "quantity": 8,
      "unit": "liters",
      "costPerUnit": 3.50,
      "supplier": "Dairy Farm Co",
      "location": "Cooler A",
      "batchNumber": "MK001",
      "purchaseDate": "2024-06-12",
      "priority": "Critical",
      "notes": "High demand item",
      "image": "https://picsum.photos/80/80?random=1&keyword=milk"
    },
    {
      "id": "2",
      "name": "Ground Beef",
      "category": "Meat",
      "expiryDate": "2024-06-19",
      "daysUntilExpiry": 0,
      "quantity": 3,
      "unit": "kg",
      "costPerUnit": 12.99,
      "supplier": "Premium Meats",
      "location": "Freezer B",
      "batchNumber": "BF203",
      "purchaseDate": "2024-06-15",
      "priority": "Expired",
      "notes": "Remove immediately",
      "image": "https://picsum.photos/80/80?random=2&keyword=meat"
    },
    {
      "id": "3",
      "name": "Lettuce",
      "category": "Vegetables",
      "expiryDate": "2024-06-22",
      "daysUntilExpiry": 3,
      "quantity": 12,
      "unit": "heads",
      "costPerUnit": 2.25,
      "supplier": "Green Gardens",
      "location": "Cooler C",
      "batchNumber": "LT456",
      "purchaseDate": "2024-06-18",
      "priority": "Warning",
      "notes": "Use for salads first",
      "image": "https://picsum.photos/80/80?random=3&keyword=lettuce"
    },
    {
      "id": "4",
      "name": "Orange Juice",
      "category": "Beverages",
      "expiryDate": "2024-06-21",
      "daysUntilExpiry": 2,
      "quantity": 6,
      "unit": "bottles",
      "costPerUnit": 4.75,
      "supplier": "Fresh Squeeze",
      "location": "Cooler D",
      "batchNumber": "OJ789",
      "purchaseDate": "2024-06-17",
      "priority": "Critical",
      "notes": "Popular breakfast item",
      "image": "https://picsum.photos/80/80?random=4&keyword=juice"
    },
    {
      "id": "5",
      "name": "Bread Loaves",
      "category": "Bakery",
      "expiryDate": "2024-06-25",
      "daysUntilExpiry": 6,
      "quantity": 15,
      "unit": "loaves",
      "costPerUnit": 3.25,
      "supplier": "Local Bakery",
      "location": "Pantry A",
      "batchNumber": "BR012",
      "purchaseDate": "2024-06-19",
      "priority": "Good",
      "notes": "Fresh delivery",
      "image": "https://picsum.photos/80/80?random=5&keyword=bread"
    },
    {
      "id": "6",
      "name": "Yogurt Cups",
      "category": "Dairy",
      "expiryDate": "2024-06-26",
      "daysUntilExpiry": 7,
      "quantity": 24,
      "unit": "cups",
      "costPerUnit": 1.50,
      "supplier": "Dairy Delights",
      "location": "Cooler A",
      "batchNumber": "YG345",
      "purchaseDate": "2024-06-18",
      "priority": "Good",
      "notes": "Breakfast special",
      "image": "https://picsum.photos/80/80?random=6&keyword=yogurt"
    },
    {
      "id": "7",
      "name": "Chicken Breast",
      "category": "Meat",
      "expiryDate": "2024-06-23",
      "daysUntilExpiry": 4,
      "quantity": 5,
      "unit": "kg",
      "costPerUnit": 9.99,
      "supplier": "Poultry Plus",
      "location": "Cooler B",
      "batchNumber": "CB678",
      "purchaseDate": "2024-06-19",
      "priority": "Warning",
      "notes": "Main dish preparation",
      "image": "https://picsum.photos/80/80?random=7&keyword=chicken"
    },
  ];

  List<Map<String, dynamic>> expirationHistory = [
    {
      "id": "1",
      "itemName": "Strawberries",
      "quantity": 2,
      "unit": "pints",
      "expiryDate": "2024-06-18",
      "disposalDate": "2024-06-18",
      "cost": 8.50,
      "reason": "Spoiled - moldy",
      "disposedBy": "Kitchen Staff"
    },
    {
      "id": "2",
      "itemName": "Fish Fillets",
      "quantity": 1,
      "unit": "kg",
      "expiryDate": "2024-06-17",
      "disposalDate": "2024-06-17",
      "cost": 18.99,
      "reason": "Expired - smell",
      "disposedBy": "Chef"
    },
    {
      "id": "3",
      "itemName": "Cream Cheese",
      "quantity": 3,
      "unit": "packages",
      "expiryDate": "2024-06-16",
      "disposalDate": "2024-06-16",
      "cost": 12.75,
      "reason": "Past expiry date",
      "disposedBy": "Manager"
    },
  ];

  List<Map<String, dynamic>> get filteredExpiringItems {
    return expiringItems.where((item) {
      bool matchesSearch = item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesPriority = selectedPriority == "All" || item["priority"] == selectedPriority;
      return matchesSearch && matchesCategory && matchesPriority;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Expired": return dangerColor;
      case "Critical": return Color(0xFFFF5722);
      case "Warning": return warningColor;
      case "Good": return successColor;
      default: return disabledBoldColor;
    }
  }

  String _getPriorityText(int daysUntilExpiry) {
    if (daysUntilExpiry < 0) return "Expired";
    if (daysUntilExpiry == 0) return "Expires Today";
    if (daysUntilExpiry <= 2) return "Critical";
    if (daysUntilExpiry <= 5) return "Warning";
    return "Good";
  }

  Widget _buildOverviewTab() {
    List<Map<String, dynamic>> expiredItems = expiringItems.where((item) => 
        item["daysUntilExpiry"] < 0).toList();
    List<Map<String, dynamic>> criticalItems = expiringItems.where((item) => 
        item["daysUntilExpiry"] >= 0 && item["daysUntilExpiry"] <= 2).toList();
    List<Map<String, dynamic>> warningItems = expiringItems.where((item) => 
        item["daysUntilExpiry"] > 2 && item["daysUntilExpiry"] <= 5).toList();
    
    double totalWasteValue = expirationHistory.map((item) => item["cost"] as double)
        .fold(0.0, (a, b) => a + b);
    
    Map<String, int> categoryExpirations = {};
    for (var item in expiringItems) {
      if (item["daysUntilExpiry"] <= 2) {
        String category = item["category"];
        categoryExpirations[category] = (categoryExpirations[category] ?? 0) + 1;
      }
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Priority Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.error, color: dangerColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${expiredItems.length}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Expired Items",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.warning, color: Color(0xFFFF5722), size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${criticalItems.length}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF5722),
                      ),
                    ),
                    Text(
                      "Critical (0-2 days)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${warningItems.length}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Warning (3-5 days)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.attach_money, color: dangerColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "\$${(totalWasteValue).currency}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Waste Value",
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

          // Immediate Action Required
          if (expiredItems.isNotEmpty || criticalItems.isNotEmpty) ...[
            Text(
              "Immediate Action Required",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
            
            Column(
              spacing: spSm,
              children: [...expiredItems, ...criticalItems].map((item) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getPriorityColor(item["priority"]),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${item["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
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
                                    "${item["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(item["priority"]).withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    item["daysUntilExpiry"] == 0 ? "Today" :
                                    item["daysUntilExpiry"] < 0 ? "Expired" :
                                    "${item["daysUntilExpiry"]} days",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _getPriorityColor(item["priority"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${item["quantity"]} ${item["unit"]} • ${item["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Expires: ${item["expiryDate"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],

          // Expiration by Category
          if (categoryExpirations.isNotEmpty) ...[
            Text(
              "Critical Items by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: categoryExpirations.entries.map((entry) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${entry.value} items",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],

          // Recent Waste History
          Text(
            "Recent Disposal History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: expirationHistory.map((item) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(Icons.delete, color: dangerColor, size: 20),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["itemName"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${item["quantity"]} ${item["unit"]} • \$${((item["cost"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${item["reason"]} • ${item["disposalDate"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((item["cost"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiringItemsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Search items...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
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
                      label: "Priority",
                      items: priorityOptions,
                      value: selectedPriority,
                      onChanged: (value, label) {
                        selectedPriority = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Expiring Items List
          Column(
            spacing: spSm,
            children: filteredExpiringItems.map((item) {
              double itemValue = (item["quantity"] as int) * (item["costPerUnit"] as double);
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPriorityColor(item["priority"]),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${item["image"]}",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
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
                                      "${item["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(item["priority"]).withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${item["priority"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: _getPriorityColor(item["priority"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${item["category"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Batch: ${item["batchNumber"]} • ${item["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Supplier: ${item["supplier"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${item["quantity"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${item["unit"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: warningColor,
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
                              color: item["daysUntilExpiry"] <= 0 ? dangerColor.withAlpha(51) :
                                     item["daysUntilExpiry"] <= 2 ? Color(0xFFFF5722).withAlpha(51) :
                                     successColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  item["daysUntilExpiry"] < 0 ? "Expired" :
                                  item["daysUntilExpiry"] == 0 ? "Today" :
                                  "${item["daysUntilExpiry"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: item["daysUntilExpiry"] <= 0 ? dangerColor :
                                           item["daysUntilExpiry"] <= 2 ? Color(0xFFFF5722) :
                                           successColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  item["daysUntilExpiry"] <= 0 ? "" : "days left",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: item["daysUntilExpiry"] <= 0 ? dangerColor :
                                           item["daysUntilExpiry"] <= 2 ? Color(0xFFFF5722) :
                                           successColor,
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
                              color: dangerColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "\$${(itemValue).currency}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Value",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Expiry Date:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${item["expiryDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Purchased: ${item["purchaseDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          if (item["notes"] != null && item["notes"] != "") ...[
                            SizedBox(height: spXs),
                            Text(
                              "Notes: ${item["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Use First",
                            size: bs.sm,
                            onPressed: () {
                              ss("Marked ${item["name"]} for priority use");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: item["daysUntilExpiry"] < 0 ? "Dispose" : "Extend",
                            size: bs.sm,
                            onPressed: () {
                              if (item["daysUntilExpiry"] < 0) {
                                ss("${item["name"]} marked for disposal");
                              } else {
                                ss("Extending ${item["name"]} expiry date");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Expiration Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Expiring Items", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildExpiringItemsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
