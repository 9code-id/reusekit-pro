import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsExpiryTrackingView extends StatefulWidget {
  const RfsExpiryTrackingView({super.key});

  @override
  State<RfsExpiryTrackingView> createState() => _RfsExpiryTrackingViewState();
}

class _RfsExpiryTrackingViewState extends State<RfsExpiryTrackingView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedExpiryStatus = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Vegetables", "value": "Vegetables"},
    {"label": "Fruits", "value": "Fruits"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Pantry", "value": "Pantry"},
  ];

  List<Map<String, dynamic>> expiryStatusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Fresh", "value": "Fresh"},
    {"label": "Expiring Soon", "value": "Expiring Soon"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "IT001",
      "name": "Fresh Milk",
      "category": "Dairy",
      "brand": "Farm Fresh",
      "purchaseDate": "2025-06-17T00:00:00",
      "expiryDate": "2025-06-21T00:00:00",
      "quantity": 24,
      "unit": "bottles",
      "costPerUnit": 3.50,
      "location": "Dairy Cooler A",
      "supplier": "Local Dairy Farm",
      "batchNumber": "DF20250617",
      "barcode": "1234567890123",
      "status": "Expiring Soon",
      "daysUntilExpiry": 2,
      "image": "https://picsum.photos/300/200?random=1&keyword=milk"
    },
    {
      "id": "IT002",
      "name": "Ground Beef",
      "category": "Meat",
      "brand": "Premium Meats",
      "purchaseDate": "2025-06-15T00:00:00",
      "expiryDate": "2025-06-19T00:00:00",
      "quantity": 12,
      "unit": "lbs",
      "costPerUnit": 8.99,
      "location": "Meat Freezer B",
      "supplier": "Meat Processing Co",
      "batchNumber": "MP20250615",
      "barcode": "2345678901234",
      "status": "Expired",
      "daysUntilExpiry": 0,
      "image": "https://picsum.photos/300/200?random=2&keyword=beef"
    },
    {
      "id": "IT003",
      "name": "Fresh Tomatoes",
      "category": "Vegetables",
      "brand": "Organic Valley",
      "purchaseDate": "2025-06-18T00:00:00",
      "expiryDate": "2025-06-23T00:00:00",
      "quantity": 50,
      "unit": "lbs",
      "costPerUnit": 2.25,
      "location": "Produce Section",
      "supplier": "Valley Farms",
      "batchNumber": "VF20250618",
      "barcode": "3456789012345",
      "status": "Fresh",
      "daysUntilExpiry": 4,
      "image": "https://picsum.photos/300/200?random=3&keyword=tomatoes"
    },
    {
      "id": "IT004",
      "name": "Orange Juice",
      "category": "Beverages",
      "brand": "Sunny Fresh",
      "purchaseDate": "2025-06-16T00:00:00",
      "expiryDate": "2025-06-20T00:00:00",
      "quantity": 18,
      "unit": "cartons",
      "costPerUnit": 4.25,
      "location": "Beverage Cooler",
      "supplier": "Citrus Distributors",
      "batchNumber": "CD20250616",
      "barcode": "4567890123456",
      "status": "Expiring Soon",
      "daysUntilExpiry": 1,
      "image": "https://picsum.photos/300/200?random=4&keyword=juice"
    },
    {
      "id": "IT005",
      "name": "Cheddar Cheese",
      "category": "Dairy",
      "brand": "Artisan Cheese Co",
      "purchaseDate": "2025-06-10T00:00:00",
      "expiryDate": "2025-06-18T00:00:00",
      "quantity": 8,
      "unit": "blocks",
      "costPerUnit": 6.75,
      "location": "Dairy Cooler B",
      "supplier": "Cheese Masters",
      "batchNumber": "CM20250610",
      "barcode": "5678901234567",
      "status": "Critical",
      "daysUntilExpiry": -1,
      "image": "https://picsum.photos/300/200?random=5&keyword=cheese"
    },
    {
      "id": "IT006",
      "name": "Bread Rolls",
      "category": "Pantry",
      "brand": "Fresh Bakery",
      "purchaseDate": "2025-06-19T00:00:00",
      "expiryDate": "2025-06-25T00:00:00",
      "quantity": 100,
      "unit": "pieces",
      "costPerUnit": 0.75,
      "location": "Bread Storage",
      "supplier": "Local Bakery",
      "batchNumber": "LB20250619",
      "barcode": "6789012345678",
      "status": "Fresh",
      "daysUntilExpiry": 6,
      "image": "https://picsum.photos/300/200?random=6&keyword=bread"
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    return inventoryItems.where((item) {
      bool matchesSearch = "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["batchNumber"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      bool matchesStatus = selectedExpiryStatus == "All" || item["status"] == selectedExpiryStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color getExpiryStatusColor(String status) {
    switch (status) {
      case "Fresh": return successColor;
      case "Expiring Soon": return warningColor;
      case "Expired": return dangerColor;
      case "Critical": return Color(0xFF8B0000);
      default: return disabledColor;
    }
  }

  Color getDaysColor(int days) {
    if (days < 0) return Color(0xFF8B0000);
    if (days == 0) return dangerColor;
    if (days <= 2) return warningColor;
    return successColor;
  }

  String getExpiryUrgency(int days) {
    if (days < 0) return "EXPIRED";
    if (days == 0) return "EXPIRES TODAY";
    if (days == 1) return "EXPIRES TOMORROW";
    return "EXPIRES IN $days DAYS";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expiry Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Items",
                    value: searchQuery,
                    hint: "Search by name, ID, or batch...",
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

            // Filter Options
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
                    label: "Expiry Status",
                    items: expiryStatusOptions,
                    value: selectedExpiryStatus,
                    onChanged: (value, label) {
                      selectedExpiryStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryItems.where((item) => item["status"] == "Fresh").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Fresh",
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryItems.where((item) => item["status"] == "Expiring Soon").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Expiring",
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
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.error, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${inventoryItems.where((item) => item["status"] == "Expired" || item["status"] == "Critical").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Expired",
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

            // Total Value at Risk
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: warningColor, size: 24),
                  SizedBox(width: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Value at Risk (Expiring/Expired)",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${((inventoryItems.where((item) => item["status"] == "Expiring Soon" || item["status"] == "Expired" || item["status"] == "Critical").map((item) => ((item["quantity"] as int) * (item["costPerUnit"] as double))).reduce((a, b) => a + b)).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Inventory Items List
            ...filteredItems.map((item) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getExpiryStatusColor("${item["status"]}"),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          bottomLeft: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${item["image"]}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item["name"]}",
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
                                      color: getExpiryStatusColor("${item["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: getExpiryStatusColor("${item["status"]}").withAlpha(100),
                                      ),
                                    ),
                                    child: Text(
                                      "${item["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getExpiryStatusColor("${item["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${item["id"]} • ${item["brand"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getDaysColor(item["daysUntilExpiry"] as int).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: getDaysColor(item["daysUntilExpiry"] as int).withAlpha(100),
                                  ),
                                ),
                                child: Text(
                                  getExpiryUrgency(item["daysUntilExpiry"] as int),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: getDaysColor(item["daysUntilExpiry"] as int),
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.inventory, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${item["quantity"]} ${item["unit"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.monetization_on, size: 14, color: warningColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "\$${(((item["quantity"] as int) * (item["costPerUnit"] as double)).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
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
                  
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      border: Border(
                        top: BorderSide(color: disabledOutlineBorderColor),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${item["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Batch: ${item["batchNumber"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                                fontFamily: "monospace",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.business, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${item["supplier"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Exp: ${DateTime.parse("${item["expiryDate"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: getDaysColor(item["daysUntilExpiry"] as int),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusMd),
                        bottomRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Purchased: ${DateTime.parse("${item["purchaseDate"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Actions",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
