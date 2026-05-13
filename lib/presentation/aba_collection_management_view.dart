import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCollectionManagementView extends StatefulWidget {
  const AbaCollectionManagementView({super.key});

  @override
  State<AbaCollectionManagementView> createState() => _AbaCollectionManagementViewState();
}

class _AbaCollectionManagementViewState extends State<AbaCollectionManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedAge = "All";
  bool loading = false;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "New", "value": "New"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "On Hold", "value": "On Hold"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Write Off", "value": "Write Off"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> ageItems = [
    {"label": "All", "value": "All"},
    {"label": "0-30 Days", "value": "0-30"},
    {"label": "31-60 Days", "value": "31-60"},
    {"label": "61-90 Days", "value": "61-90"},
    {"label": "90+ Days", "value": "90+"},
  ];

  List<Map<String, dynamic>> collections = [
    {
      "id": "COL001",
      "customer_name": "Metro Construction Ltd",
      "customer_phone": "+1-555-0123",
      "customer_email": "billing@metroconstruction.com",
      "original_amount": 15000.00,
      "outstanding_amount": 12500.00,
      "invoice_number": "INV-2023-245",
      "due_date": "2023-11-15",
      "days_overdue": 65,
      "status": "In Progress",
      "priority": "High",
      "assigned_to": "John Smith",
      "last_contact": "2024-01-15",
      "next_action": "Phone call scheduled",
      "notes": "Customer promised payment by end of month",
    },
    {
      "id": "COL002",
      "customer_name": "TechStart Solutions",
      "customer_phone": "+1-555-0456",
      "customer_email": "accounts@techstart.com",
      "original_amount": 3200.00,
      "outstanding_amount": 3200.00,
      "invoice_number": "INV-2023-567",
      "due_date": "2023-12-01",
      "days_overdue": 49,
      "status": "New",
      "priority": "Medium",
      "assigned_to": "Sarah Johnson",
      "last_contact": null,
      "next_action": "Initial contact required",
      "notes": "First time overdue customer",
    },
    {
      "id": "COL003",
      "customer_name": "Global Retail Inc",
      "customer_phone": "+1-555-0789",
      "customer_email": "finance@globalretail.com",
      "original_amount": 8750.00,
      "outstanding_amount": 2750.00,
      "invoice_number": "INV-2023-123",
      "due_date": "2023-10-30",
      "days_overdue": 81,
      "status": "On Hold",
      "priority": "Critical",
      "assigned_to": "Mike Chen",
      "last_contact": "2024-01-10",
      "next_action": "Legal review pending",
      "notes": "Dispute over service quality, partial payment received",
    },
    {
      "id": "COL004",
      "customer_name": "Local Services Co",
      "customer_phone": "+1-555-0321",
      "customer_email": "admin@localservices.com",
      "original_amount": 1250.00,
      "outstanding_amount": 0.00,
      "invoice_number": "INV-2023-789",
      "due_date": "2023-12-15",
      "days_overdue": 35,
      "status": "Resolved",
      "priority": "Low",
      "assigned_to": "Lisa Wong",
      "last_contact": "2024-01-18",
      "next_action": "Case closed",
      "notes": "Full payment received after negotiation",
    },
    {
      "id": "COL005",
      "customer_name": "StartUp Ventures",
      "customer_phone": "+1-555-0654",
      "customer_email": "billing@startupventures.com",
      "original_amount": 950.00,
      "outstanding_amount": 950.00,
      "invoice_number": "INV-2023-456",
      "due_date": "2023-09-20",
      "days_overdue": 125,
      "status": "Write Off",
      "priority": "Low",
      "assigned_to": "David Brown",
      "last_contact": "2024-01-05",
      "next_action": "Written off as bad debt",
      "notes": "Company dissolved, unable to collect",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "New":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "On Hold":
        return secondaryColor;
      case "Resolved":
        return successColor;
      case "Write Off":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildSummaryCard() {
    return Container(
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
            "Collection Summary",
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
                child: _buildSummaryItem("Total Cases", "156", primaryColor),
              ),
              Expanded(
                child: _buildSummaryItem("Active", "89", warningColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Outstanding", "\$245K", dangerColor),
              ),
              Expanded(
                child: _buildSummaryItem("Collected", "\$89K", successColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
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
            "Filter Collections",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Search collections...",
            value: searchQuery,
            hint: "Customer name, invoice, or case ID",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
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
                  label: "Priority",
                  items: priorityItems,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Age Range",
            items: ageItems,
            value: selectedAge,
            onChanged: (value, label) {
              selectedAge = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionCard(Map<String, dynamic> collection) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(collection["priority"]),
          ),
        ),
      ),
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
                      "${collection["customer_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${collection["invoice_number"]} • ${collection["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(collection["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getStatusColor(collection["status"]).withAlpha(100),
                  ),
                ),
                child: Text(
                  "${collection["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(collection["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: dangerColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: dangerColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${collection["days_overdue"]} days overdue",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Due: ${collection["due_date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                  ),
                ),
              ],
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
                      "Outstanding",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(collection["outstanding_amount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
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
                      "Original",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(collection["original_amount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(collection["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${collection["priority"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(collection["priority"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Assigned to: ${collection["assigned_to"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Next Action: ${collection["next_action"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          if (collection["notes"] != null) ...[
            SizedBox(height: spXs),
            Text(
              "Notes: ${collection["notes"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Contact",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Update",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collection Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCard(),
                  SizedBox(height: spMd),
                  _buildFilterSection(),
                  SizedBox(height: spMd),
                  Text(
                    "Collection Cases",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...collections.map((collection) => _buildCollectionCard(collection)).toList(),
                ],
              ),
            ),
    );
  }
}
