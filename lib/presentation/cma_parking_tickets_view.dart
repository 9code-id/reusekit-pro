import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaParkingTicketsView extends StatefulWidget {
  const CmaParkingTicketsView({super.key});

  @override
  State<CmaParkingTicketsView> createState() => _CmaParkingTicketsViewState();
}

class _CmaParkingTicketsViewState extends State<CmaParkingTicketsView> {
  String selectedFilter = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Unpaid", "value": "Unpaid"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Contested", "value": "Contested"},
    {"label": "Dismissed", "value": "Dismissed"},
    {"label": "Overdue", "value": "Overdue"},
  ];

  List<Map<String, dynamic>> parkingTickets = [
    {
      "ticketNumber": "PKG-2024-001789",
      "violation": "Expired Meter",
      "description": "Parking meter expired by 45 minutes",
      "date": DateTime(2024, 3, 20),
      "time": "14:30",
      "location": "Main Street (Meter #1234)",
      "zone": "Downtown Commercial",
      "officerBadge": "P-567",
      "vehicleLicense": "ABC123",
      "vehicleMake": "Honda",
      "vehicleModel": "Civic",
      "vehicleColor": "Blue",
      "fineAmount": 25.00,
      "lateFee": 0.00,
      "totalAmount": 25.00,
      "status": "Unpaid",
      "dueDate": DateTime(2024, 4, 20),
      "issueDate": DateTime(2024, 3, 20),
      "paymentDeadline": DateTime(2024, 4, 19),
    },
    {
      "ticketNumber": "PKG-2024-001456",
      "violation": "No Parking Zone",
      "description": "Parked in designated no parking area",
      "date": DateTime(2024, 2, 15),
      "time": "08:15",
      "location": "City Hall Plaza",
      "zone": "Government District",
      "officerBadge": "P-123",
      "vehicleLicense": "ABC123",
      "vehicleMake": "Honda",
      "vehicleModel": "Civic",
      "vehicleColor": "Blue",
      "fineAmount": 50.00,
      "lateFee": 15.00,
      "totalAmount": 65.00,
      "status": "Overdue",
      "dueDate": DateTime(2024, 3, 15),
      "issueDate": DateTime(2024, 2, 15),
      "paymentDeadline": DateTime(2024, 3, 14),
    },
    {
      "ticketNumber": "PKG-2023-009876",
      "violation": "Handicap Zone",
      "description": "Parking in handicap space without permit",
      "date": DateTime(2023, 12, 10),
      "time": "16:45",
      "location": "Shopping Mall Lot A",
      "zone": "Commercial",
      "officerBadge": "P-789",
      "vehicleLicense": "ABC123",
      "vehicleMake": "Honda",
      "vehicleModel": "Civic",
      "vehicleColor": "Blue",
      "fineAmount": 200.00,
      "lateFee": 0.00,
      "totalAmount": 200.00,
      "status": "Paid",
      "dueDate": DateTime(2024, 1, 10),
      "issueDate": DateTime(2023, 12, 10),
      "paymentDeadline": DateTime(2024, 1, 9),
      "paymentDate": DateTime(2023, 12, 28),
    },
    {
      "ticketNumber": "PKG-2023-007654",
      "violation": "Fire Hydrant",
      "description": "Parked within 15 feet of fire hydrant",
      "date": DateTime(2023, 10, 5),
      "time": "19:20",
      "location": "Oak Street & 3rd Avenue",
      "zone": "Residential",
      "officerBadge": "P-456",
      "vehicleLicense": "ABC123",
      "vehicleMake": "Honda",
      "vehicleModel": "Civic",
      "vehicleColor": "Blue",
      "fineAmount": 100.00,
      "lateFee": 0.00,
      "totalAmount": 100.00,
      "status": "Contested",
      "dueDate": DateTime(2023, 11, 5),
      "issueDate": DateTime(2023, 10, 5),
      "paymentDeadline": DateTime(2023, 11, 4),
      "contestDate": DateTime(2023, 10, 20),
    },
    {
      "ticketNumber": "PKG-2023-005432",
      "violation": "Street Cleaning",
      "description": "Parked during street cleaning hours",
      "date": DateTime(2023, 8, 18),
      "time": "07:00",
      "location": "Elm Street (400 Block)",
      "zone": "Residential",
      "officerBadge": "P-234",
      "vehicleLicense": "ABC123",
      "vehicleMake": "Honda",
      "vehicleModel": "Civic",
      "vehicleColor": "Blue",
      "fineAmount": 35.00,
      "lateFee": 0.00,
      "totalAmount": 35.00,
      "status": "Dismissed",
      "dueDate": DateTime(2023, 9, 18),
      "issueDate": DateTime(2023, 8, 18),
      "paymentDeadline": DateTime(2023, 9, 17),
      "dismissalDate": DateTime(2023, 9, 10),
    },
  ];

  List<Map<String, dynamic>> ticketStats = [
    {
      "title": "Total Tickets",
      "value": "5",
      "icon": Icons.local_parking,
      "color": primaryColor,
    },
    {
      "title": "Unpaid Amount",
      "value": "\$90",
      "icon": Icons.attach_money,
      "color": dangerColor,
    },
    {
      "title": "This Year",
      "value": "2",
      "icon": Icons.calendar_today,
      "color": infoColor,
    },
    {
      "title": "Overdue",
      "value": "1",
      "icon": Icons.warning,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> violationTypes = [
    {
      "type": "Expired Meter",
      "fine": 25.00,
      "description": "Parking meter time has expired",
      "frequency": "Most Common",
    },
    {
      "type": "No Parking Zone",
      "fine": 50.00,
      "description": "Parking in restricted area",
      "frequency": "Common",
    },
    {
      "type": "Handicap Zone",
      "fine": 200.00,
      "description": "Parking in handicap space without permit",
      "frequency": "Serious",
    },
    {
      "type": "Fire Hydrant",
      "fine": 100.00,
      "description": "Parking within 15 feet of fire hydrant",
      "frequency": "Safety",
    },
    {
      "type": "Street Cleaning",
      "fine": 35.00,
      "description": "Parking during posted cleaning hours",
      "frequency": "Scheduled",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTickets = _getFilteredTickets();
    double totalUnpaid = _calculateTotalUnpaid();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking Tickets"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Outstanding Balance Alert
            if (totalUnpaid > 0)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: dangerColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.error, color: dangerColor, size: 28),
                        SizedBox(width: spSm),
                        Text(
                          "Outstanding Balance",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "You have \$${totalUnpaid.toStringAsFixed(2)} in unpaid parking tickets. Pay now to avoid additional late fees.",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Pay All (\$${totalUnpaid.toStringAsFixed(0)})",
                            color: dangerColor,
                            onPressed: () {
                              _showPayAllDialog();
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Set Auto-Pay",
                          icon: Icons.schedule,
                          onPressed: () {
                            _showAutoPayDialog();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Quick Statistics
            Text(
              "Parking Ticket Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: ticketStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: (stat["color"] as Color).withAlpha(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          stat["icon"] as IconData,
                          color: stat["color"] as Color,
                          size: 20,
                        ),
                      ),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: stat["color"] as Color,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Tickets",
                    value: searchQuery,
                    hint: "Ticket number, location, etc.",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Period",
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
                    label: "Filter by Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Parking Tickets List
            Text(
              "Parking Tickets (${filteredTickets.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (filteredTickets.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 64,
                      color: successColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Parking Tickets",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "You have no parking tickets for the selected criteria.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                spacing: spSm,
                children: filteredTickets.map((ticket) {
                  Color statusColor = _getStatusColor(ticket["status"] as String);
                  bool isOverdue = (ticket["status"] as String) == "Overdue";
                  bool isUnpaid = (ticket["status"] as String) == "Unpaid";
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: isOverdue || isUnpaid
                          ? Border.all(color: dangerColor.withAlpha(50), width: 2)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${ticket["violation"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${ticket["status"]}",
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          "${ticket["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.confirmation_number, size: 16, color: primaryColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Ticket: ${ticket["ticketNumber"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(ticket["date"] as DateTime).dMMMy} at ${ticket["time"]}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${ticket["location"]}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.directions_car, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${ticket["vehicleLicense"]} - ${ticket["vehicleColor"]} ${ticket["vehicleMake"]} ${ticket["vehicleModel"]}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  if (isUnpaid || isOverdue)
                                    Text(
                                      "Due: ${(ticket["dueDate"] as DateTime).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isOverdue ? dangerColor : warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  Text(
                                    "Zone: ${ticket["zone"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Officer: ${ticket["officerBadge"]}",
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
                              spacing: spXs,
                              children: [
                                Text(
                                  "\$${(ticket["totalAmount"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isUnpaid || isOverdue ? dangerColor : primaryColor,
                                  ),
                                ),
                                if ((ticket["lateFee"] as double) > 0)
                                  Text(
                                    "+\$${(ticket["lateFee"] as double).toStringAsFixed(0)} late fee",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                if (ticket["paymentDate"] != null)
                                  Text(
                                    "Paid: ${(ticket["paymentDate"] as DateTime).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  _showTicketDetails(ticket);
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            if (isUnpaid || isOverdue)
                              QButton(
                                label: "Pay Now",
                                icon: Icons.payment,
                                size: bs.sm,
                                color: primaryColor,
                                onPressed: () {
                                  _showPaymentDialog(ticket);
                                },
                              )
                            else if ((ticket["status"] as String) == "Paid")
                              QButton(
                                label: "Receipt",
                                icon: Icons.receipt,
                                size: bs.sm,
                                color: successColor,
                                onPressed: () {
                                  si("Downloading payment receipt");
                                },
                              )
                            else if ((ticket["status"] as String) == "Contested")
                              QButton(
                                label: "Contest Status",
                                icon: Icons.gavel,
                                size: bs.sm,
                                color: warningColor,
                                onPressed: () {
                                  _showContestStatus(ticket);
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            // Violation Types Information
            Text(
              "Common Parking Violations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              spacing: spSm,
              children: violationTypes.map((violation) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.local_parking,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${violation["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${violation["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${violation["frequency"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(violation["fine"] as double).toStringAsFixed(0)}",
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
            ),

            // Tips and Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor),
                      SizedBox(width: spSm),
                      Text(
                        "Parking Tips & Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Pay tickets within 30 days to avoid late fees\n"
                    "• Contest tickets within 21 days of issue date\n"
                    "• Use mobile apps to extend meter time\n"
                    "• Check street signs for parking restrictions\n"
                    "• Set up auto-pay to avoid missed payments",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Parking App",
                          icon: Icons.smartphone,
                          size: bs.sm,
                          color: infoColor,
                          onPressed: () {
                            si("Opening parking app");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Contest Ticket",
                          icon: Icons.gavel,
                          size: bs.sm,
                          color: infoColor,
                          onPressed: () {
                            _showContestDialog();
                          },
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
    );
  }

  List<Map<String, dynamic>> _getFilteredTickets() {
    List<Map<String, dynamic>> filtered = parkingTickets;
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((ticket) {
        return (ticket["ticketNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (ticket["location"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (ticket["violation"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Filter by period
    if (selectedFilter != "All") {
      DateTime now = DateTime.now();
      DateTime filterDate;
      
      switch (selectedFilter) {
        case "This Month":
          filterDate = DateTime(now.year, now.month, 1);
          break;
        case "Last Month":
          filterDate = DateTime(now.year, now.month - 1, 1);
          break;
        case "This Year":
          filterDate = DateTime(now.year, 1, 1);
          break;
        case "Last Year":
          filterDate = DateTime(now.year - 1, 1, 1);
          break;
        default:
          filterDate = DateTime(1900);
      }
      
      filtered = filtered.where((ticket) => (ticket["date"] as DateTime).isAfter(filterDate)).toList();
    }
    
    // Filter by status
    if (selectedStatus != "All") {
      filtered = filtered.where((ticket) => ticket["status"] == selectedStatus).toList();
    }
    
    return filtered;
  }

  double _calculateTotalUnpaid() {
    return parkingTickets
        .where((ticket) => ticket["status"] == "Unpaid" || ticket["status"] == "Overdue")
        .map((ticket) => ticket["totalAmount"] as double)
        .fold(0.0, (sum, amount) => sum + amount);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Unpaid":
        return warningColor;
      case "Overdue":
        return dangerColor;
      case "Contested":
        return infoColor;
      case "Dismissed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Tickets"),
        content: QTextField(
          label: "Search",
          value: searchQuery,
          hint: "Ticket number, location, violation type...",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Search"),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Tickets"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Time Period",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply Filters"),
          ),
        ],
      ),
    );
  }

  void _showTicketDetails(Map<String, dynamic> ticket) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ticket Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ticket: ${ticket["ticketNumber"]}"),
            Text("Violation: ${ticket["violation"]}"),
            Text("Date: ${(ticket["date"] as DateTime).dMMMy} at ${ticket["time"]}"),
            Text("Location: ${ticket["location"]}"),
            Text("Vehicle: ${ticket["vehicleLicense"]} - ${ticket["vehicleColor"]} ${ticket["vehicleMake"]} ${ticket["vehicleModel"]}"),
            Text("Fine: \$${(ticket["fineAmount"] as double).toStringAsFixed(2)}"),
            if ((ticket["lateFee"] as double) > 0)
              Text("Late Fee: \$${(ticket["lateFee"] as double).toStringAsFixed(2)}"),
            Text("Total: \$${(ticket["totalAmount"] as double).toStringAsFixed(2)}"),
            Text("Status: ${ticket["status"]}"),
            Text("Officer: ${ticket["officerBadge"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(Map<String, dynamic> ticket) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pay Parking Ticket"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Ticket: ${ticket["ticketNumber"]}"),
            Text("Amount: \$${(ticket["totalAmount"] as double).toStringAsFixed(2)}"),
            SizedBox(height: spSm),
            Text("You will be redirected to the secure payment portal."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Payment processed successfully");
            },
            child: Text("Pay Now"),
          ),
        ],
      ),
    );
  }

  void _showPayAllDialog() {
    double totalAmount = _calculateTotalUnpaid();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pay All Outstanding Tickets"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Total Amount: \$${totalAmount.toStringAsFixed(2)}"),
            SizedBox(height: spSm),
            Text("This will pay all unpaid and overdue parking tickets."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("All tickets paid successfully");
            },
            child: Text("Pay All"),
          ),
        ],
      ),
    );
  }

  void _showAutoPayDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Set Up Auto-Pay"),
        content: Text(
          "Auto-pay will automatically pay parking tickets from your registered payment method within 5 days of issue."
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Auto-pay setup completed");
            },
            child: Text("Enable Auto-Pay"),
          ),
        ],
      ),
    );
  }

  void _showContestStatus(Map<String, dynamic> ticket) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contest Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ticket: ${ticket["ticketNumber"]}"),
            Text("Contest Date: ${(ticket["contestDate"] as DateTime).dMMMy}"),
            Text("Status: Under Review"),
            SizedBox(height: spSm),
            Text("Your contest is being reviewed. You will be notified of the decision within 30 days."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showContestDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contest Parking Ticket"),
        content: Text(
          "You can contest a parking ticket within 21 days of the issue date. "
          "Select a ticket to contest and provide your reason for contesting."
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Opening contest form");
            },
            child: Text("Contest Ticket"),
          ),
        ],
      ),
    );
  }
}
