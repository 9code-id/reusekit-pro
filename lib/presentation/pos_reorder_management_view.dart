import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosReorderManagementView extends StatefulWidget {
  const PosReorderManagementView({super.key});

  @override
  State<PosReorderManagementView> createState() => _PosReorderManagementViewState();
}

class _PosReorderManagementViewState extends State<PosReorderManagementView> {
  int currentTab = 0;
  bool loading = false;
  String searchQuery = "";
  String selectedSupplier = "";
  String selectedStatus = "";
  String selectedPriority = "";

  // Form variables for new reorder
  String supplierName = "";
  String productName = "";
  String quantity = "";
  String priority = "Medium";
  String expectedDate = "";
  String notes = "";

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> reorderData = [
    {
      "id": "RO001",
      "supplier": "ABC Supplier",
      "product": "iPhone 15 Pro",
      "currentStock": 2,
      "reorderLevel": 10,
      "suggestedQuantity": 50,
      "priority": "High",
      "status": "Pending",
      "expectedDate": "2024-01-15",
      "notes": "Urgent restock needed",
      "cost": 45000.0,
      "createdAt": "2024-01-10T10:00:00Z",
    },
    {
      "id": "RO002",
      "supplier": "XYZ Electronics",
      "product": "Samsung Galaxy S24",
      "currentStock": 5,
      "reorderLevel": 15,
      "suggestedQuantity": 30,
      "priority": "Medium",
      "status": "Ordered",
      "expectedDate": "2024-01-20",
      "notes": "Regular restocking",
      "cost": 32000.0,
      "createdAt": "2024-01-08T14:30:00Z",
    },
    {
      "id": "RO003",
      "supplier": "Tech Distributors",
      "product": "MacBook Air M2",
      "currentStock": 1,
      "reorderLevel": 5,
      "suggestedQuantity": 10,
      "priority": "High",
      "status": "Received",
      "expectedDate": "2024-01-12",
      "notes": "Partial delivery expected",
      "cost": 95000.0,
      "createdAt": "2024-01-05T09:15:00Z",
    },
    {
      "id": "RO004",
      "supplier": "Mobile Hub",
      "product": "AirPods Pro",
      "currentStock": 8,
      "reorderLevel": 20,
      "suggestedQuantity": 40,
      "priority": "Low",
      "status": "Pending",
      "expectedDate": "2024-01-25",
      "notes": "Seasonal demand increase",
      "cost": 12000.0,
      "createdAt": "2024-01-11T16:45:00Z",
    },
  ];

  List<Map<String, dynamic>> supplierOptions = [
    {"label": "All Suppliers", "value": ""},
    {"label": "ABC Supplier", "value": "ABC Supplier"},
    {"label": "XYZ Electronics", "value": "XYZ Electronics"},
    {"label": "Tech Distributors", "value": "Tech Distributors"},
    {"label": "Mobile Hub", "value": "Mobile Hub"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Pending", "value": "Pending"},
    {"label": "Ordered", "value": "Ordered"},
    {"label": "Received", "value": "Received"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": ""},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> priorityFormOptions = [
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> get filteredReorders {
    return reorderData.where((reorder) {
      final matchesSearch = searchQuery.isEmpty ||
          "${reorder["product"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${reorder["supplier"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${reorder["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesSupplier = selectedSupplier.isEmpty ||
          reorder["supplier"] == selectedSupplier;
      
      final matchesStatus = selectedStatus.isEmpty ||
          reorder["status"] == selectedStatus;
      
      final matchesPriority = selectedPriority.isEmpty ||
          reorder["priority"] == selectedPriority;
      
      return matchesSearch && matchesSupplier && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Ordered":
        return infoColor;
      case "Received":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildReorderOverview() {
    final totalReorders = reorderData.length;
    final pendingReorders = reorderData.where((r) => r["status"] == "Pending").length;
    final orderedReorders = reorderData.where((r) => r["status"] == "Ordered").length;
    final highPriorityReorders = reorderData.where((r) => r["priority"] == "High").length;
    final totalValue = reorderData.fold(0.0, (sum, r) => sum + ((r["cost"] as double) * (r["suggestedQuantity"] as int)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Reorder Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Row(
          spacing: spSm,
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
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.inventory,
                            color: primaryColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Total Reorders",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$totalReorders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.pending,
                            color: warningColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$pendingReorders",
                      style: TextStyle(
                        fontSize: 20,
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
        Row(
          spacing: spSm,
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
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: infoColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Ordered",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$orderedReorders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.priority_high,
                            color: dangerColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "High Priority",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$highPriorityReorders",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.attach_money,
                      color: successColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Total Reorder Value",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Rp ${totalValue.currency}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReorderList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Reorder Management",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QTextField(
                label: "Search reorders...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Supplier",
                      items: supplierOptions,
                      value: selectedSupplier,
                      onChanged: (value, label) {
                        selectedSupplier = value;
                        setState(() {});
                      },
                    ),
                  ),
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
                ],
              ),
              QDropdownField(
                label: "Priority",
                items: priorityOptions,
                value: selectedPriority,
                onChanged: (value, label) {
                  selectedPriority = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        ...filteredReorders.map((reorder) => Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border(
              left: BorderSide(
                width: 4,
                color: _getPriorityColor("${reorder["priority"]}"),
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
                      spacing: spXs,
                      children: [
                        Text(
                          "${reorder["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${reorder["product"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${reorder["supplier"]}",
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
                    spacing: spXs,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${reorder["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${reorder["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor("${reorder["status"]}"),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getPriorityColor("${reorder["priority"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${reorder["priority"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getPriorityColor("${reorder["priority"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Current Stock",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${reorder["currentStock"]} units",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Reorder Level",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${reorder["reorderLevel"]} units",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
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
                            spacing: spXs,
                            children: [
                              Text(
                                "Suggested Qty",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${reorder["suggestedQuantity"]} units",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Expected Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(reorder["expectedDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
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
                            spacing: spXs,
                            children: [
                              Text(
                                "Total Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Rp ${((reorder["cost"] as double) * (reorder["suggestedQuantity"] as int)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Unit Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Rp ${(reorder["cost"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
              if ("${reorder["notes"]}".isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${reorder["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Edit",
                      size: bs.sm,
                      onPressed: () {
                        // Edit reorder logic
                        ss("Reorder updated successfully");
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: reorder["status"] == "Pending" ? "Process" : "View",
                      size: bs.sm,
                      onPressed: () {
                        if (reorder["status"] == "Pending") {
                          ss("Reorder processed successfully");
                        } else {
                          si("Viewing reorder details");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildCreateReorderForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Text(
              "Create New Reorder",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QTextField(
              label: "Supplier Name",
              value: supplierName,
              validator: Validator.required,
              onChanged: (value) {
                supplierName = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Product Name",
              value: productName,
              validator: Validator.required,
              onChanged: (value) {
                productName = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Quantity",
              value: quantity,
              validator: Validator.required,
              onChanged: (value) {
                quantity = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Priority",
              items: priorityFormOptions,
              value: priority,
              onChanged: (value, label) {
                priority = value;
                setState(() {});
              },
            ),
            QDatePicker(
              label: "Expected Delivery Date",
              value: expectedDate.isNotEmpty ? DateTime.parse(expectedDate) : DateTime.now().add(Duration(days: 7)),
              onChanged: (value) {
                expectedDate = value.toIso8601String();
                setState(() {});
              },
            ),
            QMemoField(
              label: "Notes",
              value: notes,
              hint: "Additional notes or requirements",
              onChanged: (value) {
                notes = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Reorder",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    loading = true;
                    setState(() {});
                    
                    await Future.delayed(Duration(seconds: 2));
                    
                    // Add to reorder data
                    reorderData.insert(0, {
                      "id": "RO${(reorderData.length + 1).toString().padLeft(3, '0')}",
                      "supplier": supplierName,
                      "product": productName,
                      "currentStock": 0,
                      "reorderLevel": 10,
                      "suggestedQuantity": int.tryParse(quantity) ?? 0,
                      "priority": priority,
                      "status": "Pending",
                      "expectedDate": expectedDate,
                      "notes": notes,
                      "cost": 25000.0,
                      "createdAt": DateTime.now().toIso8601String(),
                    });
                    
                    // Reset form
                    supplierName = "";
                    productName = "";
                    quantity = "";
                    priority = "Medium";
                    expectedDate = "";
                    notes = "";
                    
                    loading = false;
                    setState(() {});
                    
                    ss("Reorder created successfully");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reorder Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Reorders", icon: Icon(Icons.inventory)),
        Tab(text: "Create", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildReorderOverview(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildReorderList(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCreateReorderForm(),
        ),
      ],
    );
  }
}
