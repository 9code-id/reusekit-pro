import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPrintServicesView extends StatefulWidget {
  const PpaPrintServicesView({super.key});

  @override
  State<PpaPrintServicesView> createState() => _PpaPrintServicesViewState();
}

class _PpaPrintServicesViewState extends State<PpaPrintServicesView> {
  String selectedPrintType = "Standard Photo";
  String selectedSize = "4x6";
  String selectedPaper = "Glossy";
  int quantity = 1;
  String selectedPhotos = "";
  
  List<Map<String, dynamic>> printTypes = [
    {"label": "Standard Photo", "value": "Standard Photo"},
    {"label": "Professional Print", "value": "Professional Print"},
    {"label": "Canvas Print", "value": "Canvas Print"},
    {"label": "Metal Print", "value": "Metal Print"},
    {"label": "Acrylic Print", "value": "Acrylic Print"},
    {"label": "Photo Book", "value": "Photo Book"},
    {"label": "Calendar", "value": "Calendar"},
    {"label": "Greeting Card", "value": "Greeting Card"},
  ];

  List<Map<String, dynamic>> sizeOptions = [
    {"label": "4x6 inch", "value": "4x6"},
    {"label": "5x7 inch", "value": "5x7"},
    {"label": "8x10 inch", "value": "8x10"},
    {"label": "11x14 inch", "value": "11x14"},
    {"label": "16x20 inch", "value": "16x20"},
    {"label": "20x24 inch", "value": "20x24"},
    {"label": "Custom Size", "value": "Custom"},
  ];

  List<Map<String, dynamic>> paperTypes = [
    {"label": "Glossy", "value": "Glossy"},
    {"label": "Matte", "value": "Matte"},
    {"label": "Satin", "value": "Satin"},
    {"label": "Pearl", "value": "Pearl"},
    {"label": "Metallic", "value": "Metallic"},
  ];

  List<Map<String, dynamic>> printOrders = [
    {
      "id": "order_001",
      "type": "Standard Photo",
      "size": "4x6",
      "paper": "Glossy",
      "quantity": 25,
      "photos": 15,
      "orderDate": "2024-06-16",
      "status": "Processing",
      "estimatedDelivery": "2024-06-20",
      "totalPrice": 37.50,
      "shippingAddress": "123 Main St, City, State 12345",
    },
    {
      "id": "order_002",
      "type": "Canvas Print",
      "size": "16x20",
      "paper": "Canvas",
      "quantity": 2,
      "photos": 2,
      "orderDate": "2024-06-15",
      "status": "Shipped",
      "estimatedDelivery": "2024-06-18",
      "totalPrice": 89.98,
      "trackingNumber": "1Z999AA1234567890",
      "shippingAddress": "456 Oak Ave, City, State 67890",
    },
    {
      "id": "order_003",
      "type": "Photo Book",
      "size": "8x10",
      "paper": "Matte",
      "quantity": 1,
      "photos": 50,
      "orderDate": "2024-06-14",
      "status": "Delivered",
      "estimatedDelivery": "2024-06-17",
      "totalPrice": 45.99,
      "shippingAddress": "789 Pine Rd, City, State 54321",
    },
  ];

  List<Map<String, dynamic>> printServices = [
    {
      "name": "Local Print Shop",
      "type": "Local Partner",
      "rating": 4.8,
      "deliveryTime": "2-3 days",
      "price": "From \$0.99",
      "services": ["Standard Prints", "Canvas", "Photo Books"],
      "address": "Downtown Photo Center",
    },
    {
      "name": "Online Pro Prints",
      "type": "Online Service",
      "rating": 4.6,
      "deliveryTime": "3-5 days",
      "price": "From \$0.79",
      "services": ["All Print Types", "Custom Sizes", "Bulk Orders"],
      "address": "Online Delivery",
    },
    {
      "name": "Express Photo",
      "type": "Express Service",
      "rating": 4.4,
      "deliveryTime": "1-2 days",
      "price": "From \$1.49",
      "services": ["Rush Orders", "Standard Prints", "Professional"],
      "address": "City Center Mall",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Print Services"),
        actions: [
          IconButton(
            icon: Icon(Icons.local_shipping),
            onPressed: () {
              _showOrderTracking();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showPrintSettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.print,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Professional Print Services",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Transform your digital memories into beautiful physical prints",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Create Print Order",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Select Photos",
                          size: bs.md,
                          icon: Icons.photo_library,
                          onPressed: () {
                            _selectPhotosForPrint();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "12 selected",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  QDropdownField(
                    label: "Print Type",
                    items: printTypes,
                    value: selectedPrintType,
                    onChanged: (value, label) {
                      selectedPrintType = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Size",
                          items: sizeOptions,
                          value: selectedSize,
                          onChanged: (value, label) {
                            selectedSize = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Paper Type",
                          items: paperTypes,
                          value: selectedPaper,
                          onChanged: (value, label) {
                            selectedPaper = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QNumberField(
                    label: "Quantity per Photo",
                    value: quantity.toString(),
                    onChanged: (value) {
                      quantity = int.tryParse(value) ?? 1;
                      setState(() {});
                    },
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "• 12 photos × $quantity prints each = ${12 * quantity} total prints",
                          style: TextStyle(color: disabledBoldColor, fontSize: 14),
                        ),
                        Text(
                          "• Size: $selectedSize on $selectedPaper paper",
                          style: TextStyle(color: disabledBoldColor, fontSize: 14),
                        ),
                        Text(
                          "• Estimated cost: \$${((12 * quantity) * 1.25).toStringAsFixed(2)}",
                          style: TextStyle(color: disabledBoldColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Available Print Services",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: printServices.length,
              itemBuilder: (context, index) {
                final service = printServices[index];
                return _buildPrintServiceCard(service);
              },
            ),

            QButton(
              label: "Create Print Order",
              size: bs.md,
              icon: Icons.shopping_cart,
              onPressed: () {
                _createPrintOrder();
              },
            ),

            Text(
              "Recent Orders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: printOrders.length,
              itemBuilder: (context, index) {
                final order = printOrders[index];
                return _buildOrderCard(order);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrintServiceCard(Map<String, dynamic> service) {
    return Container(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${service["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${service["type"]} • ${service["address"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${service["price"]}",
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.star,
                color: warningColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${service["rating"]}",
                style: TextStyle(
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.schedule,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${service["deliveryTime"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Wrap(
            spacing: spXs,
            children: (service["services"] as List).map((serviceType) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Text(
                  serviceType.toString(),
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 11,
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              QButton(
                label: "Select Service",
                size: bs.sm,
                onPressed: () {
                  _selectPrintService(service["name"]);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "View Details",
                size: bs.sm,
                icon: Icons.info,
                onPressed: () {
                  _viewServiceDetails(service);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor = _getOrderStatusColor(order["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
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
                      "Order #${order["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Ordered on ${order["orderDate"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${order["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Text(
                "${order["type"]} • ${order["size"]} • ${order["paper"]}",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.photo,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${order["photos"]} photos",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.format_list_numbered,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${order["quantity"]} prints",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                "\$${(order["totalPrice"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.local_shipping,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  order["status"] == "Delivered" 
                      ? "Delivered to ${order["shippingAddress"]}"
                      : "Estimated delivery: ${order["estimatedDelivery"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          if (order["trackingNumber"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(
                  Icons.track_changes,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Tracking: ${order["trackingNumber"]}",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              QButton(
                label: "View Details",
                size: bs.sm,
                icon: Icons.info,
                onPressed: () {
                  _viewOrderDetails(order);
                },
              ),
              SizedBox(width: spSm),
              if (order["trackingNumber"] != null) ...[
                QButton(
                  label: "Track Order",
                  size: bs.sm,
                  icon: Icons.track_changes,
                  onPressed: () {
                    _trackOrder(order["trackingNumber"]);
                  },
                ),
                SizedBox(width: spSm),
              ],
              if (order["status"] == "Delivered") ...[
                QButton(
                  label: "Reorder",
                  size: bs.sm,
                  icon: Icons.repeat,
                  onPressed: () {
                    _reorder(order["id"]);
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _getOrderStatusColor(String status) {
    switch (status) {
      case "Processing":
        return warningColor;
      case "Shipped":
        return infoColor;
      case "Delivered":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _selectPhotosForPrint() {
    ss("12 photos selected for printing");
  }

  void _createPrintOrder() {
    if (quantity <= 0) {
      se("Please enter a valid quantity");
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Print Order"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Summary:"),
              Text("• 12 photos"),
              Text("• $selectedPrintType"),
              Text("• Size: $selectedSize"),
              Text("• Paper: $selectedPaper"),
              Text("• Quantity: $quantity per photo"),
              Text("• Total prints: ${12 * quantity}"),
              SizedBox(height: spSm),
              Text(
                "Estimated Total: \$${((12 * quantity) * 1.25).toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Place Order",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Print order placed successfully!");
              },
            ),
          ],
        );
      },
    );
  }

  void _selectPrintService(String serviceName) {
    ss("Selected $serviceName as print service");
  }

  void _viewServiceDetails(Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${service["name"]}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Type: ${service["type"]}"),
              Text("Rating: ${service["rating"]} stars"),
              Text("Delivery: ${service["deliveryTime"]}"),
              Text("Price: ${service["price"]}"),
              Text("Address: ${service["address"]}"),
              SizedBox(height: spSm),
              Text("Services:"),
              ...(service["services"] as List).map((s) => Text("• $s")),
            ],
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showOrderTracking() {
    si("Showing order tracking");
  }

  void _showPrintSettings() {
    si("Opening print settings");
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    si("Viewing order details for ${order["id"]}");
  }

  void _trackOrder(String trackingNumber) {
    si("Tracking order: $trackingNumber");
  }

  void _reorder(String orderId) {
    si("Reordering $orderId");
  }
}
