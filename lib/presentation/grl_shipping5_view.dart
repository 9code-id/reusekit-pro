import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShipping5View extends StatefulWidget {
  @override
  State<GrlShipping5View> createState() => _GrlShipping5ViewState();
}

class _GrlShipping5ViewState extends State<GrlShipping5View> {
  String selectedFilter = 'all';
  String searchQuery = '';
  bool loading = false;

  List<Map<String, dynamic>> shipments = [
    {
      "id": "SH001234",
      "customerName": "Sarah Johnson",
      "customerAddress": "123 Oak Street, New York, NY 10001",
      "destination": "456 Pine Avenue, Los Angeles, CA 90210",
      "packageType": "Electronics",
      "weight": 2.5,
      "status": "in_transit",
      "priority": "express",
      "estimatedDelivery": DateTime.now().add(Duration(days: 1)),
      "trackingSteps": [
        {"status": "picked_up", "timestamp": DateTime.now().subtract(Duration(hours: 24)), "location": "New York Warehouse"},
        {"status": "in_transit", "timestamp": DateTime.now().subtract(Duration(hours: 12)), "location": "Chicago Hub"},
        {"status": "out_for_delivery", "timestamp": null, "location": "Los Angeles Hub"},
      ],
      "cost": 45.00,
      "insurance": true,
    },
    {
      "id": "SH001235",
      "customerName": "Michael Chen",
      "customerAddress": "789 Elm Drive, Seattle, WA 98101",
      "destination": "321 Maple Road, Miami, FL 33101",
      "packageType": "Documents",
      "weight": 0.5,
      "status": "delivered",
      "priority": "standard",
      "estimatedDelivery": DateTime.now().subtract(Duration(days: 1)),
      "trackingSteps": [
        {"status": "picked_up", "timestamp": DateTime.now().subtract(Duration(days: 3)), "location": "Seattle Warehouse"},
        {"status": "in_transit", "timestamp": DateTime.now().subtract(Duration(days: 2)), "location": "Denver Hub"},
        {"status": "delivered", "timestamp": DateTime.now().subtract(Duration(days: 1)), "location": "Miami Hub"},
      ],
      "cost": 15.00,
      "insurance": false,
    },
    {
      "id": "SH001236",
      "customerName": "Emily Rodriguez",
      "customerAddress": "456 Cedar Lane, Austin, TX 78701",
      "destination": "789 Birch Street, Portland, OR 97201",
      "packageType": "Clothing",
      "weight": 1.8,
      "status": "pending",
      "priority": "economy",
      "estimatedDelivery": DateTime.now().add(Duration(days: 5)),
      "trackingSteps": [
        {"status": "pending", "timestamp": DateTime.now(), "location": "Austin Warehouse"},
      ],
      "cost": 12.50,
      "insurance": false,
    },
    {
      "id": "SH001237",
      "customerName": "David Wilson",
      "customerAddress": "234 Spruce Court, Boston, MA 02101",
      "destination": "567 Fir Boulevard, Phoenix, AZ 85001",
      "packageType": "Fragile Items",
      "weight": 3.2,
      "status": "delayed",
      "priority": "express",
      "estimatedDelivery": DateTime.now().add(Duration(days: 2)),
      "trackingSteps": [
        {"status": "picked_up", "timestamp": DateTime.now().subtract(Duration(hours: 36)), "location": "Boston Warehouse"},
        {"status": "delayed", "timestamp": DateTime.now().subtract(Duration(hours: 6)), "location": "Atlanta Hub"},
      ],
      "cost": 38.75,
      "insurance": true,
    },
  ];

  List<Map<String, dynamic>> get filteredShipments {
    var filtered = shipments.where((shipment) {
      if (selectedFilter != 'all' && shipment["status"] != selectedFilter) {
        return false;
      }
      if (searchQuery.isNotEmpty) {
        return shipment["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               shipment["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }
      return true;
    }).toList();
    
    // Sort by priority: express, standard, economy
    filtered.sort((a, b) {
      Map<String, int> priorityOrder = {"express": 0, "standard": 1, "economy": 2};
      return (priorityOrder[a["priority"]] ?? 3).compareTo(priorityOrder[b["priority"]] ?? 3);
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipment Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(CreateShipmentView());
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${shipments.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Shipments",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${shipments.where((s) => s["status"] == "in_transit").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "In Transit",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${shipments.where((s) => s["status"] == "delivered").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Delivered",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: QTextField(
                          label: "Search by ID or Customer",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.search, color: primaryColor),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter Tabs
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: QHorizontalScroll(
              children: [
                'all', 'pending', 'in_transit', 'delivered', 'delayed'
              ].map((filter) => Container(
                margin: EdgeInsets.only(right: spMd),
                child: GestureDetector(
                  onTap: () {
                    selectedFilter = filter;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: selectedFilter == filter ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      filter.toUpperCase().replaceAll('_', ' '),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectedFilter == filter ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Shipments List
          Expanded(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : filteredShipments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 64,
                              color: disabledBoldColor,
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "No shipments found",
                              style: TextStyle(
                                fontSize: fsH6,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(spMd),
                        itemCount: filteredShipments.length,
                        itemBuilder: (context, index) {
                          final shipment = filteredShipments[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spMd),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                              boxShadow: [shadowMd],
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: _getStatusColor(shipment["status"]),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${shipment["id"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              "${shipment["customerName"]}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor(shipment["status"]).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "${shipment["status"]}".toUpperCase().replaceAll('_', ' '),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: _getStatusColor(shipment["status"]),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: spSm),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor(shipment["priority"]).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "${shipment["priority"]}".toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                                color: _getPriorityColor(shipment["priority"]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Package Info
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.inventory,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${shipment["packageType"]} • ${(shipment["weight"] as double).toStringAsFixed(1)}kg",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      if (shipment["insurance"] as bool) ...[
                                        SizedBox(width: spSm),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "INSURED",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  
                                  SizedBox(height: spSm),
                                  
                                  // Addresses
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${shipment["destination"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spSm),
                                  
                                  // Delivery Info
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Est. Delivery: ${(shipment["estimatedDelivery"] as DateTime).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\$${((shipment["cost"] as double)).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
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
                                          onPressed: () {
                                            // navigateTo(TrackingView(shipmentId: shipment["id"]));
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: QButton(
                                          label: "Details",
                                          size: bs.sm,
                                          onPressed: () {
                                            _showShipmentDetails(shipment);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.more_vert,
                                        size: bs.sm,
                                        onPressed: () {
                                          _showShipmentOptions(shipment);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(CreateShipmentView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return warningColor;
      case 'in_transit':
        return infoColor;
      case 'delivered':
        return successColor;
      case 'delayed':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'express':
        return dangerColor;
      case 'standard':
        return warningColor;
      case 'economy':
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _showShipmentDetails(Map<String, dynamic> shipment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledBoldColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Shipment Details",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Text("Shipment ID: ${shipment["id"]}"),
              Text("Customer: ${shipment["customerName"]}"),
              Text("Package: ${shipment["packageType"]}"),
              Text("Weight: ${(shipment["weight"] as double).toStringAsFixed(1)}kg"),
              Text("Cost: \$${((shipment["cost"] as double)).toStringAsFixed(2)}"),
              Text("Insurance: ${shipment["insurance"] as bool ? 'Yes' : 'No'}"),
              SizedBox(height: spMd),
              Text(
                "From:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${shipment["customerAddress"]}"),
              SizedBox(height: spSm),
              Text(
                "To:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${shipment["destination"]}"),
            ],
          ),
        ),
      ),
    );
  }

  void _showShipmentOptions(Map<String, dynamic> shipment) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Shipment Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Shipment"),
              onTap: () {
                back();
                // navigateTo(EditShipmentView(shipment: shipment));
              },
            ),
            ListTile(
              leading: Icon(Icons.print),
              title: Text("Print Label"),
              onTap: () {
                back();
                ss("Label printing initiated");
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text("Cancel Shipment"),
              onTap: () async {
                back();
                bool isConfirmed = await confirm("Are you sure you want to cancel this shipment?");
                if (isConfirmed) {
                  ss("Shipment cancelled");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
