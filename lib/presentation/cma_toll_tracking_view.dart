import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTollTrackingView extends StatefulWidget {
  const CmaTollTrackingView({super.key});

  @override
  State<CmaTollTrackingView> createState() => _CmaTollTrackingViewState();
}

class _CmaTollTrackingViewState extends State<CmaTollTrackingView> {
  List<Map<String, dynamic>> tollTransactions = [
    {
      "id": "TXN001",
      "tollGate": "Golden Gate Bridge",
      "location": "San Francisco, CA",
      "vehicleNumber": "CA-1234-AB",
      "amount": 8.50,
      "date": "2024-12-19T09:15:00Z",
      "status": "Paid",
      "paymentMethod": "EZ-Pass",
      "route": "Highway 101 North",
      "direction": "Northbound"
    },
    {
      "id": "TXN002", 
      "tollGate": "Bay Bridge",
      "location": "Oakland, CA",
      "vehicleNumber": "CA-5678-CD",
      "amount": 7.00,
      "date": "2024-12-19T08:30:00Z",
      "status": "Pending",
      "paymentMethod": "Cash",
      "route": "Interstate 80 West",
      "direction": "Westbound"
    },
    {
      "id": "TXN003",
      "tollGate": "Richmond Bridge", 
      "location": "Richmond, CA",
      "vehicleNumber": "CA-9012-EF",
      "amount": 6.75,
      "date": "2024-12-19T07:45:00Z",
      "status": "Failed",
      "paymentMethod": "Credit Card",
      "route": "Highway 580 East",
      "direction": "Eastbound"
    },
    {
      "id": "TXN004",
      "tollGate": "Dumbarton Bridge",
      "location": "Fremont, CA",
      "vehicleNumber": "CA-3456-GH",
      "amount": 7.25,
      "date": "2024-12-18T16:20:00Z",
      "status": "Paid",
      "paymentMethod": "FasTrak",
      "route": "Highway 84 West",
      "direction": "Westbound"
    }
  ];

  List<Map<String, dynamic>> vehicleList = [
    {"label": "All Vehicles", "value": "all"},
    {"label": "CA-1234-AB", "value": "CA-1234-AB"},
    {"label": "CA-5678-CD", "value": "CA-5678-CD"},
    {"label": "CA-9012-EF", "value": "CA-9012-EF"},
    {"label": "CA-3456-GH", "value": "CA-3456-GH"}
  ];

  List<Map<String, dynamic>> statusList = [
    {"label": "All Status", "value": "all"},
    {"label": "Paid", "value": "paid"},
    {"label": "Pending", "value": "pending"},
    {"label": "Failed", "value": "failed"}
  ];

  String selectedVehicle = "all";
  String selectedStatus = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> get filteredTransactions {
    return tollTransactions.where((transaction) {
      bool matchesVehicle = selectedVehicle == "all" || 
          (transaction["vehicleNumber"] as String).toLowerCase().contains(selectedVehicle.toLowerCase());
      bool matchesStatus = selectedStatus == "all" ||
          (transaction["status"] as String).toLowerCase() == selectedStatus.toLowerCase();
      bool matchesSearch = searchQuery.isEmpty ||
          (transaction["tollGate"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["location"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesVehicle && matchesStatus && matchesSearch;
    }).toList();
  }

  double get totalAmount {
    return filteredTransactions
        .where((t) => (t["status"] as String).toLowerCase() == "paid")
        .fold(0.0, (sum, t) => sum + (t["amount"] as double));
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return successColor;
      case 'pending':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toll Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add toll transaction
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
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
                        Row(
                          children: [
                            Icon(
                              Icons.toll,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Paid",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${totalAmount.currency}",
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
                        Row(
                          children: [
                            Icon(
                              Icons.receipt,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Transactions",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${filteredTransactions.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filters
            Container(
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
                      Icon(
                        Icons.filter_list,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search by location or toll gate",
                          value: searchQuery,
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
                          label: "Vehicle",
                          items: vehicleList,
                          value: selectedVehicle,
                          onChanged: (value, label) {
                            selectedVehicle = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusList,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Transactions List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Transaction History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredTransactions.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledOutlineBorderColor,
                    ),
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      final date = DateTime.parse("${transaction["date"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
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
                                        "${transaction["tollGate"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${transaction["location"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor("${transaction["status"]}").withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${transaction["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor("${transaction["status"]}"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "\$${(transaction["amount"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.directions_car,
                                        color: disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${transaction["vehicleNumber"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.payment,
                                        color: disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${transaction["paymentMethod"]}",
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
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        color: disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        date.dMMMy,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.route,
                                        color: disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${transaction["route"]}",
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
                          ],
                        ),
                      );
                    },
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
