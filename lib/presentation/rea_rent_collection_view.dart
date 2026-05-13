import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaRentCollectionView extends StatefulWidget {
  const ReaRentCollectionView({super.key});

  @override
  State<ReaRentCollectionView> createState() => _ReaRentCollectionViewState();
}

class _ReaRentCollectionViewState extends State<ReaRentCollectionView> {
  String searchQuery = "";
  String filterStatus = "all";
  String filterMonth = "current";
  
  List<Map<String, dynamic>> rentCollection = [
    {
      "id": "RC001",
      "tenantName": "John Smith",
      "propertyName": "Downtown Apartment 2A",
      "propertyImage": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "rentAmount": 1200.0,
      "dueDate": "2024-01-01",
      "paidDate": "2024-01-01",
      "status": "paid",
      "paymentMethod": "Bank Transfer",
      "lateFee": 0.0,
      "receipt": "RCP001"
    },
    {
      "id": "RC002", 
      "tenantName": "Sarah Johnson",
      "propertyName": "Sunset Villa Unit B",
      "propertyImage": "https://picsum.photos/300/200?random=2&keyword=villa",
      "rentAmount": 1800.0,
      "dueDate": "2024-01-05",
      "paidDate": null,
      "status": "overdue",
      "paymentMethod": null,
      "lateFee": 90.0,
      "receipt": null
    },
    {
      "id": "RC003",
      "tenantName": "Mike Wilson",
      "propertyName": "City Center Studio",
      "propertyImage": "https://picsum.photos/300/200?random=3&keyword=studio",
      "rentAmount": 900.0,
      "dueDate": "2024-01-10",
      "paidDate": null,
      "status": "pending",
      "paymentMethod": null,
      "lateFee": 0.0,
      "receipt": null
    },
    {
      "id": "RC004",
      "tenantName": "Emma Davis",
      "propertyName": "Garden View Condo",
      "propertyImage": "https://picsum.photos/300/200?random=4&keyword=condo",
      "rentAmount": 1500.0,
      "dueDate": "2024-01-15",
      "paidDate": "2024-01-14",
      "status": "paid",
      "paymentMethod": "Credit Card",
      "lateFee": 0.0,
      "receipt": "RCP004"
    },
    {
      "id": "RC005",
      "tenantName": "David Brown",
      "propertyName": "Luxury Penthouse",
      "propertyImage": "https://picsum.photos/300/200?random=5&keyword=penthouse",
      "rentAmount": 2500.0,
      "dueDate": "2024-01-20",
      "paidDate": null,
      "status": "partial",
      "paymentMethod": "Cash",
      "lateFee": 0.0,
      "receipt": null,
      "paidAmount": 1000.0
    }
  ];

  List<Map<String, dynamic>> get filteredRentCollection {
    List<Map<String, dynamic>> filtered = rentCollection;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((rent) {
        return (rent["tenantName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (rent["propertyName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (rent["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (filterStatus != "all") {
      filtered = filtered.where((rent) => rent["status"] == filterStatus).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "overdue":
        return dangerColor;
      case "partial":
        return warningColor;
      case "pending":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "paid":
        return "Paid";
      case "overdue":
        return "Overdue";
      case "partial":
        return "Partial";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rent Collection"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search rent collection...",
                    value: searchQuery,
                    hint: "Search by tenant, property, or ID",
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

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  "Total Collected",
                  "\$${rentCollection.where((r) => r["status"] == "paid").fold(0.0, (sum, r) => sum + (r["rentAmount"] as double)).toStringAsFixed(0)}",
                  Icons.attach_money,
                  successColor,
                ),
                _buildSummaryCard(
                  "Pending",
                  "\$${rentCollection.where((r) => r["status"] == "pending").fold(0.0, (sum, r) => sum + (r["rentAmount"] as double)).toStringAsFixed(0)}",
                  Icons.hourglass_empty,
                  infoColor,
                ),
                _buildSummaryCard(
                  "Overdue",
                  "\$${rentCollection.where((r) => r["status"] == "overdue").fold(0.0, (sum, r) => sum + (r["rentAmount"] as double)).toStringAsFixed(0)}",
                  Icons.warning,
                  dangerColor,
                ),
                _buildSummaryCard(
                  "Late Fees",
                  "\$${rentCollection.fold(0.0, (sum, r) => sum + (r["lateFee"] as double)).toStringAsFixed(0)}",
                  Icons.money_off,
                  warningColor,
                ),
              ],
            ),

            // Quick Filters
            QCategoryPicker(
              label: "Filter by Status",
              items: const [
                {"label": "All", "value": "all"},
                {"label": "Paid", "value": "paid"},
                {"label": "Pending", "value": "pending"},
                {"label": "Overdue", "value": "overdue"},
                {"label": "Partial", "value": "partial"},
              ],
              value: filterStatus,
              onChanged: (index, label, value, item) {
                filterStatus = value;
                setState(() {});
              },
            ),

            // Rent Collection List
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
                        Icon(Icons.receipt_long, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Rent Collection",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Export",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredRentCollection.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final rent = filteredRentCollection[index];
                      return _buildRentCollectionItem(rent);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRecordPaymentDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRentCollectionItem(Map<String, dynamic> rent) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          // Property Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${rent["propertyImage"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          
          // Rent Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${rent["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(rent["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        _getStatusLabel(rent["status"]),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(rent["status"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${rent["tenantName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${rent["propertyName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.attach_money, size: 16, color: successColor),
                    Text(
                      "\$${(rent["rentAmount"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    if ((rent["lateFee"] as double) > 0) ...[
                      SizedBox(width: spMd),
                      Icon(Icons.warning, size: 16, color: warningColor),
                      Text(
                        "+\$${(rent["lateFee"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Due: ${DateTime.parse(rent["dueDate"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (rent["paidDate"] != null) ...[
                  Text(
                    "Paid: ${DateTime.parse(rent["paidDate"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Action Button
          QButton(
            icon: rent["status"] == "paid" ? Icons.receipt : Icons.payment,
            size: bs.sm,
            onPressed: () {
              if (rent["status"] == "paid") {
                _showReceiptDialog(rent);
              } else {
                _showPaymentDialog(rent);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            // Filter options here
            QButton(
              label: "Apply Filters",
              onPressed: () {
                back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRecordPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Record Payment"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Record a new rent payment"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => back(),
            child: Text("Record"),
          ),
        ],
      ),
    );
  }

  void _showReceiptDialog(Map<String, dynamic> rent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Receipt"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Receipt: ${rent["receipt"]}"),
            Text("Amount: \$${(rent["rentAmount"] as double).toStringAsFixed(0)}"),
            Text("Paid: ${DateTime.parse(rent["paidDate"]).dMMMy}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(Map<String, dynamic> rent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Record Payment"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Record payment for ${rent["tenantName"]}"),
            Text("Amount: \$${(rent["rentAmount"] as double).toStringAsFixed(0)}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => back(),
            child: Text("Record"),
          ),
        ],
      ),
    );
  }
}
