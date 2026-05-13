import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaFolioManagementView extends StatefulWidget {
  const HhaFolioManagementView({super.key});

  @override
  State<HhaFolioManagementView> createState() => _HhaFolioManagementViewState();
}

class _HhaFolioManagementViewState extends State<HhaFolioManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedRoom = "all";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Checked Out", "value": "checked_out"},
    {"label": "Pending Payment", "value": "pending"},
  ];

  List<Map<String, dynamic>> roomOptions = [
    {"label": "All Rooms", "value": "all"},
    {"label": "Standard", "value": "standard"},
    {"label": "Deluxe", "value": "deluxe"},
    {"label": "Suite", "value": "suite"},
  ];

  List<Map<String, dynamic>> folios = [
    {
      "id": "FOL001",
      "guest_name": "John Anderson",
      "room_number": "101",
      "room_type": "Standard",
      "check_in": "2024-01-15",
      "check_out": "2024-01-18",
      "nights": 3,
      "rate": 150.0,
      "total_charges": 450.0,
      "payments": 200.0,
      "balance": 250.0,
      "status": "active",
      "charges": [
        {"date": "2024-01-15", "description": "Room Charge", "amount": 150.0},
        {"date": "2024-01-16", "description": "Room Charge", "amount": 150.0},
        {"date": "2024-01-16", "description": "Restaurant", "amount": 45.0},
        {"date": "2024-01-17", "description": "Room Charge", "amount": 150.0},
        {"date": "2024-01-17", "description": "Minibar", "amount": 25.0},
      ],
      "payments_made": [
        {"date": "2024-01-15", "method": "Credit Card", "amount": 200.0},
      ]
    },
    {
      "id": "FOL002", 
      "guest_name": "Sarah Williams",
      "room_number": "205",
      "room_type": "Deluxe",
      "check_in": "2024-01-14",
      "check_out": "2024-01-17",
      "nights": 3,
      "rate": 220.0,
      "total_charges": 795.0,
      "payments": 795.0,
      "balance": 0.0,
      "status": "checked_out",
      "charges": [
        {"date": "2024-01-14", "description": "Room Charge", "amount": 220.0},
        {"date": "2024-01-15", "description": "Room Charge", "amount": 220.0},
        {"date": "2024-01-15", "description": "Spa Service", "amount": 85.0},
        {"date": "2024-01-16", "description": "Room Charge", "amount": 220.0},
        {"date": "2024-01-16", "description": "Room Service", "amount": 50.0},
      ],
      "payments_made": [
        {"date": "2024-01-14", "method": "Credit Card", "amount": 300.0},
        {"date": "2024-01-17", "method": "Cash", "amount": 495.0},
      ]
    },
    {
      "id": "FOL003",
      "guest_name": "Michael Chen",
      "room_number": "301",
      "room_type": "Suite",
      "check_in": "2024-01-16",
      "check_out": "2024-01-20",
      "nights": 4,
      "rate": 350.0,
      "total_charges": 1580.0,
      "payments": 500.0,
      "balance": 1080.0,
      "status": "active",
      "charges": [
        {"date": "2024-01-16", "description": "Room Charge", "amount": 350.0},
        {"date": "2024-01-17", "description": "Room Charge", "amount": 350.0},
        {"date": "2024-01-17", "description": "Conference Room", "amount": 180.0},
        {"date": "2024-01-18", "description": "Room Charge", "amount": 350.0},
        {"date": "2024-01-18", "description": "Laundry", "amount": 35.0},
        {"date": "2024-01-19", "description": "Room Charge", "amount": 350.0},
      ],
      "payments_made": [
        {"date": "2024-01-16", "method": "Credit Card", "amount": 500.0},
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredFolios {
    return folios.where((folio) {
      bool matchesSearch = searchQuery.isEmpty ||
          (folio["guest_name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (folio["room_number"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (folio["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || folio["status"] == selectedStatus;
      bool matchesRoom = selectedRoom == "all" || 
          (folio["room_type"] as String).toLowerCase().contains(selectedRoom);
      
      return matchesSearch && matchesStatus && matchesRoom;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Folio Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active Folios", icon: Icon(Icons.receipt_long)),
        Tab(text: "Folio Details", icon: Icon(Icons.description)),
        Tab(text: "Payment History", icon: Icon(Icons.payment)),
      ],
      tabChildren: [
        _buildActiveFoliosTab(),
        _buildFolioDetailsTab(),
        _buildPaymentHistoryTab(),
      ],
    );
  }

  Widget _buildActiveFoliosTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search",
                  hint: "Search by guest name, room number, or folio ID",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
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
                  label: "Room Type",
                  items: roomOptions,
                  value: selectedRoom,
                  onChanged: (value, label) {
                    selectedRoom = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Summary Stats
          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Total Active",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${folios.where((f) => f["status"] == "active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
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
                        "Total Balance",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((folios.fold(0.0, (sum, f) => sum + (f["balance"] as double))) as double).currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Folios List
          Text(
            "Active Folios",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...filteredFolios.map((folio) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: (folio["status"] as String) == "active" 
                      ? successColor 
                      : (folio["status"] as String) == "pending"
                          ? warningColor
                          : disabledBoldColor,
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
                            "${folio["guest_name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Room ${folio["room_number"]} - ${folio["room_type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: (folio["status"] as String) == "active" 
                            ? successColor.withAlpha(20)
                            : (folio["status"] as String) == "pending"
                                ? warningColor.withAlpha(20)
                                : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${folio["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: (folio["status"] as String) == "active" 
                              ? successColor
                              : (folio["status"] as String) == "pending"
                                  ? warningColor
                                  : disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Check-in: ${folio["check_in"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Check-out: ${folio["check_out"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
                            "Total: \$${((folio["total_charges"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Balance: \$${((folio["balance"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: (folio["balance"] as double) > 0 
                                  ? warningColor 
                                  : successColor,
                            ),
                          ),
                        ],
                      ),
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
                          currentTab = 1;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Add Charge",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.receipt,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildFolioDetailsTab() {
    final folio = folios.first;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Guest Information
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Guest Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Guest Name",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${folio["guest_name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Folio ID",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${folio["id"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Room",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${folio["room_number"]} - ${folio["room_type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nights",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${folio["nights"]} nights",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Charges Details
          Container(
            padding: EdgeInsets.all(spMd),
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
                    Expanded(
                      child: Text(
                        "Charges",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Add Charge",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                
                ...(folio["charges"] as List).map((charge) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${charge["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${charge["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${((charge["amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),

                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total Charges",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((folio["total_charges"] as double)).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Payment Summary
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Payment Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Total Charges",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "\$${((folio["total_charges"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Payments Made",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "\$${((folio["payments"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                
                Divider(),
                
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Balance Due",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "\$${((folio["balance"] as double)).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: (folio["balance"] as double) > 0 
                            ? warningColor 
                            : successColor,
                      ),
                    ),
                  ],
                ),
                
                if ((folio["balance"] as double) > 0)
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Process Payment",
                      onPressed: () {},
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Summary Stats
          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Total Payments",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((folios.fold(0.0, (sum, f) => sum + (f["payments"] as double))) as double).currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
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
                        "Outstanding",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((folios.fold(0.0, (sum, f) => sum + (f["balance"] as double))) as double).currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Text(
            "Payment History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Payment History List
          ...folios.map((folio) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
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
                    Expanded(
                      child: Text(
                        "${folio["guest_name"]} - ${folio["id"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Room ${folio["room_number"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                if ((folio["payments_made"] as List).isNotEmpty)
                  ...(folio["payments_made"] as List).map((payment) => Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.payment,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${payment["method"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${payment["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((payment["amount"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList()
                else
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "No payments made yet",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Total Paid: \$${((folio["payments"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                    Text(
                      "Balance: \$${((folio["balance"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: (folio["balance"] as double) > 0 
                            ? warningColor 
                            : successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
