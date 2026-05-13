import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOrder8View extends StatefulWidget {
  @override
  State<GrlOrder8View> createState() => _GrlOrder8ViewState();
}

class _GrlOrder8ViewState extends State<GrlOrder8View> {
  Map<String, dynamic> orderDetails = {
    "id": "ORD-2024-001",
    "status": "shipped",
    "customerInfo": {
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 (555) 123-4567",
      "customerId": "CUST-001"
    },
    "orderDate": "2024-01-15",
    "shippedDate": "2024-01-17",
    "estimatedDelivery": "2024-01-20",
    "trackingNumber": "TRK001234567",
    "carrier": "FedEx",
    "priority": "high",
    "paymentMethod": "Credit Card",
    "paymentStatus": "paid",
    "shippingAddress": {
      "street": "123 Main Street, Apartment 4B",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "country": "United States"
    },
    "billingAddress": {
      "street": "123 Main Street, Apartment 4B",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "country": "United States"
    },
    "items": [
      {
        "id": "1",
        "name": "Wireless Bluetooth Headphones Pro",
        "sku": "WBH-001",
        "image": "https://picsum.photos/100/100?random=1&keyword=headphones",
        "price": 159.99,
        "qty": 1,
        "total": 159.99,
        "description": "Premium wireless headphones with active noise cancellation"
      },
      {
        "id": "2",
        "name": "Smartphone Protective Case Premium",
        "sku": "SPC-002",
        "image": "https://picsum.photos/100/100?random=2&keyword=phone",
        "price": 39.99,
        "qty": 2,
        "total": 79.98,
        "description": "Military-grade protection with wireless charging compatibility"
      },
      {
        "id": "3",
        "name": "USB-C Fast Charging Cable",
        "sku": "UCC-003",
        "image": "https://picsum.photos/100/100?random=3&keyword=cable",
        "price": 24.99,
        "qty": 1,
        "total": 24.99,
        "description": "3-meter braided cable with fast charging support"
      }
    ],
    "pricing": {
      "subtotal": 264.96,
      "discount": 26.50,
      "shipping": 9.99,
      "tax": 21.20,
      "total": 269.65
    },
    "notes": "Customer requested expedited shipping. Handle with care - fragile items included.",
    "internalNotes": "VIP customer - priority processing. Check quality before shipment."
  };

  List<Map<String, dynamic>> orderHistory = [
    {
      "date": "2024-01-15 10:30 AM",
      "status": "Order Placed",
      "description": "Order successfully placed by customer",
      "user": "System"
    },
    {
      "date": "2024-01-15 10:35 AM",
      "status": "Payment Confirmed",
      "description": "Payment processed successfully via Credit Card",
      "user": "Payment Gateway"
    },
    {
      "date": "2024-01-15 11:00 AM",
      "status": "Order Approved",
      "description": "Order approved for processing",
      "user": "Sarah Johnson"
    },
    {
      "date": "2024-01-16 09:15 AM",
      "status": "Processing Started",
      "description": "Order moved to fulfillment center",
      "user": "Mike Davis"
    },
    {
      "date": "2024-01-16 14:30 PM",
      "status": "Items Picked",
      "description": "All items picked from warehouse",
      "user": "Emily Wilson"
    },
    {
      "date": "2024-01-16 16:45 PM",
      "status": "Order Packed",
      "description": "Order packed and ready for shipment",
      "user": "Robert Brown"
    },
    {
      "date": "2024-01-17 08:00 AM",
      "status": "Order Shipped",
      "description": "Order shipped via FedEx with tracking number TRK001234567",
      "user": "System"
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "processing":
        return infoColor;
      case "shipped":
        return primaryColor;
      case "delivered":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "pending":
        return "Pending";
      case "processing":
        return "Processing";
      case "shipped":
        return "Shipped";
      case "delivered":
        return "Delivered";
      default:
        return "Unknown";
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getPriorityText(String priority) {
    switch (priority) {
      case "high":
        return "High Priority";
      case "medium":
        return "Medium Priority";
      case "low":
        return "Low Priority";
      default:
        return "Normal";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              // Print order
              ss("Order details printed");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share order details
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Order Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(orderDetails["status"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ${orderDetails["id"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Placed on ${orderDetails["orderDate"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
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
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(orderDetails["status"]).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              _getStatusText(orderDetails["status"]),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(orderDetails["status"]),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(orderDetails["priority"]).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              _getPriorityText(orderDetails["priority"]),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getPriorityColor(orderDetails["priority"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  if (orderDetails["trackingNumber"] != null)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Tracking: ${orderDetails["trackingNumber"]} via ${orderDetails["carrier"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Copy tracking number
                              ss("Tracking number copied");
                            },
                            child: Icon(
                              Icons.copy,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Estimated Delivery: ${orderDetails["estimatedDelivery"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "Total: \$${(orderDetails["pricing"]["total"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Customer Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Customer Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 20,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderDetails["customerInfo"]["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "ID: ${orderDetails["customerInfo"]["customerId"]}",
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
                  
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 20,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${orderDetails["customerInfo"]["email"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 20,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${orderDetails["customerInfo"]["phone"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Order Items
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Order Items",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...(orderDetails["items"] as List).map((item) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${item["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "SKU: ${item["sku"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${item["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Qty: ${item["qty"]} × \$${(item["price"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(item["total"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Pricing Breakdown
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Subtotal",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(orderDetails["pricing"]["subtotal"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Discount",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "-\$${(orderDetails["pricing"]["discount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Shipping",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(orderDetails["pricing"]["shipping"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Tax",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(orderDetails["pricing"]["tax"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(color: disabledColor),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(orderDetails["pricing"]["total"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Shipping & Billing Addresses
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Shipping Address",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${orderDetails["shippingAddress"]["street"]}\n${orderDetails["shippingAddress"]["city"]}, ${orderDetails["shippingAddress"]["state"]} ${orderDetails["shippingAddress"]["zipCode"]}\n${orderDetails["shippingAddress"]["country"]}",
                          style: TextStyle(
                            fontSize: 14,
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
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Billing Address",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${orderDetails["billingAddress"]["street"]}\n${orderDetails["billingAddress"]["city"]}, ${orderDetails["billingAddress"]["state"]} ${orderDetails["billingAddress"]["zipCode"]}\n${orderDetails["billingAddress"]["country"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Order Notes
            if (orderDetails["notes"] != null || orderDetails["internalNotes"] != null)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Notes",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    if (orderDetails["notes"] != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Customer Notes:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "${orderDetails["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    if (orderDetails["internalNotes"] != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Internal Notes:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "${orderDetails["internalNotes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

            // Order History
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Order History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...orderHistory.map((history) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${history["status"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${history["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${history["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "By: ${history["user"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Edit Order",
                    size: bs.md,
                    onPressed: () {
                      // Edit order
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Cancel Order",
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
                      if (isConfirmed) {
                        // Cancel order logic
                        ss("Order cancelled successfully");
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
