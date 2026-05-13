import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosGoodsReceivedView extends StatefulWidget {
  const PosGoodsReceivedView({super.key});

  @override
  State<PosGoodsReceivedView> createState() => _PosGoodsReceivedViewState();
}

class _PosGoodsReceivedViewState extends State<PosGoodsReceivedView> {
  String selectedStatus = "All";
  String searchQuery = "";
  DateTime? selectedDate;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Partial", "value": "Partial"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Discrepancy", "value": "Discrepancy"},
  ];

  List<Map<String, dynamic>> goodsReceived = [
    {
      "id": "GRN-2024-001",
      "purchaseOrderId": "PO-2024-001",
      "supplier": "ABC Electronics Supply",
      "receivedDate": "2024-06-18",
      "status": "Completed",
      "expectedItems": 8,
      "receivedItems": 8,
      "totalValue": 15750.00,
      "receivedBy": "John Smith",
      "notes": "All items received in good condition",
    },
    {
      "id": "GRN-2024-002",
      "purchaseOrderId": "PO-2024-002",
      "supplier": "Global Parts Distribution",
      "receivedDate": "2024-06-17",
      "status": "Partial",
      "expectedItems": 5,
      "receivedItems": 3,
      "totalValue": 5352.30,
      "receivedBy": "Sarah Johnson",
      "notes": "2 items back-ordered, expected next week",
    },
    {
      "id": "GRN-2024-003",
      "purchaseOrderId": "PO-2024-003",
      "supplier": "TechFlow Components",
      "receivedDate": "2024-06-16",
      "status": "Discrepancy",
      "expectedItems": 12,
      "receivedItems": 10,
      "totalValue": 18417.29,
      "receivedBy": "Mike Wilson",
      "notes": "2 items damaged during shipping, replacement requested",
    },
    {
      "id": "GRN-2024-004",
      "purchaseOrderId": "PO-2024-004",
      "supplier": "Metro Office Supplies",
      "receivedDate": "2024-06-15",
      "status": "Completed",
      "expectedItems": 15,
      "receivedItems": 15,
      "totalValue": 3450.25,
      "receivedBy": "Lisa Chen",
      "notes": "Perfect delivery, all items as ordered",
    },
    {
      "id": "GRN-2024-005",
      "purchaseOrderId": "PO-2024-005",
      "supplier": "Digital Solutions Inc",
      "receivedDate": "2024-06-14",
      "status": "Pending",
      "expectedItems": 7,
      "receivedItems": 0,
      "totalValue": 0.00,
      "receivedBy": "",
      "notes": "Awaiting delivery confirmation",
    },
  ];

  List<Map<String, dynamic>> get filteredGoods {
    return goodsReceived.where((goods) {
      bool matchesStatus = selectedStatus == "All" || goods["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
          goods["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          goods["purchaseOrderId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          goods["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDate = selectedDate == null ||
          DateTime.parse(goods["receivedDate"]).day == selectedDate!.day;
      return matchesStatus && matchesSearch && matchesDate;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Partial":
        return infoColor;
      case "Completed":
        return successColor;
      case "Discrepancy":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Goods Received"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateGoodsReceivedView')
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
                          label: "Search Goods Received",
                          value: searchQuery,
                          hint: "Search by GRN, PO ID, or supplier",
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
                        child: QDatePicker(
                          label: "Filter by Date",
                          value: selectedDate,
                          onChanged: (value) {
                            selectedDate = value;
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
                              Icons.inventory,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Receipts",
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
                          "${goodsReceived.length}",
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
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Completed",
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
                          "${goodsReceived.where((g) => g["status"] == "Completed").length}",
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
              ],
            ),

            // Goods Received List
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
                          Icons.receipt_long,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Goods Received Notes (${filteredGoods.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...filteredGoods.map((goods) {
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${goods["id"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "PO: ${goods["purchaseOrderId"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(goods["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${goods["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: getStatusColor(goods["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${goods["supplier"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
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
                                "Received: ${DateTime.parse(goods["receivedDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (goods["receivedBy"].toString().isNotEmpty) ...[
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.person,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "By: ${goods["receivedBy"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${goods["receivedItems"]}/${goods["expectedItems"]} items",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Value: \$${((goods["totalValue"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          if (goods["notes"].toString().isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${goods["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              Spacer(),
                              Row(
                                children: [
                                  QButton(
                                    icon: Icons.visibility,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('GoodsReceivedDetailView')
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.edit,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('EditGoodsReceivedView')
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.print,
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('PrintGoodsReceivedView')
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
          //navigateTo('CreateGoodsReceivedView')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
