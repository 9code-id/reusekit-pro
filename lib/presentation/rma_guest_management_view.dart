import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaGuestManagementView extends StatefulWidget {
  const RmaGuestManagementView({super.key});

  @override
  State<RmaGuestManagementView> createState() => _RmaGuestManagementViewState();
}

class _RmaGuestManagementViewState extends State<RmaGuestManagementView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String sortBy = "name";
  bool showDetails = false;
  
  List<Map<String, dynamic>> guests = [
    {
      "id": "GUEST-001",
      "name": "Alice Cooper",
      "email": "alice.cooper@email.com",
      "phone": "+1-555-0123",
      "status": "vip",
      "totalVisits": 15,
      "lastVisit": "2024-03-14",
      "averageSpending": 85.50,
      "totalSpending": 1282.50,
      "preferredTable": "T-12",
      "dietaryRestrictions": ["Vegetarian"],
      "allergies": ["Nuts"],
      "birthDate": "1985-06-15",
      "anniversary": "2020-09-22",
      "notes": "Prefers quiet corner tables",
      "rating": 4.8,
      "loyaltyPoints": 1250,
      "memberSince": "2023-01-15",
    },
    {
      "id": "GUEST-002",
      "name": "Bob Johnson",
      "email": "bob.johnson@email.com",
      "phone": "+1-555-0456",
      "status": "regular",
      "totalVisits": 8,
      "lastVisit": "2024-03-12",
      "averageSpending": 45.75,
      "totalSpending": 366.00,
      "preferredTable": "T-05",
      "dietaryRestrictions": [],
      "allergies": [],
      "birthDate": "1990-11-08",
      "anniversary": null,
      "notes": "Always orders the ribeye steak",
      "rating": 4.5,
      "loyaltyPoints": 750,
      "memberSince": "2023-08-20",
    },
    {
      "id": "GUEST-003",
      "name": "Carol White",
      "email": "carol.white@email.com",
      "phone": "+1-555-0789",
      "status": "new",
      "totalVisits": 2,
      "lastVisit": "2024-03-10",
      "averageSpending": 32.25,
      "totalSpending": 64.50,
      "preferredTable": null,
      "dietaryRestrictions": ["Gluten-Free"],
      "allergies": ["Shellfish"],
      "birthDate": "1988-03-22",
      "anniversary": "2015-07-10",
      "notes": "Very specific about gluten-free options",
      "rating": 4.2,
      "loyaltyPoints": 125,
      "memberSince": "2024-02-28",
    },
    {
      "id": "GUEST-004",
      "name": "David Brown",
      "email": "david.brown@email.com",
      "phone": "+1-555-0321",
      "status": "vip",
      "totalVisits": 22,
      "lastVisit": "2024-03-15",
      "averageSpending": 120.00,
      "totalSpending": 2640.00,
      "preferredTable": "T-18",
      "dietaryRestrictions": ["Keto"],
      "allergies": [],
      "birthDate": "1975-12-05",
      "anniversary": "2010-04-18",
      "notes": "Business dinners, prefers wine pairings",
      "rating": 5.0,
      "loyaltyPoints": 2100,
      "memberSince": "2022-11-10",
    },
    {
      "id": "GUEST-005",
      "name": "Eva Green",
      "email": "eva.green@email.com",
      "phone": "+1-555-0654",
      "status": "regular",
      "totalVisits": 12,
      "lastVisit": "2024-03-13",
      "averageSpending": 67.25,
      "totalSpending": 807.00,
      "preferredTable": "T-08",
      "dietaryRestrictions": ["Pescatarian"],
      "allergies": ["Dairy"],
      "birthDate": "1992-09-30",
      "anniversary": null,
      "notes": "Loves seafood dishes, dairy-free desserts",
      "rating": 4.6,
      "loyaltyPoints": 980,
      "memberSince": "2023-05-12",
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Guests", "value": "all"},
    {"label": "VIP", "value": "vip"},
    {"label": "Regular", "value": "regular"},
    {"label": "New", "value": "new"},
    {"label": "Inactive", "value": "inactive"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "name"},
    {"label": "Last Visit", "value": "lastVisit"},
    {"label": "Total Visits", "value": "visits"},
    {"label": "Total Spending", "value": "spending"},
    {"label": "Loyalty Points", "value": "points"},
  ];

  Widget _buildGuestStats() {
    final totalGuests = guests.length;
    final vipGuests = guests.where((g) => g["status"] == "vip").length;
    final totalSpending = guests.map((g) => g["totalSpending"] as double).reduce((a, b) => a + b);
    final avgSpending = totalSpending / totalGuests;
    
    return Container(
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
            "Guest Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Guests",
                "$totalGuests",
                Icons.people,
                primaryColor,
              ),
              _buildStatCard(
                "VIP Guests",
                "$vipGuests",
                Icons.star,
                warningColor,
              ),
              _buildStatCard(
                "Total Revenue",
                "\$${totalSpending.currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildStatCard(
                "Avg. Spending",
                "\$${avgSpending.currency}",
                Icons.trending_up,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                child: QTextField(
                  label: "Search Guests",
                  value: searchQuery,
                  hint: "Name, email, or phone",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
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
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Details",
                      "value": true,
                      "checked": showDetails,
                    }
                  ],
                  value: [
                    if (showDetails)
                      {
                        "label": "Show Details",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showDetails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuestCard(Map<String, dynamic> guest) {
    final statusColor = guest["status"] == "vip" ? warningColor :
                       guest["status"] == "regular" ? successColor :
                       guest["status"] == "new" ? infoColor :
                       disabledBoldColor;

    final statusIcon = guest["status"] == "vip" ? Icons.star :
                      guest["status"] == "regular" ? Icons.verified :
                      guest["status"] == "new" ? Icons.new_label :
                      Icons.person;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
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
                    Row(
                      children: [
                        Text(
                          "${guest["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(statusIcon, color: statusColor, size: 12),
                              SizedBox(width: spXs),
                              Text(
                                "${guest["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.email, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${guest["email"]}",
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
                        Icon(Icons.phone, color: successColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${guest["phone"]}",
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
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${(guest["rating"] as double).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${guest["loyaltyPoints"]} pts",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildGuestMetric("Visits", "${guest["totalVisits"]}", Icons.restaurant),
              _buildGuestMetric("Avg. Spending", "\$${((guest["averageSpending"] as double)).currency}", Icons.attach_money),
              _buildGuestMetric("Total Spent", "\$${((guest["totalSpending"] as double)).currency}", Icons.account_balance_wallet),
              _buildGuestMetric("Last Visit", "${guest["lastVisit"]}", Icons.access_time),
            ],
          ),
          if (showDetails) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Guest Details:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  if (guest["preferredTable"] != null) ...[
                    Row(
                      children: [
                        Icon(Icons.table_restaurant, color: infoColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Preferred Table: ${guest["preferredTable"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                  ],
                  Row(
                    children: [
                      Icon(Icons.cake, color: warningColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "Birthday: ${guest["birthDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  if (guest["anniversary"] != null) ...[
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: dangerColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Anniversary: ${guest["anniversary"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if ((guest["dietaryRestrictions"] as List).isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      children: (guest["dietaryRestrictions"] as List).map((restriction) => 
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$restriction",
                            style: TextStyle(
                              fontSize: 10,
                              color: warningColor,
                            ),
                          ),
                        ),
                      ).toList(),
                    ),
                  ],
                  if ((guest["allergies"] as List).isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      children: (guest["allergies"] as List).map((allergy) => 
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "⚠️ $allergy",
                            style: TextStyle(
                              fontSize: 10,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ).toList(),
                    ),
                  ],
                  if (guest["notes"] != null && guest["notes"] != "") ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.note, color: infoColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${guest["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Profile",
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('EditGuestProfile')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.restaurant,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CreateReservation')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CallGuest')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.history,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('GuestHistory')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuestMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredGuests {
    List<Map<String, dynamic>> filtered = List.from(guests);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((guest) {
        final name = "${guest["name"]}".toLowerCase();
        final email = "${guest["email"]}".toLowerCase();
        final phone = "${guest["phone"]}".toLowerCase();
        final query = searchQuery.toLowerCase();
        return name.contains(query) || email.contains(query) || phone.contains(query);
      }).toList();
    }
    
    // Apply status filter
    if (selectedStatus != "all") {
      filtered = filtered.where((guest) => guest["status"] == selectedStatus).toList();
    }
    
    // Apply sorting
    switch (sortBy) {
      case "name":
        filtered.sort((a, b) => a["name"].compareTo(b["name"]));
        break;
      case "lastVisit":
        filtered.sort((a, b) => b["lastVisit"].compareTo(a["lastVisit"]));
        break;
      case "visits":
        filtered.sort((a, b) => (b["totalVisits"] as int).compareTo(a["totalVisits"] as int));
        break;
      case "spending":
        filtered.sort((a, b) => (b["totalSpending"] as double).compareTo(a["totalSpending"] as double));
        break;
      case "points":
        filtered.sort((a, b) => (b["loyaltyPoints"] as int).compareTo(a["loyaltyPoints"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              //navigateTo('AddNewGuest')
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('GuestAnalytics')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildGuestStats(),
            _buildFilters(),
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
                    children: [
                      Text(
                        "Guests (${filteredGuests.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Guest",
                        icon: Icons.person_add,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('AddNewGuest')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredGuests.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No guests found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredGuests.map((guest) => _buildGuestCard(guest)).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
