import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmTicketTypesView extends StatefulWidget {
  const EcmTicketTypesView({super.key});

  @override
  State<EcmTicketTypesView> createState() => _EcmTicketTypesViewState();
}

class _EcmTicketTypesViewState extends State<EcmTicketTypesView> {
  bool isLoading = false;
  String searchQuery = "";

  List<Map<String, dynamic>> ticketTypes = [
    {
      "id": 1,
      "name": "General Admission",
      "description": "Standard entry to the event with access to main areas",
      "price": 75.0,
      "quantity_available": 200,
      "quantity_sold": 156,
      "status": "active",
      "category": "standard",
      "perks": ["Event access", "Refreshments", "Basic seating"],
      "color": "#2196F3"
    },
    {
      "id": 2,
      "name": "VIP Premium",
      "description": "Premium experience with exclusive access and benefits",
      "price": 250.0,
      "quantity_available": 50,
      "quantity_sold": 38,
      "status": "active",
      "category": "premium",
      "perks": ["Priority seating", "Welcome drink", "VIP lounge access", "Meet & greet"],
      "color": "#FF9800"
    },
    {
      "id": 3,
      "name": "Student Discount",
      "description": "Special pricing for students with valid ID",
      "price": 45.0,
      "quantity_available": 100,
      "quantity_sold": 23,
      "status": "active",
      "category": "discount",
      "perks": ["Event access", "Student networking area"],
      "color": "#4CAF50"
    },
    {
      "id": 4,
      "name": "Early Bird Special",
      "description": "Limited time offer for early registrants",
      "price": 55.0,
      "quantity_available": 75,
      "quantity_sold": 75,
      "status": "sold_out",
      "category": "limited",
      "perks": ["Event access", "Early bird gift", "Priority check-in"],
      "color": "#9C27B0"
    },
    {
      "id": 5,
      "name": "Group Package (5+)",
      "description": "Special rates for groups of 5 or more people",
      "price": 65.0,
      "quantity_available": 150,
      "quantity_sold": 89,
      "status": "active",
      "category": "group",
      "perks": ["Group seating", "Team activities", "Group photo"],
      "color": "#607D8B"
    },
    {
      "id": 6,
      "name": "Workshop Add-on",
      "description": "Additional workshop session access",
      "price": 35.0,
      "quantity_available": 80,
      "quantity_sold": 45,
      "status": "draft",
      "category": "addon",
      "perks": ["Workshop materials", "Certificate", "Q&A session"],
      "color": "#795548"
    }
  ];

  List<Map<String, dynamic>> get filteredTickets {
    if (searchQuery.isEmpty) return ticketTypes;
    return ticketTypes.where((ticket) {
      return ticket["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             ticket["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             ticket["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket) {
    Color statusColor = ticket["status"] == "active" 
        ? successColor 
        : ticket["status"] == "sold_out" 
            ? dangerColor 
            : ticket["status"] == "draft"
                ? warningColor
                : disabledBoldColor;

    Color categoryColor = Color(int.parse(ticket["color"].toString().replaceAll("#", "0xFF")));
    double salesPercentage = (ticket["quantity_sold"] as int) / (ticket["quantity_available"] as int);

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
                    _getCategoryIcon(ticket["category"]),
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
                        "${ticket["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${ticket["category"]}".toUpperCase(),
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
                    "${ticket["status"]}".replaceAll("_", " ").toUpperCase(),
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
              "${ticket["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${((ticket["price"] as double)).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sold",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${ticket["quantity_sold"]} / ${ticket["quantity_available"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Sales Rate",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(salesPercentage * 100).toInt()}%",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: salesPercentage > 0.8 ? successColor : 
                                salesPercentage > 0.5 ? warningColor : infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            LinearProgressIndicator(
              value: salesPercentage,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                salesPercentage > 0.8 ? successColor : 
                salesPercentage > 0.5 ? warningColor : infoColor
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Perks & Benefits:",
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
              children: (ticket["perks"] as List).map<Widget>((perk) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "$perk",
                    style: TextStyle(
                      fontSize: 10,
                      color: categoryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Edit Ticket",
                    size: bs.sm,
                    onPressed: () => _editTicket(ticket),
                  ),
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () => _viewTicketDetails(ticket),
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.copy,
                  size: bs.sm,
                  onPressed: () => _duplicateTicket(ticket),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    int totalTickets = ticketTypes.fold(0, (sum, ticket) => sum + (ticket["quantity_available"] as int));
    int totalSold = ticketTypes.fold(0, (sum, ticket) => sum + (ticket["quantity_sold"] as int));
    double totalRevenue = ticketTypes.fold(0.0, (sum, ticket) => 
        sum + ((ticket["quantity_sold"] as int) * (ticket["price"] as double)));
    int activeTypes = ticketTypes.where((ticket) => ticket["status"] == "active").length;

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
            "Ticket Sales Summary",
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
                        Icon(Icons.confirmation_number, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Total Tickets",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalTickets",
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
                        Icon(Icons.sell, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Tickets Sold",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$totalSold",
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
                        Icon(Icons.category, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Active Types",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$activeTypes",
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

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "standard":
        return Icons.confirmation_number;
      case "premium":
        return Icons.star;
      case "discount":
        return Icons.school;
      case "limited":
        return Icons.flash_on;
      case "group":
        return Icons.group;
      case "addon":
        return Icons.add_circle;
      default:
        return Icons.local_activity;
    }
  }

  void _editTicket(Map<String, dynamic> ticket) {
    // Navigate to edit ticket
  }

  void _viewTicketDetails(Map<String, dynamic> ticket) {
    // Show ticket details
  }

  void _duplicateTicket(Map<String, dynamic> ticket) {
    // Duplicate ticket type
  }

  void _addNewTicketType() {
    // Navigate to add new ticket type
  }

  void _filterTickets() {
    // Show filter options
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket Types"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _addNewTicketType,
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
                              hintText: "Search ticket types...",
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
                  onPressed: _filterTickets,
                ),
              ],
            ),
            SizedBox(height: spSm),
            _buildSummaryCard(),
            SizedBox(height: spSm),
            Text(
              "Ticket Types (${filteredTickets.length})",
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
              ...filteredTickets.map((ticket) => _buildTicketCard(ticket)).toList(),
          ],
        ),
      ),
    );
  }
}
