import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaShippingView extends StatefulWidget {
  const ImaShippingView({super.key});

  @override
  State<ImaShippingView> createState() => _ImaShippingViewState();
}

class _ImaShippingViewState extends State<ImaShippingView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCarrier = "All";
  String selectedPriority = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Ready to Ship", "value": "Ready to Ship"},
    {"label": "Shipped", "value": "Shipped"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Out for Delivery", "value": "Out for Delivery"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Failed Delivery", "value": "Failed Delivery"},
  ];

  List<Map<String, dynamic>> carrierItems = [
    {"label": "All Carriers", "value": "All"},
    {"label": "FedEx", "value": "FedEx"},
    {"label": "UPS", "value": "UPS"},
    {"label": "DHL", "value": "DHL"},
    {"label": "USPS", "value": "USPS"},
    {"label": "Local Courier", "value": "Local Courier"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priority", "value": "All"},
    {"label": "Express", "value": "Express"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Economy", "value": "Economy"},
  ];

  List<Map<String, dynamic>> shipments = [
    {
      "id": "SH-2024-001",
      "orderNumber": "ORD-45892",
      "trackingNumber": "1Z999AA1234567890",
      "customer": "ABC Electronics Store",
      "status": "In Transit",
      "carrier": "UPS",
      "priority": "Express",
      "origin": "Warehouse A, New York",
      "destination": "123 Main St, Los Angeles, CA",
      "shipDate": "2024-06-18",
      "estimatedDelivery": "2024-06-20",
      "actualDelivery": null,
      "weight": 12.5,
      "dimensions": "40x30x20 cm",
      "shippingCost": 45.99,
      "insuredValue": 2450.00,
      "specialInstructions": "Signature required",
      "items": [
        {"sku": "ELEC-001", "name": "Smartphone", "quantity": 2},
        {"sku": "ELEC-002", "name": "Laptop", "quantity": 1},
        {"sku": "ELEC-003", "name": "Tablet", "quantity": 3},
        {"sku": "ELEC-004", "name": "Headphones", "quantity": 2},
      ],
      "trackingHistory": [
        {"date": "2024-06-18 10:00", "status": "Shipped", "location": "New York"},
        {"date": "2024-06-18 15:30", "status": "In Transit", "location": "Philadelphia"},
        {"date": "2024-06-19 08:00", "status": "In Transit", "location": "Chicago"},
      ]
    },
    {
      "id": "SH-2024-002",
      "orderNumber": "ORD-45893",
      "trackingNumber": "1234567890123456",
      "customer": "Tech Solutions Ltd",
      "status": "Ready to Ship",
      "carrier": "FedEx",
      "priority": "Standard",
      "origin": "Warehouse B, Chicago",
      "destination": "456 Oak Ave, Miami, FL",
      "shipDate": null,
      "estimatedDelivery": "2024-06-22",
      "actualDelivery": null,
      "weight": 25.8,
      "dimensions": "60x40x30 cm",
      "shippingCost": 32.50,
      "insuredValue": 3200.00,
      "specialInstructions": "Fragile - handle with care",
      "items": [
        {"sku": "COMP-001", "name": "Desktop PC", "quantity": 2},
        {"sku": "COMP-002", "name": "Monitor", "quantity": 4},
        {"sku": "COMP-003", "name": "Keyboard", "quantity": 6},
      ],
      "trackingHistory": []
    },
    {
      "id": "SH-2024-003",
      "orderNumber": "ORD-45894",
      "customer": "Home Appliances Co",
      "trackingNumber": "9876543210987654",
      "status": "Delivered",
      "carrier": "Local Courier",
      "priority": "Standard",
      "origin": "Warehouse C, Houston",
      "destination": "789 Pine St, Dallas, TX",
      "shipDate": "2024-06-17",
      "estimatedDelivery": "2024-06-18",
      "actualDelivery": "2024-06-18",
      "weight": 45.2,
      "dimensions": "80x60x40 cm",
      "shippingCost": 75.00,
      "insuredValue": 1800.00,
      "specialInstructions": "Delivery to loading dock",
      "items": [
        {"sku": "APPL-001", "name": "Refrigerator", "quantity": 1},
        {"sku": "APPL-002", "name": "Washing Machine", "quantity": 1},
        {"sku": "APPL-003", "name": "Microwave", "quantity": 4},
      ],
      "trackingHistory": [
        {"date": "2024-06-17 09:00", "status": "Shipped", "location": "Houston"},
        {"date": "2024-06-17 14:00", "status": "In Transit", "location": "Houston Hub"},
        {"date": "2024-06-18 10:00", "status": "Out for Delivery", "location": "Dallas"},
        {"date": "2024-06-18 15:30", "status": "Delivered", "location": "Dallas"},
      ]
    },
    {
      "id": "SH-2024-004",
      "orderNumber": "ORD-45895",
      "trackingNumber": "DHL123456789",
      "customer": "Office Supplies Inc",
      "status": "Out for Delivery",
      "carrier": "DHL",
      "priority": "Express",
      "origin": "Warehouse D, Seattle",
      "destination": "321 Elm St, Portland, OR",
      "shipDate": "2024-06-19",
      "estimatedDelivery": "2024-06-19",
      "actualDelivery": null,
      "weight": 18.7,
      "dimensions": "Various",
      "shippingCost": 28.75,
      "insuredValue": 1200.00,
      "specialInstructions": "Business hours delivery only",
      "items": [
        {"sku": "OFF-001", "name": "Office Chair", "quantity": 5},
        {"sku": "OFF-002", "name": "Desk Lamp", "quantity": 10},
      ],
      "trackingHistory": [
        {"date": "2024-06-19 08:00", "status": "Shipped", "location": "Seattle"},
        {"date": "2024-06-19 12:00", "status": "In Transit", "location": "Portland Hub"},
        {"date": "2024-06-19 14:00", "status": "Out for Delivery", "location": "Portland"},
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredShipments {
    return shipments.where((shipment) {
      final matchesSearch = shipment["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          shipment["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          shipment["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          shipment["trackingNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "All" || shipment["status"] == selectedStatus;
      final matchesCarrier = selectedCarrier == "All" || shipment["carrier"] == selectedCarrier;
      final matchesPriority = selectedPriority == "All" || shipment["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesCarrier && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "Out for Delivery":
        return primaryColor;
      case "In Transit":
        return infoColor;
      case "Shipped":
        return warningColor;
      case "Ready to Ship":
        return disabledBoldColor;
      case "Failed Delivery":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Express":
        return dangerColor;
      case "Standard":
        return primaryColor;
      case "Economy":
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _createShipment(Map<String, dynamic> shipment) {
    shipment["status"] = "Shipped";
    shipment["shipDate"] = DateTime.now().toIso8601String().split('T')[0];
    setState(() {});
    ss("Shipment created for ${shipment["id"]}");
  }

  void _viewTrackingDetails(Map<String, dynamic> shipment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Tracking Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tracking: ${shipment["trackingNumber"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("Status: ${shipment["status"]}"),
              Text("Carrier: ${shipment["carrier"]}"),
              Text("Origin: ${shipment["origin"]}"),
              Text("Destination: ${shipment["destination"]}"),
              if (shipment["estimatedDelivery"] != null)
                Text("Est. Delivery: ${shipment["estimatedDelivery"]}"),
              if (shipment["actualDelivery"] != null)
                Text("Actual Delivery: ${shipment["actualDelivery"]}"),
              SizedBox(height: spSm),
              Text("Tracking History:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...((shipment["trackingHistory"] as List).map((track) => Padding(
                padding: EdgeInsets.only(top: spXs),
                child: Text("• ${track["date"]} - ${track["status"]} (${track["location"]})"),
              ))),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _viewShipmentDetails(Map<String, dynamic> shipment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Shipment Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("ID: ${shipment["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("Order: ${shipment["orderNumber"]}"),
              Text("Customer: ${shipment["customer"]}"),
              Text("Status: ${shipment["status"]}"),
              Text("Carrier: ${shipment["carrier"]}"),
              Text("Priority: ${shipment["priority"]}"),
              Text("Weight: ${shipment["weight"]} kg"),
              Text("Dimensions: ${shipment["dimensions"]}"),
              Text("Shipping Cost: \$${(shipment["shippingCost"] as double).currency}"),
              Text("Insured Value: \$${(shipment["insuredValue"] as double).currency}"),
              if (shipment["specialInstructions"] != null)
                Text("Instructions: ${shipment["specialInstructions"]}"),
              SizedBox(height: spSm),
              Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...((shipment["items"] as List).map((item) => Padding(
                padding: EdgeInsets.only(top: spXs),
                child: Text("• ${item["name"]} (${item["quantity"]})"),
              ))),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildShipmentCard(Map<String, dynamic> shipment) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                      "${shipment["customer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(shipment["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${shipment["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(shipment["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${shipment["carrier"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(shipment["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${shipment["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(shipment["priority"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
              border: Border.all(color: primaryColor.withAlpha(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tracking: ${shipment["trackingNumber"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.place, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "From: ${shipment["origin"]}",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.place, size: 14, color: primaryColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "To: ${shipment["destination"]}",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.scale, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${shipment["weight"]} kg",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.attach_money, size: 16, color: successColor),
              SizedBox(width: spXs),
              Text(
                "\$${(shipment["shippingCost"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          if (shipment["estimatedDelivery"] != null) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: warningColor),
                SizedBox(width: spXs),
                Text(
                  "Est. Delivery: ${shipment["estimatedDelivery"]}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ),
          ],
          if (shipment["specialInstructions"] != null) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${shipment["specialInstructions"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () => _viewShipmentDetails(shipment),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Track",
                size: bs.sm,
                onPressed: () => _viewTrackingDetails(shipment),
              ),
              SizedBox(width: spSm),
              if (shipment["status"] == "Ready to Ship")
                QButton(
                  label: "Ship",
                  size: bs.sm,
                  onPressed: () => _createShipment(shipment),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    int totalShipments = shipments.length;
    int readyToShip = shipments.where((s) => s["status"] == "Ready to Ship").length;
    int inTransit = shipments.where((s) => s["status"] == "In Transit" || s["status"] == "Out for Delivery").length;
    int delivered = shipments.where((s) => s["status"] == "Delivered").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.local_shipping, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalShipments",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Shipments",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pending_actions, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$readyToShip",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Ready to Ship",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.flight_takeoff, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$inTransit",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "In Transit",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$delivered",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Delivered",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Recent Shipments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...shipments.take(3).map((shipment) => _buildShipmentCard(shipment)),
        ],
      ),
    );
  }

  Widget _buildActiveTab() {
    List<Map<String, dynamic>> activeShipments = shipments.where((s) => 
        s["status"] != "Delivered").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search shipments...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter by Carrier",
                  items: carrierItems,
                  value: selectedCarrier,
                  onChanged: (value, label) {
                    selectedCarrier = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (activeShipments.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.inbox, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No active shipments found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...filteredShipments.where((s) => s["status"] != "Delivered").map((shipment) => _buildShipmentCard(shipment)),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    List<Map<String, dynamic>> deliveredShipments = shipments.where((s) => 
        s["status"] == "Delivered").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search delivered shipments...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (deliveredShipments.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.history, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No delivered shipments found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...deliveredShipments.map((shipment) => _buildShipmentCard(shipment)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Shipping",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Active", icon: Icon(Icons.local_shipping)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActiveTab(),
        _buildHistoryTab(),
      ],
    );
  }
}
