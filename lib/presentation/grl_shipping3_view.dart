import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShipping3View extends StatefulWidget {
  @override
  State<GrlShipping3View> createState() => _GrlShipping3ViewState();
}

class _GrlShipping3ViewState extends State<GrlShipping3View> {
  String searchQuery = "";
  String selectedFilter = "all";
  String sortBy = "date";
  
  List<Map<String, dynamic>> shipments = [
    {
      "id": "SP123456789US",
      "status": "delivered",
      "title": "Electronics Order",
      "items": ["MacBook Pro 16\"", "Wireless Mouse", "USB-C Hub"],
      "orderDate": DateTime.now().subtract(Duration(days: 5)),
      "deliveryDate": DateTime.now().subtract(Duration(days: 1)),
      "estimatedDelivery": DateTime.now().subtract(Duration(days: 1)),
      "carrier": "FedEx",
      "service": "Express Shipping",
      "cost": 12.99,
      "recipient": "John Doe",
      "address": "123 Main St, New York, NY",
      "weight": "3.2 lbs",
      "dimensions": "16x12x8 inches",
      "lastUpdate": DateTime.now().subtract(Duration(hours: 24)),
    },
    {
      "id": "SP987654321US",
      "status": "in_transit",
      "title": "Clothing & Accessories",
      "items": ["Winter Jacket", "Wool Scarf", "Leather Gloves"],
      "orderDate": DateTime.now().subtract(Duration(days: 3)),
      "deliveryDate": null,
      "estimatedDelivery": DateTime.now().add(Duration(days: 2)),
      "carrier": "UPS",
      "service": "Standard Shipping",
      "cost": 7.99,
      "recipient": "Jane Smith",
      "address": "456 Oak Ave, Brooklyn, NY",
      "weight": "2.1 lbs",
      "dimensions": "14x10x6 inches",
      "lastUpdate": DateTime.now().subtract(Duration(hours: 6)),
    },
    {
      "id": "SP456789123US",
      "status": "out_for_delivery",
      "title": "Home & Garden",
      "items": ["Plant Pots", "Garden Tools", "Fertilizer"],
      "orderDate": DateTime.now().subtract(Duration(days: 7)),
      "deliveryDate": null,
      "estimatedDelivery": DateTime.now(),
      "carrier": "USPS",
      "service": "Priority Mail",
      "cost": 9.99,
      "recipient": "Mike Johnson",
      "address": "789 Pine St, Queens, NY",
      "weight": "5.5 lbs",
      "dimensions": "18x14x10 inches",
      "lastUpdate": DateTime.now().subtract(Duration(hours: 2)),
    },
    {
      "id": "SP789123456US",
      "status": "shipped",
      "title": "Books & Stationery",
      "items": ["Programming Books", "Notebooks", "Pens"],
      "orderDate": DateTime.now().subtract(Duration(days: 2)),
      "deliveryDate": null,
      "estimatedDelivery": DateTime.now().add(Duration(days: 3)),
      "carrier": "DHL",
      "service": "Economy Shipping",
      "cost": 4.99,
      "recipient": "Sarah Wilson",
      "address": "321 Elm St, Manhattan, NY",
      "weight": "1.8 lbs",
      "dimensions": "12x9x4 inches",
      "lastUpdate": DateTime.now().subtract(Duration(hours: 12)),
    },
    {
      "id": "SP321654987US",
      "status": "processing",
      "title": "Sports Equipment",
      "items": ["Tennis Racket", "Sports Bag", "Tennis Balls"],
      "orderDate": DateTime.now().subtract(Duration(days: 1)),
      "deliveryDate": null,
      "estimatedDelivery": DateTime.now().add(Duration(days: 5)),
      "carrier": "FedEx",
      "service": "Standard Shipping",
      "cost": 7.99,
      "recipient": "Alex Brown",
      "address": "654 Maple Ave, Bronx, NY",
      "weight": "2.7 lbs",
      "dimensions": "15x8x6 inches",
      "lastUpdate": DateTime.now().subtract(Duration(hours: 8)),
    },
    {
      "id": "SP654987321US",
      "status": "cancelled",
      "title": "Kitchen Appliances",
      "items": ["Coffee Maker", "Toaster", "Blender"],
      "orderDate": DateTime.now().subtract(Duration(days: 10)),
      "deliveryDate": null,
      "estimatedDelivery": null,
      "carrier": "UPS",
      "service": "Express Shipping",
      "cost": 0.0,
      "recipient": "Lisa Davis",
      "address": "987 Cedar St, Staten Island, NY",
      "weight": "8.2 lbs",
      "dimensions": "20x16x12 inches",
      "lastUpdate": DateTime.now().subtract(Duration(days: 8)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredShipments = _getFilteredShipments();

    return Scaffold(
      appBar: AppBar(
        title: Text("Shipment History"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions();
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: "Search by tracking number, recipient, or items...",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: disabledBoldColor,
                      ),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: disabledBoldColor,
                              ),
                              onPressed: () {
                                searchQuery = "";
                                setState(() {});
                              },
                            )
                          : null,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                    ),
                  ),
                ),
                
                // Status Filter
                QHorizontalScroll(
                  children: ['all', 'delivered', 'in_transit', 'out_for_delivery', 'shipped', 'processing', 'cancelled']
                      .map((status) => GestureDetector(
                        onTap: () {
                          selectedFilter = status;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: selectedFilter == status ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                            border: selectedFilter != status
                                ? Border.all(color: disabledOutlineBorderColor)
                                : null,
                          ),
                          child: Text(
                            _getStatusLabel(status),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: selectedFilter == status ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      )).toList(),
                ),
              ],
            ),
          ),

          // Summary Stats
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total",
                    "${shipments.length}",
                    Icons.inventory,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "In Transit",
                    "${shipments.where((s) => ['in_transit', 'out_for_delivery', 'shipped'].contains(s["status"])).length}",
                    Icons.local_shipping,
                    warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Delivered",
                    "${shipments.where((s) => s["status"] == "delivered").length}",
                    Icons.check_circle,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Issues",
                    "${shipments.where((s) => s["status"] == "cancelled").length}",
                    Icons.error,
                    dangerColor,
                  ),
                ),
              ],
            ),
          ),

          // Shipments List
          Expanded(
            child: filteredShipments.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: filteredShipments.length,
                    itemBuilder: (context, index) {
                      final shipment = filteredShipments[index];
                      return _buildShipmentCard(shipment);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShipmentCard(Map<String, dynamic> shipment) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          // Shipment Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getStatusColor(shipment["status"]).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getStatusColor(shipment["status"]),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    _getStatusIcon(shipment["status"]),
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${shipment["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Tracking: ${shipment["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(shipment["status"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    _getStatusLabel(shipment["status"]),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Shipment Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Items List
                Text(
                  "Items (${(shipment["items"] as List).length}):",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  (shipment["items"] as List<String>).join(", "),
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spMd),
                
                // Delivery Info
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${shipment["recipient"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${shipment["address"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Shipping Details
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_shipping,
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${shipment["carrier"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${shipment["service"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money,
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "\$${(shipment["cost"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Shipping cost",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Dates
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ordered",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(shipment["orderDate"] as DateTime).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
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
                            shipment["status"] == "delivered" ? "Delivered" : "Expected",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            shipment["deliveryDate"] != null
                                ? "${(shipment["deliveryDate"] as DateTime).dMMMy}"
                                : shipment["estimatedDelivery"] != null
                                    ? "${(shipment["estimatedDelivery"] as DateTime).dMMMy}"
                                    : "N/A",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: shipment["status"] == "delivered" ? successColor : primaryColor,
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
                            "Last Update",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(shipment["lastUpdate"] as DateTime).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Track",
                        size: bs.sm,
                        icon: Icons.track_changes,
                        onPressed: () {
                          _trackShipment(shipment);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Details",
                        size: bs.sm,
                        icon: Icons.info,
                        onPressed: () {
                          _viewShipmentDetails(shipment);
                        },
                      ),
                    ),
                    if (shipment["status"] == "processing" || shipment["status"] == "shipped") ...[
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.cancel,
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Are you sure you want to cancel this shipment?");
                          if (isConfirmed) {
                            shipment["status"] = "cancelled";
                            setState(() {});
                            ss("Shipment cancelled successfully");
                          }
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: disabledBoldColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No shipments found",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Try adjusting your search or filter criteria",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Clear Filters",
            size: bs.md,
            icon: Icons.clear_all,
            onPressed: () {
              searchQuery = "";
              selectedFilter = "all";
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredShipments() {
    List<Map<String, dynamic>> filtered = shipments;

    // Filter by status
    if (selectedFilter != 'all') {
      filtered = filtered.where((shipment) => shipment["status"] == selectedFilter).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((shipment) {
        return shipment["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               shipment["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               shipment["recipient"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               (shipment["items"] as List<String>).any((item) => 
                   item.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }

    // Sort shipments
    switch (sortBy) {
      case 'date':
        filtered.sort((a, b) => (b["orderDate"] as DateTime).compareTo(a["orderDate"] as DateTime));
        break;
      case 'status':
        filtered.sort((a, b) => a["status"].compareTo(b["status"]));
        break;
      case 'recipient':
        filtered.sort((a, b) => a["recipient"].compareTo(b["recipient"]));
        break;
      case 'cost':
        filtered.sort((a, b) => (b["cost"] as double).compareTo(a["cost"] as double));
        break;
    }

    return filtered;
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter by Status",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...['all', 'delivered', 'in_transit', 'out_for_delivery', 'shipped', 'processing', 'cancelled']
                .map((status) => ListTile(
              title: Text(_getStatusLabel(status)),
              leading: Radio<String>(
                value: status,
                groupValue: selectedFilter,
                onChanged: (value) {
                  selectedFilter = value!;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sort Shipments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...['date', 'status', 'recipient', 'cost'].map((option) => ListTile(
              title: Text(_getSortOptionTitle(option)),
              leading: Radio<String>(
                value: option,
                groupValue: sortBy,
                onChanged: (value) {
                  sortBy = value!;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'all':
        return 'All';
      case 'delivered':
        return 'Delivered';
      case 'in_transit':
        return 'In Transit';
      case 'out_for_delivery':
        return 'Out for Delivery';
      case 'shipped':
        return 'Shipped';
      case 'processing':
        return 'Processing';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  String _getSortOptionTitle(String option) {
    switch (option) {
      case 'date':
        return 'Order Date (Newest)';
      case 'status':
        return 'Status (A-Z)';
      case 'recipient':
        return 'Recipient (A-Z)';
      case 'cost':
        return 'Cost (Highest)';
      default:
        return option;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return successColor;
      case 'in_transit':
        return infoColor;
      case 'out_for_delivery':
        return warningColor;
      case 'shipped':
        return primaryColor;
      case 'processing':
        return primaryColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'delivered':
        return Icons.check_circle;
      case 'in_transit':
        return Icons.directions;
      case 'out_for_delivery':
        return Icons.local_shipping;
      case 'shipped':
        return Icons.fire_truck;
      case 'processing':
        return Icons.inventory;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.circle;
    }
  }

  void _trackShipment(Map<String, dynamic> shipment) {
    ss("Opening tracking for ${shipment["id"]}");
    // navigateTo(TrackingView(shipment));
  }

  void _viewShipmentDetails(Map<String, dynamic> shipment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipment Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    _buildDetailRow("Tracking Number", shipment["id"]),
                    _buildDetailRow("Status", _getStatusLabel(shipment["status"])),
                    _buildDetailRow("Title", shipment["title"]),
                    _buildDetailRow("Recipient", shipment["recipient"]),
                    _buildDetailRow("Address", shipment["address"]),
                    _buildDetailRow("Carrier", shipment["carrier"]),
                    _buildDetailRow("Service", shipment["service"]),
                    _buildDetailRow("Weight", shipment["weight"]),
                    _buildDetailRow("Dimensions", shipment["dimensions"]),
                    _buildDetailRow("Shipping Cost", "\$${(shipment["cost"] as double).toStringAsFixed(2)}"),
                    _buildDetailRow("Order Date", (shipment["orderDate"] as DateTime).dMMMy),
                    if (shipment["deliveryDate"] != null)
                      _buildDetailRow("Delivery Date", (shipment["deliveryDate"] as DateTime).dMMMy),
                    if (shipment["estimatedDelivery"] != null)
                      _buildDetailRow("Expected Delivery", (shipment["estimatedDelivery"] as DateTime).dMMMy),
                    _buildDetailRow("Last Update", (shipment["lastUpdate"] as DateTime).dMMMy),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }
}
