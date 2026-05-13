import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmPromoCodesView extends StatefulWidget {
  const EcmPromoCodesView({super.key});

  @override
  State<EcmPromoCodesView> createState() => _EcmPromoCodesViewState();
}

class _EcmPromoCodesViewState extends State<EcmPromoCodesView> {
  bool isLoading = false;
  int currentTab = 0;
  String searchQuery = "";

  List<Map<String, dynamic>> promoCodes = [
    {
      "id": 1,
      "code": "WELCOME2025",
      "name": "Welcome Bonus",
      "description": "New customer welcome discount",
      "discount_type": "percentage",
      "discount_value": 20.0,
      "min_order_amount": 100.0,
      "max_discount_amount": 50.0,
      "usage_limit": 100,
      "current_usage": 23,
      "valid_from": "2025-01-01",
      "valid_until": "2025-12-31",
      "status": "active",
      "code_type": "public",
      "created_by": "Admin",
      "applicable_tickets": ["General Admission", "VIP Package"],
      "user_restrictions": ["new_customers_only"],
      "total_revenue": 1150.0
    },
    {
      "id": 2,
      "code": "FLASH50",
      "name": "Flash Sale",
      "description": "Limited time flash sale offer",
      "discount_type": "fixed",
      "discount_value": 50.0,
      "min_order_amount": 200.0,
      "max_discount_amount": 50.0,
      "usage_limit": 50,
      "current_usage": 47,
      "valid_from": "2025-02-01",
      "valid_until": "2025-02-07",
      "status": "active",
      "code_type": "limited",
      "created_by": "Marketing Team",
      "applicable_tickets": ["All Tickets"],
      "user_restrictions": ["one_per_customer"],
      "total_revenue": 2350.0
    },
    {
      "id": 3,
      "code": "STUDENT15",
      "name": "Student Discount",
      "description": "Special discount for students",
      "discount_type": "percentage",
      "discount_value": 15.0,
      "min_order_amount": 50.0,
      "max_discount_amount": 30.0,
      "usage_limit": 200,
      "current_usage": 67,
      "valid_from": "2025-01-15",
      "valid_until": "2025-06-30",
      "status": "active",
      "code_type": "targeted",
      "created_by": "Education Team",
      "applicable_tickets": ["Student Ticket"],
      "user_restrictions": ["student_verification_required"],
      "total_revenue": 890.0
    },
    {
      "id": 4,
      "code": "EARLYBIRD",
      "name": "Early Bird Special",
      "description": "Early registration incentive",
      "discount_type": "percentage",
      "discount_value": 25.0,
      "min_order_amount": 150.0,
      "max_discount_amount": 75.0,
      "usage_limit": 75,
      "current_usage": 75,
      "valid_from": "2025-01-01",
      "valid_until": "2025-01-31",
      "status": "expired",
      "code_type": "limited",
      "created_by": "Sales Team",
      "applicable_tickets": ["General Admission", "VIP Package"],
      "user_restrictions": ["registration_before_jan_31"],
      "total_revenue": 5625.0
    },
    {
      "id": 5,
      "code": "VIP2025",
      "name": "VIP Exclusive",
      "description": "Exclusive offer for VIP members",
      "discount_type": "fixed",
      "discount_value": 100.0,
      "min_order_amount": 300.0,
      "max_discount_amount": 100.0,
      "usage_limit": 25,
      "current_usage": 8,
      "valid_from": "2025-01-01",
      "valid_until": "2025-03-31",
      "status": "active",
      "code_type": "exclusive",
      "created_by": "VIP Team",
      "applicable_tickets": ["VIP Package", "Premium Package"],
      "user_restrictions": ["vip_members_only"],
      "total_revenue": 2400.0
    },
    {
      "id": 6,
      "code": "SUMMER2025",
      "name": "Summer Campaign",
      "description": "Summer season promotional offer",
      "discount_type": "percentage",
      "discount_value": 30.0,
      "min_order_amount": 200.0,
      "max_discount_amount": 100.0,
      "usage_limit": 150,
      "current_usage": 0,
      "valid_from": "2025-06-01",
      "valid_until": "2025-08-31",
      "status": "scheduled",
      "code_type": "seasonal",
      "created_by": "Marketing Team",
      "applicable_tickets": ["All Tickets"],
      "user_restrictions": ["none"],
      "total_revenue": 0.0
    }
  ];

  List<Map<String, dynamic>> promoUsage = [
    {
      "code": "WELCOME2025",
      "user_email": "john.doe@example.com",
      "user_name": "John Doe",
      "order_amount": 150.0,
      "discount_applied": 30.0,
      "final_amount": 120.0,
      "usage_date": "2025-01-28T10:30:00Z",
      "ticket_type": "General Admission",
      "quantity": 1
    },
    {
      "code": "FLASH50",
      "user_email": "sarah.smith@example.com",
      "user_name": "Sarah Smith",
      "order_amount": 250.0,
      "discount_applied": 50.0,
      "final_amount": 200.0,
      "usage_date": "2025-02-02T14:15:00Z",
      "ticket_type": "VIP Package",
      "quantity": 1
    },
    {
      "code": "STUDENT15",
      "user_email": "mike.wilson@university.edu",
      "user_name": "Mike Wilson",
      "order_amount": 75.0,
      "discount_applied": 11.25,
      "final_amount": 63.75,
      "usage_date": "2025-01-30T09:45:00Z",
      "ticket_type": "Student Ticket",
      "quantity": 1
    }
  ];

  List<Map<String, dynamic>> get filteredPromoCodes {
    if (searchQuery.isEmpty) return promoCodes;
    return promoCodes.where((promo) {
      return promo["code"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             promo["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             promo["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Widget _buildPromoCodeCard(Map<String, dynamic> promo) {
    Color statusColor = promo["status"] == "active" 
        ? successColor 
        : promo["status"] == "expired" 
            ? dangerColor 
            : promo["status"] == "scheduled"
                ? infoColor
                : warningColor;
    
    Color typeColor = _getTypeColor(promo["code_type"]);
    double usagePercentage = (promo["current_usage"] as int) / (promo["usage_limit"] as int);
    bool isFullyUsed = usagePercentage >= 1.0;
    DateTime validFrom = DateTime.parse(promo["valid_from"]);
    DateTime validUntil = DateTime.parse(promo["valid_until"]);
    int daysLeft = validUntil.difference(DateTime.now()).inDays;

    String discountText = promo["discount_type"] == "percentage"
        ? "${promo["discount_value"]}% OFF"
        : "\$${((promo["discount_value"] as double)).currency} OFF";

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: statusColor.withAlpha(77),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(26),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: statusColor, width: 2),
                  ),
                  child: Text(
                    "${promo["code"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${promo["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      Text(
                        "${promo["code_type"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: typeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${promo["status"]}".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${promo["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_offer, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              discountText,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if (promo["max_discount_amount"] != null)
                              Text(
                                "Max discount: \$${((promo["max_discount_amount"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: primaryColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (daysLeft > 0 && promo["status"] == "active")
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$daysLeft days left",
                            style: TextStyle(
                              color: warningColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.trending_up, color: successColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "Usage",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${promo["current_usage"]} / ${promo["usage_limit"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.attach_money, color: warningColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "Revenue",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((promo["total_revenue"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: usagePercentage,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isFullyUsed ? dangerColor : usagePercentage > 0.8 ? warningColor : successColor
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${(usagePercentage * 100).toInt()}% of usage limit reached",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.shopping_cart, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Min order: \$${((promo["min_order_amount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${validFrom.dMMMy} - ${validUntil.dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Applicable Tickets:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (promo["applicable_tickets"] as List).map<Widget>((ticket) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$ticket",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Created by: ${promo["created_by"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Edit",
                      size: bs.sm,
                      onPressed: () => _editPromoCode(promo),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: promo["status"] == "active" ? Icons.pause : Icons.play_arrow,
                      size: bs.sm,
                      onPressed: () => _togglePromoStatus(promo),
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

  Widget _buildUsageCard(Map<String, dynamic> usage) {
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${usage["code"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${DateTime.parse(usage["usage_date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${usage["user_name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${usage["user_email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${usage["ticket_type"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "Qty: ${usage["quantity"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${((usage["order_amount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "\$${((usage["discount_applied"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Final Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "\$${((usage["final_amount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    int totalCodes = promoCodes.length;
    int activeCodes = promoCodes.where((promo) => promo["status"] == "active").length;
    double totalRevenue = promoCodes.fold(0.0, (sum, promo) => sum + (promo["total_revenue"] as double));
    int totalUsage = promoCodes.fold(0, (sum, promo) => sum + (promo["current_usage"] as int));

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
          Text(
            "Promo Codes Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.code, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Total Codes",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalCodes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Active Codes",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$activeCodes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(totalRevenue).currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.redeem, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Total Usage",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalUsage",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCodesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: spSm),
                      Icon(Icons.search, color: disabledBoldColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search promo codes...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: disabledBoldColor),
                          ),
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: _createNewPromoCode,
              ),
            ],
          ),
          SizedBox(height: spSm),
          _buildSummaryCard(),
          SizedBox(height: spSm),
          Text(
            "Promo Codes (${filteredPromoCodes.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else
            ...filteredPromoCodes.map((promo) => _buildPromoCodeCard(promo)).toList(),
        ],
      ),
    );
  }

  Widget _buildUsageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Usage History",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Track how customers are using your promo codes",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ...promoUsage.map((usage) => _buildUsageCard(usage)).toList(),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "public":
        return primaryColor;
      case "limited":
        return warningColor;
      case "targeted":
        return infoColor;
      case "exclusive":
        return secondaryColor;
      case "seasonal":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _editPromoCode(Map<String, dynamic> promo) {
    // Navigate to edit promo code
  }

  void _togglePromoStatus(Map<String, dynamic> promo) {
    // Toggle promo code status
  }

  void _createNewPromoCode() {
    // Navigate to create new promo code
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Promo Codes",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Codes", icon: Icon(Icons.code)),
        Tab(text: "Usage", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildCodesTab(),
        _buildUsageTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
