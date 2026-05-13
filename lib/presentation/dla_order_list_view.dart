import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaOrderListView extends StatefulWidget {
  const DlaOrderListView({super.key});

  @override
  State<DlaOrderListView> createState() => _DlaOrderListViewState();
}

class _DlaOrderListViewState extends State<DlaOrderListView> {
  String selectedFilter = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Orders", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];
  
  List<Map<String, dynamic>> orders = [
    {
      "id": "DL001",
      "restaurant": "Pizza Palace",
      "customer": "John Smith",
      "pickup": "123 Main St",
      "delivery": "456 Oak Ave",
      "distance": "2.3 km",
      "earnings": 15.75,
      "time": "25 min",
      "status": "active",
      "date": "2024-01-15",
      "rating": null,
      "type": "food",
    },
    {
      "id": "DL002",
      "restaurant": "Burger Express",
      "customer": "Sarah Johnson",
      "pickup": "789 Pine St",
      "delivery": "321 Elm Dr",
      "distance": "1.8 km",
      "earnings": 12.25,
      "time": "18 min",
      "status": "completed",
      "date": "2024-01-15",
      "rating": 5,
      "type": "food",
    },
    {
      "id": "DL003",
      "restaurant": "Sushi World",
      "customer": "Mike Davis",
      "pickup": "555 Market St",
      "delivery": "999 Broadway",
      "distance": "4.5 km",
      "earnings": 18.50,
      "time": "32 min",
      "status": "completed",
      "date": "2024-01-14",
      "rating": 4,
      "type": "food",
    },
    {
      "id": "DL004",
      "restaurant": "Coffee Corner",
      "customer": "Lisa Wong",
      "pickup": "111 Coffee Ave",
      "delivery": "222 Tea St",
      "distance": "1.2 km",
      "earnings": 8.75,
      "time": "15 min",
      "status": "cancelled",
      "date": "2024-01-14",
      "rating": null,
      "type": "beverage",
    },
    {
      "id": "DL005",
      "restaurant": "Taco Fiesta",
      "customer": "Carlos Rodriguez",
      "pickup": "333 Spice Blvd",
      "delivery": "444 Pepper Lane",
      "distance": "3.7 km",
      "earnings": 16.00,
      "time": "28 min",
      "status": "completed",
      "date": "2024-01-13",
      "rating": 5,
      "type": "food",
    },
  ];
  
  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = orders;
    
    // Filter by status
    if (selectedFilter != "all") {
      filtered = filtered.where((order) => order["status"] == selectedFilter).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return order["restaurant"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        actions: [
          IconButton(
            onPressed: () {
              // Filter options
              _showFilterOptions();
            },
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {
              // Export data
            },
            icon: Icon(Icons.file_download),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search orders...",
                        value: searchQuery,
                        hint: "Search by restaurant, customer, or order ID",
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
                
                // Filter Tabs
                QCategoryPicker(
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (index, label, value, item) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Order List
          Expanded(
            child: filteredOrders.isEmpty 
              ? _buildEmptyState()
              : ListView.builder(
                  padding: EdgeInsets.all(spMd),
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(filteredOrders[index]);
                  },
                ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(sp2xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 80,
            color: disabledBoldColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No Orders Found",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            searchQuery.isNotEmpty 
              ? "No orders match your search criteria"
              : selectedFilter == "all" 
                ? "You haven't received any orders yet"
                : "No ${selectedFilter} orders found",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          if (searchQuery.isNotEmpty) ...[
            SizedBox(height: spMd),
            QButton(
              label: "Clear Search",
              size: bs.sm,
              onPressed: () {
                searchQuery = "";
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor = _getStatusColor(order["status"]);
    IconData statusIcon = _getStatusIcon(order["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "#${order["id"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          statusIcon,
                          size: 12,
                          color: statusColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${order["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "\$${(order["earnings"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          
          // Restaurant and Customer Info
          Row(
            children: [
              Icon(
                order["type"] == "food" ? Icons.restaurant : Icons.local_cafe,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${order["restaurant"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (order["rating"] != null) ...[
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < (order["rating"] as int) ? Icons.star : Icons.star_border,
                      color: warningColor,
                      size: 14,
                    );
                  }),
                ),
              ],
            ],
          ),
          
          Row(
            children: [
              Icon(
                Icons.person,
                color: infoColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${order["customer"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "${order["distance"]} • ${order["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          // Address Info
          Column(
            spacing: spXs,
            children: [
              Row(
                children: [
                  Icon(Icons.store, color: successColor, size: 14),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Pickup: ${order["pickup"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: dangerColor, size: 14),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Delivery: ${order["delivery"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Footer Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${order["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              
              Row(
                children: [
                  if (order["status"] == "active") ...[
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to order details
                      },
                    ),
                  ] else if (order["status"] == "completed") ...[
                    OutlinedButton(
                      onPressed: () {
                        // View receipt or details
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: BorderSide(color: primaryColor),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 6),
                      ),
                      child: Text(
                        "View Receipt",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ] else if (order["status"] == "cancelled") ...[
                    OutlinedButton(
                      onPressed: () {
                        // View cancellation details
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: dangerColor,
                        side: BorderSide(color: dangerColor),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 6),
                      ),
                      child: Text(
                        "View Details",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return warningColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  IconData _getStatusIcon(String status) {
    switch (status) {
      case "active":
        return Icons.local_shipping;
      case "completed":
        return Icons.check_circle;
      case "cancelled":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
  
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Divider(),
            
            ...filterOptions.map((option) => ListTile(
              leading: Radio<String>(
                value: option["value"],
                groupValue: selectedFilter,
                onChanged: (value) {
                  selectedFilter = value!;
                  setState(() {});
                  Navigator.pop(context);
                },
                activeColor: primaryColor,
              ),
              title: Text("${option["label"]}"),
              onTap: () {
                selectedFilter = option["value"];
                setState(() {});
                Navigator.pop(context);
              },
            )),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      selectedFilter = "all";
                      searchQuery = "";
                      setState(() {});
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryColor),
                      padding: EdgeInsets.symmetric(vertical: spSm),
                    ),
                    child: Text(
                      "Clear Filters",
                      style: TextStyle(color: primaryColor),
                    ),
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
