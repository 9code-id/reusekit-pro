import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsGuestManagementView extends StatefulWidget {
  const RfsGuestManagementView({super.key});

  @override
  State<RfsGuestManagementView> createState() => _RfsGuestManagementViewState();
}

class _RfsGuestManagementViewState extends State<RfsGuestManagementView> {
  String searchQuery = "";
  String selectedFilter = "All";
  String sortBy = "Name";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Guests", "value": "All"},
    {"label": "VIP Members", "value": "VIP"},
    {"label": "Regular Customers", "value": "Regular"},
    {"label": "First Time", "value": "New"},
    {"label": "Frequent Diners", "value": "Frequent"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "Name"},
    {"label": "Last Visit", "value": "LastVisit"},
    {"label": "Visit Count", "value": "VisitCount"},
    {"label": "Total Spent", "value": "TotalSpent"},
  ];

  List<Map<String, dynamic>> guests = [
    {
      "id": "G001",
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 234-567-8901",
      "type": "VIP",
      "visitCount": 45,
      "totalSpent": 2850.75,
      "lastVisit": "2025-06-18",
      "favoriteTable": "Window Table",
      "dietaryRestrictions": "No seafood",
      "specialOccasions": ["Birthday: Dec 15"],
      "notes": "Prefers quiet seating, regular wine selection",
      "loyaltyPoints": 2850,
      "memberSince": "2023-01-15",
    },
    {
      "id": "G002",
      "name": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "phone": "+1 234-567-8902",
      "type": "Regular",
      "visitCount": 18,
      "totalSpent": 950.25,
      "lastVisit": "2025-06-15",
      "favoriteTable": "Booth",
      "dietaryRestrictions": "Vegetarian",
      "specialOccasions": ["Anniversary: Aug 20"],
      "notes": "Always orders the vegetarian pasta",
      "loyaltyPoints": 950,
      "memberSince": "2024-03-10",
    },
    {
      "id": "G003",
      "name": "Michael Davis",
      "email": "m.davis@email.com",
      "phone": "+1 234-567-8903",
      "type": "Frequent",
      "visitCount": 32,
      "totalSpent": 1750.50,
      "lastVisit": "2025-06-19",
      "favoriteTable": "Bar Counter",
      "dietaryRestrictions": null,
      "specialOccasions": [],
      "notes": "Business lunches, usually with 3-4 colleagues",
      "loyaltyPoints": 1750,
      "memberSince": "2023-08-22",
    },
    {
      "id": "G004",
      "name": "Emily Brown",
      "email": "emily.brown@email.com",
      "phone": "+1 234-567-8904",
      "type": "New",
      "visitCount": 2,
      "totalSpent": 125.80,
      "lastVisit": "2025-06-17",
      "favoriteTable": null,
      "dietaryRestrictions": "Gluten-free",
      "specialOccasions": [],
      "notes": "First-time visitor, very impressed with service",
      "loyaltyPoints": 125,
      "memberSince": "2025-06-10",
    },
    {
      "id": "G005",
      "name": "David Wilson",
      "email": "david.w@email.com",
      "phone": "+1 234-567-8905",
      "type": "VIP",
      "visitCount": 67,
      "totalSpent": 4250.25,
      "lastVisit": "2025-06-16",
      "favoriteTable": "Private Room",
      "dietaryRestrictions": "No nuts",
      "specialOccasions": ["Birthday: Mar 8", "Wedding Anniversary: Sep 12"],
      "notes": "Corporate events, wine enthusiast, prefers French cuisine",
      "loyaltyPoints": 4250,
      "memberSince": "2022-05-18",
    },
    {
      "id": "G006",
      "name": "Lisa Anderson",
      "email": "lisa.a@email.com",
      "phone": "+1 234-567-8906",
      "type": "Regular",
      "visitCount": 23,
      "totalSpent": 1180.75,
      "lastVisit": "2025-06-14",
      "favoriteTable": "Outdoor Terrace",
      "dietaryRestrictions": "Dairy-free",
      "specialOccasions": ["Birthday: Nov 25"],
      "notes": "Weekend brunch regular, loves outdoor seating",
      "loyaltyPoints": 1180,
      "memberSince": "2023-11-05",
    },
  ];

  List<Map<String, dynamic>> get filteredGuests {
    var filtered = guests.where((guest) {
      bool matchesSearch = searchQuery.isEmpty ||
          guest["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          guest["email"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          guest["phone"].contains(searchQuery);
      
      bool matchesFilter = selectedFilter == "All" || guest["type"] == selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();

    // Sort the filtered list
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Name":
          return a["name"].compareTo(b["name"]);
        case "LastVisit":
          return DateTime.parse(b["lastVisit"]).compareTo(DateTime.parse(a["lastVisit"]));
        case "VisitCount":
          return (b["visitCount"] as int).compareTo(a["visitCount"] as int);
        case "TotalSpent":
          return (b["totalSpent"] as double).compareTo(a["totalSpent"] as double);
        default:
          return 0;
      }
    });

    return filtered;
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "VIP":
        return Color(0xFFFFD700);
      case "Frequent":
        return primaryColor;
      case "Regular":
        return successColor;
      case "New":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "VIP":
        return Icons.star;
      case "Frequent":
        return Icons.favorite;
      case "Regular":
        return Icons.person;
      case "New":
        return Icons.new_label;
      default:
        return Icons.help;
    }
  }

  void _viewGuestProfile(Map<String, dynamic> guest) {
    si("Viewing profile for ${guest["name"]}");
  }

  void _editGuestInfo(Map<String, dynamic> guest) {
    si("Editing information for ${guest["name"]}");
  }

  void _addGuestNote(Map<String, dynamic> guest) async {
    si("Adding note for ${guest["name"]}");
  }

  void _createReservation(Map<String, dynamic> guest) {
    si("Creating reservation for ${guest["name"]}");
  }

  void _viewHistory(Map<String, dynamic> guest) {
    si("Viewing visit history for ${guest["name"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Management"),
        actions: [
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {
              si("Adding new guest");
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
            // Search Bar
            QTextField(
              label: "Search Guests",
              value: searchQuery,
              hint: "Search by name, email, or phone...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters and Sort
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
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

            // Guest Stats Overview
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Guests", "${guests.length}", Icons.people, primaryColor),
                _buildStatCard("VIP Members", "${guests.where((g) => g["type"] == "VIP").length}", Icons.star, Color(0xFFFFD700)),
                _buildStatCard("New This Month", "${guests.where((g) => g["type"] == "New").length}", Icons.new_label, infoColor),
                _buildStatCard("Frequent Diners", "${guests.where((g) => g["type"] == "Frequent").length}", Icons.favorite, successColor),
              ],
            ),

            // Guests List
            Row(
              children: [
                Text(
                  "Guests (${filteredGuests.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                if (searchQuery.isNotEmpty || selectedFilter != "All")
                  QButton(
                    icon: Icons.clear,
                    size: bs.sm,
                    onPressed: () {
                      searchQuery = "";
                      selectedFilter = "All";
                      setState(() {});
                    },
                  ),
              ],
            ),

            Column(
              spacing: spSm,
              children: filteredGuests.map((guest) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getTypeColor(guest["type"]),
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      // Guest Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getTypeColor(guest["type"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getTypeIcon(guest["type"]),
                                  color: guest["type"] == "VIP" ? Colors.black : Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${guest["type"]}",
                                  style: TextStyle(
                                    color: guest["type"] == "VIP" ? Colors.black : Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${guest["loyaltyPoints"]} pts",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _getTypeColor(guest["type"]),
                            ),
                          ),
                        ],
                      ),

                      // Guest Info
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${guest["name"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.email, size: 14, color: disabledBoldColor),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        "${guest["email"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.phone, size: 14, color: disabledBoldColor),
                                    SizedBox(width: 4),
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
                          SizedBox(width: spSm),
                          Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${guest["visitCount"]} visits",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${((guest["totalSpent"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Last: ${guest["lastVisit"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Additional Info
                      if (guest["favoriteTable"] != null ||
                          guest["dietaryRestrictions"] != null ||
                          (guest["specialOccasions"] as List).isNotEmpty) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (guest["favoriteTable"] != null)
                                Row(
                                  children: [
                                    Icon(Icons.table_restaurant, size: 12, color: infoColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "Prefers: ${guest["favoriteTable"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ),
                              if (guest["dietaryRestrictions"] != null)
                                Row(
                                  children: [
                                    Icon(Icons.restaurant, size: 12, color: infoColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "Dietary: ${guest["dietaryRestrictions"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ),
                              if ((guest["specialOccasions"] as List).isNotEmpty)
                                Row(
                                  children: [
                                    Icon(Icons.celebration, size: 12, color: infoColor),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        "${(guest["specialOccasions"] as List).join(", ")}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],

                      // Notes
                      if (guest["notes"] != null && guest["notes"].toString().isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.note, size: 12, color: warningColor),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${guest["notes"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: warningColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Profile",
                              size: bs.sm,
                              onPressed: () => _viewGuestProfile(guest),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "New Reservation",
                              size: bs.sm,
                              onPressed: () => _createReservation(guest),
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.history,
                            size: bs.sm,
                            onPressed: () => _viewHistory(guest),
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () => _editGuestInfo(guest),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
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
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
