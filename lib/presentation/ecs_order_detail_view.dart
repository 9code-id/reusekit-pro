import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsOrderDetailView extends StatefulWidget {
  const EcsOrderDetailView({super.key});

  @override
  State<EcsOrderDetailView> createState() => _EcsOrderDetailViewState();
}

class _EcsOrderDetailViewState extends State<EcsOrderDetailView> {
  Map<String, dynamic> orderDetail = {
    "id": "ORD-2024-001234",
    "date": "2024-06-14T10:30:00",
    "status": "delivered",
    "deliveryDate": "2024-06-18T14:30:00",
    "trackingNumber": "TN123456789",
    "total": 98.06,
    "subtotal": 89.97,
    "shipping": 9.99,
    "tax": 8.10,
    "discount": 10.00,
    "paymentMethod": "Visa •••• 4242",
    "shippingAddress": {
      "name": "John Doe",
      "address": "123 Main Street",
      "city": "New York",
      "state": "NY",
      "zip": "10001",
      "phone": "+1 (555) 123-4567"
    },
    "billingAddress": {
      "name": "John Doe",
      "address": "123 Main Street", 
      "city": "New York",
      "state": "NY",
      "zip": "10001"
    },
    "items": [
      {
        "id": 1,
        "name": "Wireless Bluetooth Headphones",
        "description": "High-quality wireless headphones with noise cancellation",
        "price": 59.99,
        "quantity": 1,
        "image": "https://picsum.photos/100/100?random=1&keyword=headphones",
        "sku": "WBH-001"
      },
      {
        "id": 2,
        "name": "Phone Case - Clear",
        "description": "Transparent protective case for smartphones",
        "price": 19.99,
        "quantity": 1,
        "image": "https://picsum.photos/100/100?random=2&keyword=phone",
        "sku": "PCC-002"
      },
      {
        "id": 3,
        "name": "USB-C Cable",
        "description": "Fast charging USB-C cable 3ft length",
        "price": 9.99,
        "quantity": 1,
        "image": "https://picsum.photos/100/100?random=3&keyword=cable",
        "sku": "UCC-003"
      }
    ]
  };

  List<Map<String, dynamic>> trackingHistory = [
    {
      "status": "Order Confirmed",
      "description": "Your order has been received and confirmed",
      "date": "2024-06-14T10:30:00",
      "location": "Order Processing Center",
    },
    {
      "status": "Processing",
      "description": "Your items are being prepared for shipment",
      "date": "2024-06-14T14:00:00", 
      "location": "Fulfillment Center - NY",
    },
    {
      "status": "Shipped",
      "description": "Your order has been dispatched",
      "date": "2024-06-15T09:15:00",
      "location": "Distribution Center - NY",
    },
    {
      "status": "In Transit",
      "description": "Package is on the way to your address",
      "date": "2024-06-16T12:45:00",
      "location": "Local Delivery Hub",
    },
    {
      "status": "Out for Delivery", 
      "description": "Package is out for delivery",
      "date": "2024-06-18T08:00:00",
      "location": "Local Delivery Vehicle",
    },
    {
      "status": "Delivered",
      "description": "Package delivered successfully",
      "date": "2024-06-18T14:30:00",
      "location": "Delivered to your address",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareOrderDetails();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _downloadInvoice();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${orderDetail["id"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(orderDetail["status"] as String),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          _getStatusLabel(orderDetail["status"] as String),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  _buildDetailRow("Order Date", "${DateTime.parse(orderDetail["date"] as String).dMMMy}"),
                  if (orderDetail["deliveryDate"] != "")
                    _buildDetailRow("Delivery Date", "${DateTime.parse(orderDetail["deliveryDate"] as String).dMMMy}"),
                  if (orderDetail["trackingNumber"] != "")
                    _buildDetailRow("Tracking Number", "${orderDetail["trackingNumber"]}"),
                  _buildDetailRow("Payment Method", "${orderDetail["paymentMethod"]}"),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            Text(
              "Order Items",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ...(orderDetail["items"] as List).map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${item["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${item["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Text(
                                "SKU: ${item["sku"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Qty: ${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "\$${(item["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            SizedBox(height: spLg),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  _buildSummaryRow("Subtotal", orderDetail["subtotal"] as double),
                  _buildSummaryRow("Shipping", orderDetail["shipping"] as double),
                  _buildSummaryRow("Tax", orderDetail["tax"] as double),
                  _buildSummaryRow("Discount", -(orderDetail["discount"] as double), color: successColor),
                  Divider(),
                  _buildSummaryRow("Total", orderDetail["total"] as double, isTotal: true),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            Text(
              "Tracking Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: trackingHistory.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> tracking = entry.value;
                  bool isLast = index == trackingHistory.length - 1;
                  
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 60,
                              color: primaryColor,
                            ),
                        ],
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${tracking["status"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${tracking["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${DateTime.parse(tracking["date"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${tracking["location"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if (!isLast) SizedBox(height: spMd),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spLg),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shipping Address",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderDetail["shippingAddress"]["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${orderDetail["shippingAddress"]["address"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${orderDetail["shippingAddress"]["city"]}, ${orderDetail["shippingAddress"]["state"]} ${orderDetail["shippingAddress"]["zip"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${orderDetail["shippingAddress"]["phone"]}",
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
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Billing Address",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderDetail["billingAddress"]["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${orderDetail["billingAddress"]["address"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${orderDetail["billingAddress"]["city"]}, ${orderDetail["billingAddress"]["state"]} ${orderDetail["billingAddress"]["zip"]}",
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
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            if (orderDetail["status"] == "delivered") ...[
              QButton(
                label: "Reorder Items",
                size: bs.md,
                onPressed: () {
                  _reorderItems();
                },
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Return Items",
                      size: bs.md,
                      onPressed: () {
                        //navigateTo('return_request')
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Leave Review",
                      size: bs.md,
                      onPressed: () {
                        //navigateTo('leave_review')
                      },
                    ),
                  ),
                ],
              ),
            ] else if (orderDetail["status"] == "processing") ...[
              QButton(
                label: "Cancel Order",
                size: bs.md,
                onPressed: () {
                  _cancelOrder();
                },
              ),
            ] else if (orderDetail["status"] == "in_transit") ...[
              QButton(
                label: "Track Package",
                size: bs.md,
                onPressed: () {
                  //navigateTo('track_package')
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {Color? color, bool isTotal = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
          Text(
            "${amount < 0 ? '-' : ''}\$${amount.abs().currency}",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? primaryColor : null),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return successColor;
      case 'in_transit':
        return infoColor;
      case 'processing':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'delivered':
        return 'Delivered';
      case 'in_transit':
        return 'In Transit';
      case 'processing':
        return 'Processing';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  void _shareOrderDetails() {
    ss("Order details shared successfully");
  }

  void _downloadInvoice() {
    ss("Invoice downloaded successfully");
  }

  void _reorderItems() async {
    bool isConfirmed = await confirm("Add all items from this order to your cart?");
    if (isConfirmed) {
      ss("Items added to cart successfully");
    }
  }

  void _cancelOrder() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this order? This action cannot be undone.");
    if (isConfirmed) {
      ss("Order cancelled successfully");
      back();
    }
  }
}
