import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLibrary10View extends StatefulWidget {
  @override
  State<GrlLibrary10View> createState() => _GrlLibrary10ViewState();
}

class _GrlLibrary10ViewState extends State<GrlLibrary10View> {
  String searchQuery = "";
  String selectedPeriod = "This Month";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": 1,
      "type": "Borrow",
      "item": "Advanced Machine Learning",
      "author": "Dr. Sarah Mitchell",
      "date": "2024-12-21",
      "dueDate": "2025-01-04",
      "status": "Active",
      "fine": 0.0,
      "renewals": 0,
      "barcode": "LIB001234567",
      "format": "Physical Book",
    },
    {
      "id": 2,
      "type": "Return",
      "item": "Digital Signal Processing",
      "author": "Prof. John Anderson",
      "date": "2024-12-20",
      "dueDate": "2024-12-20",
      "status": "Returned On Time",
      "fine": 0.0,
      "renewals": 1,
      "barcode": "LIB001234568",
      "format": "Physical Book",
    },
    {
      "id": 3,
      "type": "Overdue",
      "item": "Quantum Computing Principles",
      "author": "Dr. Alice Chen",
      "date": "2024-12-05",
      "dueDate": "2024-12-19",
      "status": "Overdue",
      "fine": 7.50,
      "renewals": 2,
      "barcode": "LIB001234569",
      "format": "Physical Book",
    },
    {
      "id": 4,
      "type": "Digital Access",
      "item": "IEEE Database",
      "author": "IEEE",
      "date": "2024-12-21",
      "dueDate": "",
      "status": "Accessed",
      "fine": 0.0,
      "renewals": 0,
      "barcode": "DIG001234567",
      "format": "Digital Resource",
    },
    {
      "id": 5,
      "type": "Reservation",
      "item": "Artificial Intelligence Handbook",
      "author": "Dr. Robert Kim",
      "date": "2024-12-18",
      "dueDate": "2024-12-25",
      "status": "Ready for Pickup",
      "fine": 0.0,
      "renewals": 0,
      "barcode": "LIB001234570",
      "format": "Physical Book",
    },
    {
      "id": 6,
      "type": "Fine Payment",
      "item": "Late Return Fee",
      "author": "",
      "date": "2024-12-17",
      "dueDate": "",
      "status": "Paid",
      "fine": -12.00,
      "renewals": 0,
      "barcode": "FINE001234",
      "format": "Payment",
    },
    {
      "id": 7,
      "type": "Renewal",
      "item": "Data Structures and Algorithms",
      "author": "Prof. Maria Garcia",
      "date": "2024-12-15",
      "dueDate": "2024-12-29",
      "status": "Renewed",
      "fine": 0.0,
      "renewals": 1,
      "barcode": "LIB001234571",
      "format": "Physical Book",
    },
    {
      "id": 8,
      "type": "Room Booking",
      "item": "Study Room A",
      "author": "",
      "date": "2024-12-14",
      "dueDate": "2024-12-14",
      "status": "Completed",
      "fine": 0.0,
      "renewals": 0,
      "barcode": "ROOM001234",
      "format": "Facility",
    },
  ];

  Color _getTypeColor(String type) {
    switch (type) {
      case "Borrow":
        return primaryColor;
      case "Return":
        return successColor;
      case "Overdue":
        return dangerColor;
      case "Digital Access":
        return infoColor;
      case "Reservation":
        return warningColor;
      case "Fine Payment":
        return secondaryColor;
      case "Renewal":
        return primaryColor;
      case "Room Booking":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Returned On Time":
        return successColor;
      case "Overdue":
        return dangerColor;
      case "Accessed":
        return infoColor;
      case "Ready for Pickup":
        return warningColor;
      case "Paid":
        return successColor;
      case "Renewed":
        return primaryColor;
      case "Completed":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Borrow":
        return Icons.library_books;
      case "Return":
        return Icons.assignment_return;
      case "Overdue":
        return Icons.schedule;
      case "Digital Access":
        return Icons.computer;
      case "Reservation":
        return Icons.bookmark;
      case "Fine Payment":
        return Icons.payment;
      case "Renewal":
        return Icons.autorenew;
      case "Room Booking":
        return Icons.meeting_room;
      default:
        return Icons.history;
    }
  }

  List<Map<String, dynamic>> get filteredTransactions {
    List<Map<String, dynamic>> filtered = transactions;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((transaction) =>
          (transaction["item"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["author"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["type"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Map<String, dynamic> get statistics {
    final totalBorrows = transactions.where((t) => t["type"] == "Borrow").length;
    final totalReturns = transactions.where((t) => t["type"] == "Return").length;
    final activeLoans = transactions.where((t) => t["status"] == "Active").length;
    final totalFines = transactions
        .map((t) => t["fine"] as double)
        .where((fine) => fine > 0)
        .fold<double>(0.0, (sum, fine) => sum + fine);
    final overdueItems = transactions.where((t) => t["status"] == "Overdue").length;
    final digitalAccess = transactions.where((t) => t["type"] == "Digital Access").length;

    return {
      "totalBorrows": totalBorrows,
      "totalReturns": totalReturns,
      "activeLoans": activeLoans,
      "totalFines": totalFines,
      "overdueItems": overdueItems,
      "digitalAccess": digitalAccess,
    };
  }

  @override
  Widget build(BuildContext context) {
    final stats = statistics;

    return Scaffold(
      appBar: AppBar(
        title: Text("Library History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search history",
                    value: searchQuery,
                    hint: "Search by item, author, or type",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Statistics Dashboard
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Activity Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildStatCard(
                        "Total Borrows",
                        "${stats["totalBorrows"]}",
                        Icons.library_books,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Active Loans",
                        "${stats["activeLoans"]}",
                        Icons.book,
                        successColor,
                      ),
                      _buildStatCard(
                        "Overdue Items",
                        "${stats["overdueItems"]}",
                        Icons.schedule,
                        dangerColor,
                      ),
                      _buildStatCard(
                        "Total Fines",
                        "\$${(stats["totalFines"] as double).toStringAsFixed(2)}",
                        Icons.payment,
                        warningColor,
                      ),
                      _buildStatCard(
                        "Digital Access",
                        "${stats["digitalAccess"]}",
                        Icons.computer,
                        infoColor,
                      ),
                      _buildStatCard(
                        "Returns",
                        "${stats["totalReturns"]}",
                        Icons.assignment_return,
                        secondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Activity Types Filter
            Text(
              "Filter by Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: ["All", "Borrow", "Return", "Overdue", "Digital Access", "Reservation", "Fine Payment", "Renewal", "Room Booking"].map((type) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: type == "All" ? primaryColor : _getTypeColor(type).withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: type == "All" ? primaryColor : _getTypeColor(type),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (type != "All")
                        Icon(
                          _getTypeIcon(type),
                          size: 16,
                          color: type == "All" ? Colors.white : _getTypeColor(type),
                        ),
                      if (type != "All") SizedBox(width: spXs),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: type == "All" ? Colors.white : _getTypeColor(type),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Results
            Text(
              "${filteredTransactions.length} Transactions Found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),

            // Transaction History
            Column(
              spacing: spSm,
              children: filteredTransactions.map((transaction) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: transaction["status"] == "Overdue"
                        ? Border.all(color: dangerColor, width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getTypeColor(transaction["type"] as String).withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getTypeIcon(transaction["type"] as String),
                              color: _getTypeColor(transaction["type"] as String),
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${transaction["item"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(transaction["status"] as String),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${transaction["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if ((transaction["author"] as String).isNotEmpty)
                                  Text(
                                    "by ${transaction["author"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: _getTypeColor(transaction["type"] as String).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${transaction["type"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _getTypeColor(transaction["type"] as String),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${transaction["format"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Transaction Details
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Date: ${DateTime.parse(transaction["date"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if ((transaction["dueDate"] as String).isNotEmpty) ...[
                                  SizedBox(width: spMd),
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: transaction["status"] == "Overdue" ? dangerColor : disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Due: ${DateTime.parse(transaction["dueDate"] as String).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: transaction["status"] == "Overdue" ? dangerColor : disabledBoldColor,
                                      fontWeight: transaction["status"] == "Overdue" ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Barcode: ${transaction["barcode"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if ((transaction["renewals"] as int) > 0) ...[
                                  SizedBox(width: spMd),
                                  Icon(
                                    Icons.autorenew,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Renewals: ${transaction["renewals"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            if ((transaction["fine"] as double) != 0)
                              Row(
                                children: [
                                  Icon(
                                    Icons.payment,
                                    size: 16,
                                    color: (transaction["fine"] as double) > 0 ? dangerColor : successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    (transaction["fine"] as double) > 0
                                        ? "Fine: \$${(transaction["fine"] as double).toStringAsFixed(2)}"
                                        : "Payment: \$${(-(transaction["fine"] as double)).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: (transaction["fine"] as double) > 0 ? dangerColor : successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      // Action Buttons
                      if (transaction["status"] == "Active" || transaction["status"] == "Overdue")
                        Row(
                          children: [
                            if (transaction["status"] == "Active" && (transaction["renewals"] as int) < 3)
                              Expanded(
                                child: QButton(
                                  label: "Renew",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            if (transaction["status"] == "Overdue")
                              Expanded(
                                child: QButton(
                                  label: "Pay Fine",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.info_outline,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Export Options
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.download,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Export History",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Download your library activity history in various formats",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Export PDF",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export CSV",
                          size: bs.sm,
                          onPressed: () {},
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
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
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
