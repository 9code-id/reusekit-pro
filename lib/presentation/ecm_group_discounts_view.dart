import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmGroupDiscountsView extends StatefulWidget {
  const EcmGroupDiscountsView({super.key});

  @override
  State<EcmGroupDiscountsView> createState() => _EcmGroupDiscountsViewState();
}

class _EcmGroupDiscountsViewState extends State<EcmGroupDiscountsView> {
  bool isLoading = false;
  String searchQuery = "";

  List<Map<String, dynamic>> groupDiscounts = [
    {
      "id": 1,
      "name": "Corporate Package",
      "description": "Special pricing for corporate teams and departments",
      "min_quantity": 10,
      "max_quantity": 50,
      "discount_type": "percentage",
      "discount_value": 15.0,
      "base_price": 150.0,
      "discounted_price": 127.5,
      "status": "active",
      "total_used": 3,
      "total_saved": 675.0,
      "conditions": [
        "Minimum 10 attendees from same company",
        "Corporate email required",
        "Payment within 30 days"
      ],
      "created_date": "2025-01-01",
      "category": "corporate"
    },
    {
      "id": 2,
      "name": "Student Groups",
      "description": "Educational institution group rates",
      "min_quantity": 5,
      "max_quantity": 25,
      "discount_type": "fixed",
      "discount_value": 25.0,
      "base_price": 100.0,
      "discounted_price": 75.0,
      "status": "active",
      "total_used": 7,
      "total_saved": 875.0,
      "conditions": [
        "Valid student IDs required",
        "Educational institution verification",
        "Supervisor contact required"
      ],
      "created_date": "2025-01-05",
      "category": "education"
    },
    {
      "id": 3,
      "name": "Family & Friends",
      "description": "Perfect for families and friend groups",
      "min_quantity": 4,
      "max_quantity": 12,
      "discount_type": "percentage",
      "discount_value": 10.0,
      "base_price": 120.0,
      "discounted_price": 108.0,
      "status": "active",
      "total_used": 12,
      "total_saved": 576.0,
      "conditions": [
        "All attendees register together",
        "Same contact information",
        "Non-transferable tickets"
      ],
      "created_date": "2025-01-10",
      "category": "personal"
    },
    {
      "id": 4,
      "name": "Bulk Registration",
      "description": "Large scale event registrations",
      "min_quantity": 25,
      "max_quantity": 100,
      "discount_type": "percentage",
      "discount_value": 20.0,
      "base_price": 200.0,
      "discounted_price": 160.0,
      "status": "active",
      "total_used": 2,
      "total_saved": 2000.0,
      "conditions": [
        "Minimum 25 attendees",
        "Single payment required",
        "30-day advance booking"
      ],
      "created_date": "2025-01-15",
      "category": "bulk"
    },
    {
      "id": 5,
      "name": "Non-Profit Organizations",
      "description": "Special rates for registered non-profits",
      "min_quantity": 3,
      "max_quantity": 20,
      "discount_type": "percentage",
      "discount_value": 25.0,
      "base_price": 150.0,
      "discounted_price": 112.5,
      "status": "draft",
      "total_used": 0,
      "total_saved": 0.0,
      "conditions": [
        "Valid non-profit registration",
        "Tax-exempt documentation",
        "Mission alignment verification"
      ],
      "created_date": "2025-01-20",
      "category": "nonprofit"
    }
  ];

  List<Map<String, dynamic>> groupRegistrations = [
    {
      "group_name": "Tech Solutions Inc.",
      "discount_applied": "Corporate Package",
      "attendees": 15,
      "original_amount": 2250.0,
      "discounted_amount": 1912.5,
      "savings": 337.5,
      "registration_date": "2025-01-25",
      "status": "confirmed",
      "contact_person": "John Smith",
      "email": "john.smith@techsolutions.com"
    },
    {
      "group_name": "State University Computer Science",
      "discount_applied": "Student Groups",
      "attendees": 8,
      "original_amount": 800.0,
      "discounted_amount": 600.0,
      "savings": 200.0,
      "registration_date": "2025-01-28",
      "status": "confirmed",
      "contact_person": "Dr. Sarah Johnson",
      "email": "s.johnson@stateuni.edu"
    },
    {
      "group_name": "Johnson Family Reunion",
      "discount_applied": "Family & Friends",
      "attendees": 6,
      "original_amount": 720.0,
      "discounted_amount": 648.0,
      "savings": 72.0,
      "registration_date": "2025-02-01",
      "status": "pending",
      "contact_person": "Mike Johnson",
      "email": "mike.johnson@gmail.com"
    }
  ];

  List<Map<String, dynamic>> get filteredDiscounts {
    if (searchQuery.isEmpty) return groupDiscounts;
    return groupDiscounts.where((discount) {
      return discount["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             discount["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             discount["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Widget _buildDiscountCard(Map<String, dynamic> discount) {
    Color statusColor = discount["status"] == "active" 
        ? successColor 
        : discount["status"] == "draft" 
            ? warningColor 
            : disabledBoldColor;
    
    Color categoryColor = _getCategoryColor(discount["category"]);
    String discountText = discount["discount_type"] == "percentage"
        ? "${discount["discount_value"]}% OFF"
        : "\$${((discount["discount_value"] as double)).currency} OFF";

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: categoryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    _getCategoryIcon(discount["category"]),
                    color: categoryColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${discount["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${discount["category"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: categoryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${discount["status"]}".toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "${discount["description"]}",
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
                color: successColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_offer, color: successColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          discountText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Group size: ${discount["min_quantity"]} - ${discount["max_quantity"]} people",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${((discount["discounted_price"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "\$${((discount["base_price"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "per person",
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
                      "${discount["total_used"]} groups",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "total used",
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
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.savings, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Total savings: \$${((discount["total_saved"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Requirements:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            ...(discount["conditions"] as List).map<Widget>((condition) {
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: disabledBoldColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$condition",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: spSm),
            Row(
              children: [
                Text(
                  "Created: ${DateTime.parse(discount["created_date"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () => _editDiscount(discount),
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.copy,
                  size: bs.sm,
                  onPressed: () => _duplicateDiscount(discount),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationCard(Map<String, dynamic> registration) {
    Color statusColor = registration["status"] == "confirmed" 
        ? successColor 
        : registration["status"] == "pending" 
            ? warningColor 
            : dangerColor;

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
                      "${registration["group_name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${registration["discount_applied"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${registration["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                child: Row(
                  children: [
                    Icon(Icons.people, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${registration["attendees"]} attendees",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                child: Row(
                  children: [
                    Icon(Icons.savings, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "\$${((registration["savings"] as double)).currency} saved",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
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
                      "Total Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${((registration["discounted_amount"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "\$${((registration["original_amount"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            decoration: TextDecoration.lineThrough,
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
                    "Contact",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${registration["contact_person"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Registered: ${DateTime.parse(registration["registration_date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.email, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${registration["email"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    int totalGroups = groupRegistrations.length;
    double totalSavings = groupRegistrations.fold(0.0, (sum, reg) => sum + (reg["savings"] as double));
    double totalRevenue = groupRegistrations.fold(0.0, (sum, reg) => sum + (reg["discounted_amount"] as double));
    int totalAttendees = groupRegistrations.fold(0, (sum, reg) => sum + (reg["attendees"] as int));

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
            "Group Discounts Summary",
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
                        Icon(Icons.groups, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Total Groups",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalGroups",
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
                        Icon(Icons.savings, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Total Savings",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(totalSavings).currency}",
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
                        Icon(Icons.people, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Attendees",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalAttendees",
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case "corporate":
        return primaryColor;
      case "education":
        return successColor;
      case "personal":
        return infoColor;
      case "bulk":
        return warningColor;
      case "nonprofit":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "corporate":
        return Icons.business;
      case "education":
        return Icons.school;
      case "personal":
        return Icons.people;
      case "bulk":
        return Icons.inventory;
      case "nonprofit":
        return Icons.volunteer_activism;
      default:
        return Icons.group;
    }
  }

  void _editDiscount(Map<String, dynamic> discount) {
    // Navigate to edit discount
  }

  void _duplicateDiscount(Map<String, dynamic> discount) {
    // Duplicate discount
  }

  void _createNewDiscount() {
    // Navigate to create new discount
  }

  void _filterDiscounts() {
    // Show filter options
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Discounts"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _createNewDiscount,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
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
                              hintText: "Search group discounts...",
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
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: _filterDiscounts,
                ),
              ],
            ),
            SizedBox(height: spSm),
            _buildSummaryCard(),
            SizedBox(height: spSm),
            Text(
              "Available Discounts (${filteredDiscounts.length})",
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
              ...filteredDiscounts.map((discount) => _buildDiscountCard(discount)).toList(),
            SizedBox(height: spLg),
            Text(
              "Recent Group Registrations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...groupRegistrations.map((registration) => _buildRegistrationCard(registration)).toList(),
          ],
        ),
      ),
    );
  }
}
