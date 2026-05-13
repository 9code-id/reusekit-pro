import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaCustomerDatabaseView extends StatefulWidget {
  const FmaCustomerDatabaseView({super.key});

  @override
  State<FmaCustomerDatabaseView> createState() => _FmaCustomerDatabaseViewState();
}

class _FmaCustomerDatabaseViewState extends State<FmaCustomerDatabaseView> {
  String searchQuery = "";
  String selectedSegment = "All";
  String sortBy = "Name";
  bool isAscending = true;
  bool isAddingCustomer = false;
  
  // Add Customer Form
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  DateTime birthDate = DateTime.now().subtract(Duration(days: 365 * 25));
  String preferredCommunication = "Email";
  String dietaryRestrictions = "";
  String notes = "";
  
  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST001",
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 234-567-8901",
      "birthDate": "1985-06-15",
      "joinDate": "2024-01-15",
      "totalOrders": 45,
      "totalSpent": 1250.75,
      "lastOrderDate": "2024-12-18",
      "averageOrderValue": 27.79,
      "favoriteItems": ["Beef Burger Deluxe", "French Fries"],
      "preferredCommunication": "Email",
      "dietaryRestrictions": "",
      "notes": "VIP customer, prefers booth seating",
      "segment": "VIP",
      "loyaltyPoints": 2450,
      "orderFrequency": "Weekly",
    },
    {
      "id": "CUST002",
      "name": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "phone": "+1 234-567-8902",
      "birthDate": "1990-03-22",
      "joinDate": "2024-03-10",
      "totalOrders": 28,
      "totalSpent": 895.50,
      "lastOrderDate": "2024-12-17",
      "averageOrderValue": 31.98,
      "favoriteItems": ["Margherita Pizza", "Caesar Salad"],
      "preferredCommunication": "SMS",
      "dietaryRestrictions": "Vegetarian",
      "notes": "Always orders online, prefers pickup",
      "segment": "Regular",
      "loyaltyPoints": 1780,
      "orderFrequency": "Bi-weekly",
    },
    {
      "id": "CUST003",
      "name": "Mike Wilson",
      "email": "mike.wilson@email.com",
      "phone": "+1 234-567-8903",
      "birthDate": "1982-11-08",
      "joinDate": "2024-02-20",
      "totalOrders": 62,
      "totalSpent": 2150.25,
      "lastOrderDate": "2024-12-19",
      "averageOrderValue": 34.68,
      "favoriteItems": ["Grilled Chicken Salad", "Fresh Orange Juice"],
      "preferredCommunication": "Phone",
      "dietaryRestrictions": "Gluten-free",
      "notes": "Health conscious, often asks about ingredients",
      "segment": "VIP",
      "loyaltyPoints": 4200,
      "orderFrequency": "Weekly",
    },
    {
      "id": "CUST004",
      "name": "Emily Davis",
      "email": "emily.davis@email.com",
      "phone": "+1 234-567-8904",
      "birthDate": "1995-08-14",
      "joinDate": "2024-11-05",
      "totalOrders": 8,
      "totalSpent": 185.40,
      "lastOrderDate": "2024-12-15",
      "averageOrderValue": 23.18,
      "favoriteItems": ["Chocolate Cake", "Iced Coffee"],
      "preferredCommunication": "Email",
      "dietaryRestrictions": "",
      "notes": "New customer, college student discount applied",
      "segment": "New",
      "loyaltyPoints": 380,
      "orderFrequency": "Monthly",
    },
    {
      "id": "CUST005",
      "name": "Robert Brown",
      "email": "r.brown@email.com",
      "phone": "+1 234-567-8905",
      "birthDate": "1975-12-03",
      "joinDate": "2023-08-12",
      "totalOrders": 120,
      "totalSpent": 3850.90,
      "lastOrderDate": "2024-12-16",
      "averageOrderValue": 32.09,
      "favoriteItems": ["Beef Steak", "Red Wine", "Cheesecake"],
      "preferredCommunication": "Email",
      "dietaryRestrictions": "",
      "notes": "Corporate account, often orders for office meetings",
      "segment": "VIP",
      "loyaltyPoints": 7800,
      "orderFrequency": "Daily",
    },
  ];

  List<Map<String, dynamic>> segmentItems = [
    {"label": "All Customers", "value": "All"},
    {"label": "VIP", "value": "VIP"},
    {"label": "Regular", "value": "Regular"},
    {"label": "New", "value": "New"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Name", "value": "Name"},
    {"label": "Total Spent", "value": "Total Spent"},
    {"label": "Total Orders", "value": "Total Orders"},
    {"label": "Last Order", "value": "Last Order"},
    {"label": "Join Date", "value": "Join Date"},
  ];

  List<Map<String, dynamic>> communicationItems = [
    {"label": "Email", "value": "Email"},
    {"label": "SMS", "value": "SMS"},
    {"label": "Phone", "value": "Phone"},
    {"label": "App Notification", "value": "App Notification"},
  ];

  List<Map<String, dynamic>> get filteredAndSortedCustomers {
    var filtered = customers.where((customer) {
      bool matchesSearch = customer["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          customer["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          customer["phone"].toString().contains(searchQuery);
      
      bool matchesSegment = selectedSegment == "All" || customer["segment"] == selectedSegment;
      
      return matchesSearch && matchesSegment;
    }).toList();

    filtered.sort((a, b) {
      dynamic aValue, bValue;
      
      switch (sortBy) {
        case "Name":
          aValue = a["name"];
          bValue = b["name"];
          break;
        case "Total Spent":
          aValue = a["totalSpent"];
          bValue = b["totalSpent"];
          break;
        case "Total Orders":
          aValue = a["totalOrders"];
          bValue = b["totalOrders"];
          break;
        case "Last Order":
          aValue = DateTime.parse(a["lastOrderDate"]);
          bValue = DateTime.parse(b["lastOrderDate"]);
          break;
        case "Join Date":
          aValue = DateTime.parse(a["joinDate"]);
          bValue = DateTime.parse(b["joinDate"]);
          break;
        default:
          aValue = a["name"];
          bValue = b["name"];
      }

      int comparison = 0;
      if (aValue is String && bValue is String) {
        comparison = aValue.compareTo(bValue);
      } else if (aValue is num && bValue is num) {
        comparison = aValue.compareTo(bValue);
      } else if (aValue is DateTime && bValue is DateTime) {
        comparison = aValue.compareTo(bValue);
      }

      return isAscending ? comparison : -comparison;
    });

    return filtered;
  }

  Color getSegmentColor(String segment) {
    switch (segment) {
      case "VIP": return Colors.purple;
      case "Regular": return primaryColor;
      case "New": return successColor;
      case "Inactive": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  String getOrderFrequencyIcon(String frequency) {
    switch (frequency) {
      case "Daily": return "🔥";
      case "Weekly": return "⭐";
      case "Bi-weekly": return "📅";
      case "Monthly": return "📝";
      default: return "👤";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Database"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              isAddingCustomer = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
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
                  QTextField(
                    label: "Search Customers",
                    value: searchQuery,
                    hint: "Search by name, email, or phone",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Segment",
                          items: segmentItems,
                          value: selectedSegment,
                          onChanged: (value, label) {
                            selectedSegment = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortItems,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isAscending = !isAscending;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Add Customer Form
            if (isAddingCustomer)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_add, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Add New Customer",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            isAddingCustomer = false;
                            _resetForm();
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: disabledBoldColor, size: 20),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Customer Name",
                            value: customerName,
                            validator: Validator.required,
                            onChanged: (value) {
                              customerName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Email Address",
                            value: customerEmail,
                            hint: "customer@email.com",
                            validator: Validator.email,
                            onChanged: (value) {
                              customerEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: customerPhone,
                            hint: "+1 234-567-8900",
                            validator: Validator.required,
                            onChanged: (value) {
                              customerPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDatePicker(
                            label: "Birth Date",
                            value: birthDate,
                            onChanged: (value) {
                              birthDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Preferred Communication",
                      items: communicationItems,
                      value: preferredCommunication,
                      onChanged: (value, label) {
                        preferredCommunication = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Dietary Restrictions",
                      value: dietaryRestrictions,
                      hint: "e.g., Vegetarian, Gluten-free, None",
                      onChanged: (value) {
                        dietaryRestrictions = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Notes",
                      value: notes,
                      hint: "Any additional information about the customer",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Add Customer",
                            onPressed: () {
                              if (customerName.isNotEmpty && customerEmail.isNotEmpty && customerPhone.isNotEmpty) {
                                customers.add({
                                  "id": "CUST${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
                                  "name": customerName,
                                  "email": customerEmail,
                                  "phone": customerPhone,
                                  "birthDate": birthDate.toIso8601String().split('T')[0],
                                  "joinDate": DateTime.now().toIso8601String().split('T')[0],
                                  "totalOrders": 0,
                                  "totalSpent": 0.0,
                                  "lastOrderDate": "",
                                  "averageOrderValue": 0.0,
                                  "favoriteItems": [],
                                  "preferredCommunication": preferredCommunication,
                                  "dietaryRestrictions": dietaryRestrictions,
                                  "notes": notes,
                                  "segment": "New",
                                  "loyaltyPoints": 0,
                                  "orderFrequency": "Never",
                                });
                                isAddingCustomer = false;
                                _resetForm();
                                ss("Customer added successfully");
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        QButton(
                          label: "Cancel",
                          color: disabledBoldColor,
                          size: bs.sm,
                          onPressed: () {
                            isAddingCustomer = false;
                            _resetForm();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Customer Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Customer Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${customers.length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Customers",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.purple.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${customers.where((c) => c["segment"] == "VIP").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "VIP Customers",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${(customers.fold(0.0, (sum, c) => sum + (c["totalSpent"] as double)) / customers.length).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Avg Lifetime Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Customer List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Customers (${filteredAndSortedCustomers.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...filteredAndSortedCustomers.map((customer) {
                    String segment = customer["segment"];
                    Color segmentColor = getSegmentColor(segment);
                    String frequencyIcon = getOrderFrequencyIcon(customer["orderFrequency"]);
                    List<dynamic> favoriteItems = customer["favoriteItems"] as List<dynamic>;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: segmentColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: segmentColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusMd),
                                ),
                                child: Center(
                                  child: Text(
                                    customer["name"].toString().substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: segmentColor,
                                    ),
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
                                        Text(
                                          "${customer["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          frequencyIcon,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: segmentColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            segment,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: segmentColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${customer["email"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${customer["phone"]}",
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
                                    "\$${(customer["totalSpent"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "${customer["totalOrders"]} orders",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Avg: \$${(customer["averageOrderValue"] as double).toStringAsFixed(2)}",
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
                          
                          // Customer Details
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.cake, size: 12, color: warningColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "Born: ${DateTime.parse(customer["birthDate"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.calendar_today, size: 12, color: infoColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "Joined: ${DateTime.parse(customer["joinDate"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    if (customer["lastOrderDate"].toString().isNotEmpty) ...[
                                      Icon(Icons.shopping_bag, size: 12, color: successColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "Last: ${DateTime.parse(customer["lastOrderDate"]).dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                if (favoriteItems.isNotEmpty)
                                  Row(
                                    children: [
                                      Icon(Icons.favorite, size: 12, color: dangerColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "Favorites: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          favoriteItems.join(", "),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: dangerColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (customer["dietaryRestrictions"].toString().isNotEmpty)
                                  Row(
                                    children: [
                                      Icon(Icons.restaurant, size: 12, color: warningColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "Dietary: ${customer["dietaryRestrictions"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (customer["notes"].toString().isNotEmpty)
                                  Row(
                                    children: [
                                      Icon(Icons.note, size: 12, color: infoColor),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${customer["notes"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    Icon(Icons.star, size: 12, color: Colors.amber),
                                    SizedBox(width: 4),
                                    Text(
                                      "${customer["loyaltyPoints"]} points",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.amber[800],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.message, size: 12, color: primaryColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${customer["preferredCommunication"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Text(
                                "ID: ${customer["id"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Row(
                                spacing: spXs,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // navigateTo(FmaCustomerProfileView(customerId: customer["id"]));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.visibility,
                                        color: primaryColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ss("Calling ${customer["name"]}...");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.call,
                                        color: successColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ss("Sending message to ${customer["name"]}...");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.message,
                                        color: infoColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // navigateTo(FmaCustomerEditView(customerId: customer["id"]));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: warningColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }

  void _resetForm() {
    customerName = "";
    customerEmail = "";
    customerPhone = "";
    birthDate = DateTime.now().subtract(Duration(days: 365 * 25));
    preferredCommunication = "Email";
    dietaryRestrictions = "";
    notes = "";
  }
}
