import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmTicketCategoriesView extends StatefulWidget {
  const CrmTicketCategoriesView({super.key});

  @override
  State<CrmTicketCategoriesView> createState() => _CrmTicketCategoriesViewState();
}

class _CrmTicketCategoriesViewState extends State<CrmTicketCategoriesView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  String categoryName = "";
  String categoryDescription = "";
  String selectedParentCategory = "";
  String selectedIcon = "folder";
  String selectedColor = "blue";
  bool isActive = true;
  bool allowSubCategories = true;
  bool requireApproval = false;

  final List<Map<String, dynamic>> categories = [
    {
      "id": "1",
      "name": "Technical Issues",
      "description": "Hardware, software, and system-related problems",
      "icon": "bug_report",
      "color": "red",
      "status": "Active",
      "type": "Main Category",
      "parentId": null,
      "ticketCount": 245,
      "avgResolutionTime": "2.5 hours",
      "priority": "High",
      "assignedAgents": ["Sarah Wilson", "Mike Brown"],
      "subCategories": [
        {
          "id": "1a",
          "name": "Hardware Issues",
          "ticketCount": 89,
          "avgResolutionTime": "3.2 hours"
        },
        {
          "id": "1b", 
          "name": "Software Bugs",
          "ticketCount": 156,
          "avgResolutionTime": "2.1 hours"
        }
      ],
      "createdAt": "2024-01-15",
      "updatedAt": "2024-03-10"
    },
    {
      "id": "2",
      "name": "Account Issues",
      "description": "Login, password, and account management problems",
      "icon": "account_circle",
      "color": "blue",
      "status": "Active",
      "type": "Main Category",
      "parentId": null,
      "ticketCount": 189,
      "avgResolutionTime": "1.8 hours",
      "priority": "Medium",
      "assignedAgents": ["Lisa Chen", "David Kim"],
      "subCategories": [
        {
          "id": "2a",
          "name": "Password Reset",
          "ticketCount": 123,
          "avgResolutionTime": "0.5 hours"
        },
        {
          "id": "2b",
          "name": "Account Verification",
          "ticketCount": 66,
          "avgResolutionTime": "3.1 hours"
        }
      ],
      "createdAt": "2024-01-10",
      "updatedAt": "2024-03-12"
    },
    {
      "id": "3",
      "name": "Billing & Payments",
      "description": "Payment processing, invoicing, and billing inquiries",
      "icon": "payment",
      "color": "green",
      "status": "Active",
      "type": "Main Category",
      "parentId": null,
      "ticketCount": 134,
      "avgResolutionTime": "2.2 hours",
      "priority": "High",
      "assignedAgents": ["Emma Davis", "John Smith"],
      "subCategories": [
        {
          "id": "3a",
          "name": "Payment Failed",
          "ticketCount": 78,
          "avgResolutionTime": "1.5 hours"
        },
        {
          "id": "3b",
          "name": "Refund Requests",
          "ticketCount": 56,
          "avgResolutionTime": "2.9 hours"
        }
      ],
      "createdAt": "2024-01-05",
      "updatedAt": "2024-03-08"
    },
    {
      "id": "4",
      "name": "Feature Requests",
      "description": "New feature suggestions and enhancement requests",
      "icon": "lightbulb",
      "color": "orange",
      "status": "Active",
      "type": "Main Category",
      "parentId": null,
      "ticketCount": 67,
      "avgResolutionTime": "5.2 hours",
      "priority": "Low",
      "assignedAgents": ["Alex Johnson"],
      "subCategories": [
        {
          "id": "4a",
          "name": "UI Improvements",
          "ticketCount": 34,
          "avgResolutionTime": "4.8 hours"
        },
        {
          "id": "4b",
          "name": "New Features",
          "ticketCount": 33,
          "avgResolutionTime": "5.6 hours"
        }
      ],
      "createdAt": "2024-02-01",
      "updatedAt": "2024-03-05"
    },
    {
      "id": "5",
      "name": "General Inquiry",
      "description": "General questions and information requests",
      "icon": "help",
      "color": "purple",
      "status": "Active",
      "type": "Main Category",
      "parentId": null,
      "ticketCount": 98,
      "avgResolutionTime": "1.2 hours",
      "priority": "Low",
      "assignedAgents": ["Maria Garcia", "Tom Wilson"],
      "subCategories": [
        {
          "id": "5a",
          "name": "Product Information",
          "ticketCount": 56,
          "avgResolutionTime": "0.8 hours"
        },
        {
          "id": "5b",
          "name": "Documentation",
          "ticketCount": 42,
          "avgResolutionTime": "1.6 hours"
        }
      ],
      "createdAt": "2024-01-20",
      "updatedAt": "2024-03-01"
    },
    {
      "id": "6",
      "name": "Security Issues",
      "description": "Security concerns and vulnerability reports",
      "icon": "security",
      "color": "red",
      "status": "Inactive",
      "type": "Main Category",
      "parentId": null,
      "ticketCount": 23,
      "avgResolutionTime": "4.1 hours",
      "priority": "Critical",
      "assignedAgents": ["Sarah Wilson"],
      "subCategories": [],
      "createdAt": "2024-02-15",
      "updatedAt": "2024-03-14"
    }
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"}
  ];

  final List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Main Category", "value": "main"},
    {"label": "Sub Category", "value": "sub"}
  ];

  final List<Map<String, dynamic>> iconOptions = [
    {"label": "Folder", "value": "folder"},
    {"label": "Bug Report", "value": "bug_report"},
    {"label": "Account Circle", "value": "account_circle"},
    {"label": "Payment", "value": "payment"},
    {"label": "Lightbulb", "value": "lightbulb"},
    {"label": "Help", "value": "help"},
    {"label": "Security", "value": "security"},
    {"label": "Settings", "value": "settings"},
    {"label": "Support", "value": "support_agent"}
  ];

  final List<Map<String, dynamic>> colorOptions = [
    {"label": "Blue", "value": "blue"},
    {"label": "Red", "value": "red"},
    {"label": "Green", "value": "green"},
    {"label": "Orange", "value": "orange"},
    {"label": "Purple", "value": "purple"},
    {"label": "Teal", "value": "teal"}
  ];

  final List<Map<String, dynamic>> parentCategoryOptions = [
    {"label": "No Parent (Main Category)", "value": ""},
    {"label": "Technical Issues", "value": "1"},
    {"label": "Account Issues", "value": "2"},
    {"label": "Billing & Payments", "value": "3"},
    {"label": "Feature Requests", "value": "4"},
    {"label": "General Inquiry", "value": "5"}
  ];

  List<Map<String, dynamic>> get filteredCategories {
    return categories.where((category) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${category["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${category["description"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "all" ||
          "${category["status"]}".toLowerCase() == selectedStatus;

      bool matchesType = selectedType == "all" ||
          (selectedType == "main" && category["parentId"] == null) ||
          (selectedType == "sub" && category["parentId"] != null);

      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color _getCategoryColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return dangerColor;
      case 'blue':
        return infoColor;
      case 'green':
        return successColor;
      case 'orange':
        return warningColor;
      case 'purple':
        return primaryColor;
      case 'teal':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'folder':
        return Icons.folder;
      case 'bug_report':
        return Icons.bug_report;
      case 'account_circle':
        return Icons.account_circle;
      case 'payment':
        return Icons.payment;
      case 'lightbulb':
        return Icons.lightbulb;
      case 'help':
        return Icons.help;
      case 'security':
        return Icons.security;
      case 'settings':
        return Icons.settings;
      case 'support_agent':
        return Icons.support_agent;
      default:
        return Icons.folder;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _showCreateCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Create New Category",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      QTextField(
                        label: "Category Name",
                        value: categoryName,
                        hint: "Enter category name",
                        validator: Validator.required,
                        onChanged: (value) {
                          categoryName = value;
                          setState(() {});
                        },
                      ),
                      QMemoField(
                        label: "Description",
                        value: categoryDescription,
                        hint: "Describe what types of tickets belong to this category",
                        maxLines: 3,
                        validator: Validator.required,
                        onChanged: (value) {
                          categoryDescription = value;
                          setState(() {});
                        },
                      ),
                      QDropdownField(
                        label: "Parent Category",
                        items: parentCategoryOptions,
                        value: selectedParentCategory,
                        onChanged: (value, label) {
                          selectedParentCategory = value;
                          setState(() {});
                        },
                      ),
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "Icon",
                              items: iconOptions,
                              value: selectedIcon,
                              onChanged: (value, label) {
                                selectedIcon = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: QDropdownField(
                              label: "Color",
                              items: colorOptions,
                              value: selectedColor,
                              onChanged: (value, label) {
                                selectedColor = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(selectedColor).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: _getCategoryColor(selectedColor).withAlpha(50)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(selectedColor).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                _getCategoryIcon(selectedIcon),
                                color: _getCategoryColor(selectedColor),
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Preview",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getCategoryColor(selectedColor),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    categoryName.isEmpty ? "Category Name" : categoryName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: _getCategoryColor(selectedColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Category Settings",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            QSwitch(
                              items: [
                                {
                                  "label": "Active Category",
                                  "value": true,
                                  "checked": isActive,
                                }
                              ],
                              value: [
                                if (isActive)
                                  {
                                    "label": "Active Category",
                                    "value": true,
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                isActive = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                            QSwitch(
                              items: [
                                {
                                  "label": "Allow Sub-Categories",
                                  "value": true,
                                  "checked": allowSubCategories,
                                }
                              ],
                              value: [
                                if (allowSubCategories)
                                  {
                                    "label": "Allow Sub-Categories",
                                    "value": true,
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                allowSubCategories = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                            QSwitch(
                              items: [
                                {
                                  "label": "Require Approval for Tickets",
                                  "value": true,
                                  "checked": requireApproval,
                                }
                              ],
                              value: [
                                if (requireApproval)
                                  {
                                    "label": "Require Approval for Tickets",
                                    "value": true,
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                requireApproval = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: disabledOutlineBorderColor),
                  ),
                ),
                child: Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Cancel",
                        color: disabledColor,
                        size: bs.md,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Create Category",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                          ss("Category created successfully");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCategoryDetails(Map<String, dynamic> category) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: _getCategoryColor("${category["color"]}"),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getCategoryIcon("${category["icon"]}"),
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${category["name"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${category["type"]}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${category["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ResponsiveGridView(
                        padding: EdgeInsets.all(spSm),
                        minItemWidth: 200,
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Tickets",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${category["ticketCount"]}",
                                  style: TextStyle(
                                    fontSize: 24,
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
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Avg Resolution Time",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${category["avgResolutionTime"]}",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Priority Level",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getPriorityColor("${category["priority"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor("${category["priority"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${category["priority"]} Priority",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _getPriorityColor("${category["priority"]}"),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if ((category["assignedAgents"] as List).isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Assigned Agents",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...(category["assignedAgents"] as List).map((agent) {
                              return Container(
                                padding: EdgeInsets.all(spSm),
                                margin: EdgeInsets.only(bottom: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${agent}".substring(0, 1).toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "$agent",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      if ((category["subCategories"] as List).isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "Sub-Categories",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...(category["subCategories"] as List).map((subCategory) {
                              return Container(
                                padding: EdgeInsets.all(spSm),
                                margin: EdgeInsets.only(bottom: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.subdirectory_arrow_right,
                                        color: warningColor,
                                        size: 16,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${subCategory["name"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "${subCategory["ticketCount"]} tickets • ${subCategory["avgResolutionTime"]} avg",
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
                              );
                            }).toList(),
                          ],
                        ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Category Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Created: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${category["createdAt"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Updated: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${category["updatedAt"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: disabledOutlineBorderColor),
                  ),
                ),
                child: Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Edit Category",
                        color: infoColor,
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                          si("Editing category");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "View Tickets",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                          si("Viewing category tickets");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Ticket Categories",
      selectedIndex: 0,
      tabs: [
        Tab(text: "All Categories", icon: Icon(Icons.category)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        // All Categories Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
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
                    QTextField(
                      label: "Search Categories",
                      value: searchQuery,
                      hint: "Search by name or description",
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
                            label: "Status",
                            items: statusOptions,
                            value: selectedStatus,
                            onChanged: (value, label) {
                              selectedStatus = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Type",
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
              Row(
                children: [
                  Icon(
                    Icons.category,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Categories (${filteredCategories.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Create Category",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: _showCreateCategoryDialog,
                  ),
                ],
              ),
              ResponsiveGridView(
                padding: EdgeInsets.all(spSm),
                minItemWidth: 200,
                children: filteredCategories.map((category) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getCategoryColor("${category["color"]}"),
                        ),
                      ),
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
                                color: _getCategoryColor("${category["color"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                _getCategoryIcon("${category["icon"]}"),
                                color: _getCategoryColor("${category["color"]}"),
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${category["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: category["status"] == "Active"
                                          ? successColor.withAlpha(20)
                                          : disabledColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${category["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: category["status"] == "Active"
                                            ? successColor
                                            : disabledBoldColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${category["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.confirmation_number,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${category["ticketCount"]} Tickets",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${category["priority"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${category["priority"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getPriorityColor("${category["priority"]}"),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Avg: ${category["avgResolutionTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if ((category["subCategories"] as List).isNotEmpty)
                                    Text(
                                      "${(category["subCategories"] as List).length} Sub-categories",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                color: infoColor,
                                size: bs.sm,
                                onPressed: () => _showCategoryDetails(category),
                              ),
                            ),
                            Expanded(
                              child: QButton(
                                label: "View Tickets",
                                size: bs.sm,
                                onPressed: () {
                                  si("Viewing tickets for ${category["name"]}");
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        // Analytics Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Category Analytics",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.all(spSm),
                minItemWidth: 200,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.category,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Categories",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${categories.length}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${categories.where((c) => c["status"] == "Active").length} active categories",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.confirmation_number,
                                color: successColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Tickets",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${categories.fold(0, (sum, cat) => sum + (cat["ticketCount"] as int))}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Across all categories",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.subdirectory_arrow_right,
                                color: warningColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sub-Categories",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${categories.fold(0, (sum, cat) => sum + (cat["subCategories"] as List).length)}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Nested categories",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
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
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.access_time,
                                color: infoColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Avg Resolution",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "2.4 hrs",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Overall average",
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
              Container(
                padding: EdgeInsets.all(spSm),
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
                      "Category Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...categories.take(5).map((category) {
                      int totalTickets = categories.fold(0, (sum, cat) => sum + (cat["ticketCount"] as int));
                      double percentage = ((category["ticketCount"] as int) / totalTickets * 100);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: _getCategoryColor("${category["color"]}").withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor("${category["color"]}").withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    _getCategoryIcon("${category["icon"]}"),
                                    color: _getCategoryColor("${category["color"]}"),
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${category["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${category["ticketCount"]} tickets",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getCategoryColor("${category["color"]}"),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: percentage / 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _getCategoryColor("${category["color"]}"),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${percentage.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getCategoryColor("${category["color"]}"),
                                    fontWeight: FontWeight.bold,
                                  ),
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
        // Settings Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Category Settings",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
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
                      "General Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Auto-assign categories based on keywords",
                          "value": true,
                          "checked": true,
                        }
                      ],
                      value: [
                        {
                          "label": "Auto-assign categories based on keywords",
                          "value": true,
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {},
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow customers to select categories",
                          "value": true,
                          "checked": false,
                        }
                      ],
                      value: [],
                      onChanged: (values, ids) {},
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Require category approval for new tickets",
                          "value": true,
                          "checked": false,
                        }
                      ],
                      value: [],
                      onChanged: (values, ids) {},
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
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
                      "Default Category Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QDropdownField(
                      label: "Default Category for Unassigned Tickets",
                      items: [
                        {"label": "General Inquiry", "value": "5"},
                        {"label": "Technical Issues", "value": "1"},
                        {"label": "Account Issues", "value": "2"}
                      ],
                      value: "5",
                      onChanged: (value, label) {},
                    ),
                    QDropdownField(
                      label: "Default Priority Level",
                      items: [
                        {"label": "Low", "value": "low"},
                        {"label": "Medium", "value": "medium"},
                        {"label": "High", "value": "high"}
                      ],
                      value: "medium",
                      onChanged: (value, label) {},
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
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
                      "Category Management",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Export Categories",
                            icon: Icons.download,
                            color: infoColor,
                            size: bs.sm,
                            onPressed: () {
                              si("Exporting categories");
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Import Categories",
                            icon: Icons.upload,
                            color: warningColor,
                            size: bs.sm,
                            onPressed: () {
                              sw("Import feature coming soon");
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Reset All Categories",
                        icon: Icons.refresh,
                        color: dangerColor,
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Are you sure you want to reset all categories? This action cannot be undone.");
                          if (isConfirmed) {
                            sw("Reset operation cancelled for safety");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
