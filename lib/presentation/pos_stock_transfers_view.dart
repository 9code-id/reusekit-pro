import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosStockTransfersView extends StatefulWidget {
  const PosStockTransfersView({super.key});

  @override
  State<PosStockTransfersView> createState() => _PosStockTransfersViewState();
}

class _PosStockTransfersViewState extends State<PosStockTransfersView> {
  String selectedStatus = "All";
  String selectedType = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Outbound", "value": "Outbound"},
    {"label": "Inbound", "value": "Inbound"},
    {"label": "Internal", "value": "Internal"},
  ];

  List<Map<String, dynamic>> stockTransfers = [
    {
      "id": "ST-2024-001",
      "type": "Outbound",
      "fromLocation": "Main Warehouse",
      "toLocation": "Store A - Downtown",
      "transferDate": "2024-06-18",
      "status": "Completed",
      "items": 15,
      "totalValue": 8750.50,
      "transferredBy": "Mike Johnson",
      "receivedBy": "Sarah Wilson",
      "notes": "Regular stock replenishment",
    },
    {
      "id": "ST-2024-002",
      "type": "Inbound",
      "fromLocation": "Store B - Mall",
      "toLocation": "Main Warehouse",
      "transferDate": "2024-06-17",
      "status": "In Transit",
      "items": 8,
      "totalValue": 3250.75,
      "transferredBy": "Lisa Chen",
      "receivedBy": "",
      "notes": "Excess inventory return",
    },
    {
      "id": "ST-2024-003",
      "type": "Internal",
      "fromLocation": "Section A",
      "toLocation": "Section B",
      "transferDate": "2024-06-16",
      "status": "Completed",
      "items": 12,
      "totalValue": 1850.25,
      "transferredBy": "John Smith",
      "receivedBy": "Emma Davis",
      "notes": "Reorganization of product placement",
    },
    {
      "id": "ST-2024-004",
      "type": "Outbound",
      "fromLocation": "Main Warehouse",
      "toLocation": "Store C - Plaza",
      "transferDate": "2024-06-15",
      "status": "Pending",
      "items": 20,
      "totalValue": 12500.00,
      "transferredBy": "",
      "receivedBy": "",
      "notes": "New store opening stock",
    },
    {
      "id": "ST-2024-005",
      "type": "Inbound",
      "fromLocation": "Store A - Downtown",
      "toLocation": "Main Warehouse",
      "transferDate": "2024-06-14",
      "status": "Cancelled",
      "items": 5,
      "totalValue": 950.00,
      "transferredBy": "",
      "receivedBy": "",
      "notes": "Transfer cancelled due to inventory adjustment",
    },
  ];

  List<Map<String, dynamic>> get filteredTransfers {
    return stockTransfers.where((transfer) {
      bool matchesStatus = selectedStatus == "All" || transfer["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || transfer["type"] == selectedType;
      bool matchesSearch = searchQuery.isEmpty ||
          transfer["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          transfer["fromLocation"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          transfer["toLocation"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesType && matchesSearch;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Transit":
        return infoColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getTypeColor(String type) {
    switch (type) {
      case "Outbound":
        return dangerColor;
      case "Inbound":
        return successColor;
      case "Internal":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Transfers"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateStockTransferView')
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
            // Filters Section
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
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Transfers",
                          value: searchQuery,
                          hint: "Search by ID or location",
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
                          label: "Filter by Status",
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
                          label: "Filter by Type",
                          items: typeOptions,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.swap_horiz,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Transfers",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stockTransfers.length}",
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
                            Icon(
                              Icons.local_shipping,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "In Transit",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stockTransfers.where((t) => t["status"] == "In Transit").length}",
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

            // Transfer Statistics
            Container(
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
                    "Transfer Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${stockTransfers.where((t) => t["type"] == "Outbound").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Outbound",
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
                          children: [
                            Text(
                              "${stockTransfers.where((t) => t["type"] == "Inbound").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Inbound",
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
                          children: [
                            Text(
                              "${stockTransfers.where((t) => t["type"] == "Internal").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Internal",
                              style: TextStyle(
                                fontSize: 12,
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
            ),

            // Transfers List
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
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.list_alt,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Stock Transfers (${filteredTransfers.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...filteredTransfers.map((transfer) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: spSm,
                        right: spSm,
                        bottom: spSm,
                      ),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${transfer["id"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getTypeColor(transfer["type"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${transfer["type"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: getTypeColor(transfer["type"]),
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(transfer["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${transfer["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: getStatusColor(transfer["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${transfer["fromLocation"]}",
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
                              Icon(
                                Icons.arrow_downward,
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${transfer["toLocation"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Date: ${DateTime.parse(transfer["transferDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${transfer["items"]} items",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if (transfer["transferredBy"].toString().isNotEmpty ||
                              transfer["receivedBy"].toString().isNotEmpty)
                            Row(
                              children: [
                                if (transfer["transferredBy"].toString().isNotEmpty) ...[
                                  Icon(
                                    Icons.person_outline,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "By: ${transfer["transferredBy"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                                if (transfer["receivedBy"].toString().isNotEmpty) ...[
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.person,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Received: ${transfer["receivedBy"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          if (transfer["notes"].toString().isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${transfer["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              Text(
                                "Value: \$${((transfer["totalValue"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  QButton(
                                    icon: Icons.visibility,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('StockTransferDetailView')
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.edit,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('EditStockTransferView')
                                    },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('CreateStockTransferView')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
