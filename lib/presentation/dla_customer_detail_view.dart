import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaCustomerDetailView extends StatefulWidget {
  const DlaCustomerDetailView({super.key});

  @override
  State<DlaCustomerDetailView> createState() => _DlaCustomerDetailViewState();
}

class _DlaCustomerDetailViewState extends State<DlaCustomerDetailView> {
  bool loading = false;

  Map<String, dynamic> customerData = {
    "id": "CUST-002",
    "name": "Sarah Johnson",
    "email": "s.johnson@techcorp.com",
    "phone": "+1234567891",
    "company": "TechCorp Solutions",
    "type": "business",
    "status": "active",
    "address": "456 Business Blvd, Corporate City, ST 67890",
    "billing_address": "Same as delivery address",
    "preferred_time": "afternoon",
    "business_hours": "Mon-Fri 9:00-17:00",
    "contact_person": "Sarah Johnson",
    "total_deliveries": 45,
    "successful_deliveries": 43,
    "failed_deliveries": 2,
    "last_delivery": "2024-01-13",
    "first_delivery": "2023-03-25",
    "created_at": "2023-03-20T14:15:00Z",
    "updated_at": "2024-01-13T16:45:00Z",
    "avatar": "https://picsum.photos/150/150?random=2&keyword=business",
    "sms_notifications": true,
    "email_notifications": true,
    "require_signature": true,
    "allow_substitution": false,
    "rating": 4.9,
    "total_spent": 12750.50,
    "average_order_value": 283.34,
    "loyalty_points": 1275,
    "delivery_instructions": "Use main entrance. Security desk will validate. Call 15 minutes before arrival.",
    "special_requirements": "Temperature controlled items only. No weekend deliveries.",
    "payment_terms": "Net 30",
    "credit_limit": 50000.00,
    "account_manager": "Michael Roberts",
  };

  List<Map<String, dynamic>> recentDeliveries = [
    {
      "id": "DEL-045",
      "date": "2024-01-13",
      "time": "14:30",
      "status": "delivered",
      "driver": "John Smith",
      "vehicle": "TRK-001",
      "items": 8,
      "value": 340.50,
      "rating": 5.0,
      "notes": "Perfect delivery, on time",
    },
    {
      "id": "DEL-044",
      "date": "2024-01-10",
      "time": "15:45",
      "status": "delivered",
      "driver": "Lisa Chen",
      "vehicle": "VAN-002",
      "items": 12,
      "value": 275.80,
      "rating": 4.8,
      "notes": "Good service",
    },
    {
      "id": "DEL-043",
      "date": "2024-01-08",
      "time": "13:20",
      "status": "delivered",
      "driver": "Mike Wilson",
      "vehicle": "TRK-003",
      "items": 6,
      "value": 198.75,
      "rating": 5.0,
      "notes": "Excellent handling",
    },
    {
      "id": "DEL-042",
      "date": "2024-01-05",
      "time": "16:10",
      "status": "failed",
      "driver": "Tom Anderson",
      "vehicle": "VAN-001",
      "items": 10,
      "value": 425.20,
      "rating": 0.0,
      "notes": "Customer not available",
    },
    {
      "id": "DEL-041",
      "date": "2024-01-03",
      "time": "14:00",
      "status": "delivered",
      "driver": "Sarah Brown",
      "vehicle": "TRK-002",
      "items": 15,
      "value": 567.95,
      "rating": 4.7,
      "notes": "Good delivery",
    },
  ];

  List<Map<String, dynamic>> communicationHistory = [
    {
      "type": "email",
      "date": "2024-01-13T17:00:00Z",
      "subject": "Delivery Confirmation - DEL-045",
      "from": "system",
      "status": "sent",
    },
    {
      "type": "sms",
      "date": "2024-01-13T14:15:00Z",
      "subject": "Driver en route - ETA 15 minutes",
      "from": "system",
      "status": "delivered",
    },
    {
      "type": "phone",
      "date": "2024-01-12T10:30:00Z",
      "subject": "Schedule confirmation call",
      "from": "Michael Roberts",
      "status": "completed",
    },
    {
      "type": "email",
      "date": "2024-01-10T18:30:00Z",
      "subject": "Delivery Feedback Request",
      "from": "system",
      "status": "opened",
    },
  ];

  Color _getCustomerTypeColor(String type) {
    switch (type) {
      case "business":
        return primaryColor;
      case "individual":
        return successColor;
      case "government":
        return warningColor;
      case "nonprofit":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledColor;
      case "suspended":
        return dangerColor;
      case "pending":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color _getDeliveryStatusColor(String status) {
    switch (status) {
      case "delivered":
        return successColor;
      case "failed":
        return dangerColor;
      case "in_transit":
        return primaryColor;
      case "scheduled":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  void _updateCustomerStatus(String newStatus) async {
    bool isConfirmed = await confirm("Update customer status to ${newStatus}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    customerData["status"] = newStatus;
    customerData["updated_at"] = DateTime.now().toIso8601String();

    loading = false;
    setState(() {});
    ss("Customer status updated successfully");
  }

  void _callCustomer() {
    ss("Calling ${customerData["phone"]}");
  }

  void _emailCustomer() {
    ss("Opening email to ${customerData["email"]}");
  }

  void _scheduleDelivery() {
    ss("Scheduling new delivery for ${customerData["name"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // navigateTo('dla_customer_edit_view')
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Customer Header
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${customerData["avatar"]}",
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
                                      "${customerData["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(customerData["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Text(
                                      "${customerData["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(customerData["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${customerData["id"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (customerData["company"] != null) ...[
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(Icons.business, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${customerData["company"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getCustomerTypeColor(customerData["type"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${customerData["type"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getCustomerTypeColor(customerData["type"]),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.star, size: 16, color: warningColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(customerData["rating"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quick Actions
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildActionCard(
                        "Call Customer",
                        Icons.phone,
                        primaryColor,
                        _callCustomer,
                      ),
                      _buildActionCard(
                        "Send Email",
                        Icons.email,
                        successColor,
                        _emailCustomer,
                      ),
                      _buildActionCard(
                        "Schedule Delivery",
                        Icons.local_shipping,
                        warningColor,
                        _scheduleDelivery,
                      ),
                      _buildActionCard(
                        "Update Status",
                        Icons.update,
                        infoColor,
                        () => _showStatusOptions(),
                      ),
                    ],
                  ),

                  // Statistics
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildStatCard(
                        "Total Deliveries",
                        "${customerData["total_deliveries"]}",
                        Icons.local_shipping,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Success Rate",
                        "${(((customerData["successful_deliveries"] as int) / (customerData["total_deliveries"] as int)) * 100).toInt()}%",
                        Icons.check_circle,
                        successColor,
                      ),
                      _buildStatCard(
                        "Total Spent",
                        "\$${((customerData["total_spent"] as double).toDouble()).currency}",
                        Icons.attach_money,
                        warningColor,
                      ),
                      _buildStatCard(
                        "Loyalty Points",
                        "${customerData["loyalty_points"]}",
                        Icons.star,
                        infoColor,
                      ),
                    ],
                  ),

                  // Contact Information
                  _buildInfoSection(
                    "Contact Information",
                    Icons.contact_phone,
                    [
                      _buildInfoRow("Email", "${customerData["email"]}"),
                      _buildInfoRow("Phone", "${customerData["phone"]}"),
                      _buildInfoRow("Contact Person", "${customerData["contact_person"]}"),
                      if (customerData["business_hours"] != null)
                        _buildInfoRow("Business Hours", "${customerData["business_hours"]}"),
                    ],
                  ),

                  // Address Information
                  _buildInfoSection(
                    "Address Information",
                    Icons.location_on,
                    [
                      _buildInfoRow("Delivery Address", "${customerData["address"]}"),
                      _buildInfoRow("Billing Address", "${customerData["billing_address"]}"),
                      _buildInfoRow("Preferred Time", "${customerData["preferred_time"]}"),
                    ],
                  ),

                  // Delivery Preferences
                  _buildInfoSection(
                    "Delivery Preferences",
                    Icons.settings,
                    [
                      _buildInfoRow("SMS Notifications", "${customerData["sms_notifications"] ? 'Enabled' : 'Disabled'}"),
                      _buildInfoRow("Email Notifications", "${customerData["email_notifications"] ? 'Enabled' : 'Disabled'}"),
                      _buildInfoRow("Require Signature", "${customerData["require_signature"] ? 'Yes' : 'No'}"),
                      _buildInfoRow("Allow Substitution", "${customerData["allow_substitution"] ? 'Yes' : 'No'}"),
                      _buildInfoRow("Delivery Instructions", "${customerData["delivery_instructions"]}"),
                      _buildInfoRow("Special Requirements", "${customerData["special_requirements"]}"),
                    ],
                  ),

                  // Business Information (if business customer)
                  if (customerData["type"] == "business")
                    _buildInfoSection(
                      "Business Information",
                      Icons.business,
                      [
                        _buildInfoRow("Payment Terms", "${customerData["payment_terms"]}"),
                        _buildInfoRow("Credit Limit", "\$${((customerData["credit_limit"] as double).toDouble()).currency}"),
                        _buildInfoRow("Account Manager", "${customerData["account_manager"]}"),
                        _buildInfoRow("Average Order Value", "\$${((customerData["average_order_value"] as double).toDouble()).currency}"),
                      ],
                    ),

                  // Recent Deliveries
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.history, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Recent Deliveries",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // navigateTo('delivery_history_view')
                                },
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...recentDeliveries.take(5).map((delivery) => _buildDeliveryCard(delivery)),
                      ],
                    ),
                  ),

                  // Communication History
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.chat, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Communication History",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...communicationHistory.map((comm) => _buildCommunicationCard(comm)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border(
            left: BorderSide(
              width: 4,
              color: color,
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, IconData icon, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spSm,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getDeliveryStatusColor(delivery["status"]),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${delivery["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${DateTime.parse(delivery["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${delivery["items"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${((delivery["value"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if ((delivery["rating"] as double) > 0) ...[
                      Icon(Icons.star, size: 12, color: warningColor),
                      SizedBox(width: spXs),
                      Text(
                        "${(delivery["rating"] as double).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
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

  Widget _buildCommunicationCard(Map<String, dynamic> comm) {
    IconData icon;
    Color iconColor;
    
    switch (comm["type"]) {
      case "email":
        icon = Icons.email;
        iconColor = primaryColor;
        break;
      case "sms":
        icon = Icons.sms;
        iconColor = successColor;
        break;
      case "phone":
        icon = Icons.phone;
        iconColor = warningColor;
        break;
      default:
        icon = Icons.chat;
        iconColor = infoColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${comm["subject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "From: ${comm["from"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${DateTime.parse(comm["date"]).dMMMy}",
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
        ],
      ),
    );
  }

  void _showStatusOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Update Customer Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ...[
                "active",
                "inactive",
                "suspended",
                "pending"
              ].map((status) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _getStatusColor(status),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Select",
                        size: bs.sm,
                        onPressed: () {
                          back();
                          _updateCustomerStatus(status);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
