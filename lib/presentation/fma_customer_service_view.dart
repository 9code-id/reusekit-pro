import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaCustomerServiceView extends StatefulWidget {
  const FmaCustomerServiceView({super.key});

  @override
  State<FmaCustomerServiceView> createState() => _FmaCustomerServiceViewState();
}

class _FmaCustomerServiceViewState extends State<FmaCustomerServiceView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPriority = "all";

  List<Map<String, dynamic>> tickets = [
    {
      "id": "CS001",
      "customer": "John Smith",
      "subject": "Order Delay Issue",
      "priority": "High",
      "status": "Open",
      "category": "Delivery",
      "created_at": "2024-06-19 10:30",
      "response_time": "2 hours",
      "agent": "Sarah Wilson",
      "description": "Customer complaining about delayed food delivery"
    },
    {
      "id": "CS002", 
      "customer": "Emily Davis",
      "subject": "Food Quality Concern",
      "priority": "Medium",
      "status": "In Progress",
      "category": "Quality",
      "created_at": "2024-06-19 09:15",
      "response_time": "1 hour",
      "agent": "Mike Johnson",
      "description": "Customer received cold food"
    },
    {
      "id": "CS003",
      "customer": "Robert Brown",
      "subject": "Billing Inquiry",
      "priority": "Low",
      "status": "Resolved",
      "category": "Payment",
      "created_at": "2024-06-18 16:45",
      "response_time": "30 mins",
      "agent": "Lisa Chen",
      "description": "Question about payment charges"
    },
    {
      "id": "CS004",
      "customer": "Anna Wilson",
      "subject": "Menu Information",
      "priority": "Low",
      "status": "Open",
      "category": "General",
      "created_at": "2024-06-19 14:20",
      "response_time": "1 hour",
      "agent": "Unassigned",
      "description": "Inquiry about allergen information"
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Open", "value": "Open"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priority", "value": "all"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Service",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Tickets", icon: Icon(Icons.support_agent)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Quick Actions", icon: Icon(Icons.flash_on)),
      ],
      tabChildren: [
        _buildTicketsTab(),
        _buildAnalyticsTab(),
        _buildQuickActionsTab(),
      ],
    );
  }

  Widget _buildTicketsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildTicketsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search tickets...",
                value: searchQuery,
                hint: "Search by customer, subject, or ticket ID",
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
          spacing: spSm,
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
      ],
    );
  }

  Widget _buildTicketsList() {
    return Column(
      spacing: spSm,
      children: tickets.map((ticket) => _buildTicketCard(ticket)).toList(),
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket) {
    Color statusColor = _getStatusColor("${ticket["status"]}");
    Color priorityColor = _getPriorityColor("${ticket["priority"]}");

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${ticket["id"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${ticket["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${ticket["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "${ticket["subject"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${ticket["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${ticket["customer"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${ticket["created_at"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${ticket["category"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              Spacer(),
              Text(
                "Agent: ${ticket["agent"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: ticket["agent"] == "Unassigned" ? warningColor : disabledBoldColor,
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
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Respond",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.support_agent, color: primaryColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "24",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Open Tickets",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.schedule, color: warningColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "1.2h",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Avg Response",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "95%",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Satisfaction",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_up, color: infoColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "156",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Resolved Today",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                _buildCategoryItem("Delivery Issues", 42, dangerColor),
                _buildCategoryItem("Food Quality", 28, warningColor),
                _buildCategoryItem("Payment", 18, infoColor),
                _buildCategoryItem("General Inquiry", 12, successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category, int percentage, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              category,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Text(
            "$percentage%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Quick Response Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTemplateItem("Order Status Update", "Provide order tracking information"),
                _buildTemplateItem("Delivery Delay Apology", "Apologize for delayed delivery"),
                _buildTemplateItem("Quality Issue Resolution", "Address food quality concerns"),
                _buildTemplateItem("Refund Process", "Explain refund procedure"),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Escalation Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildActionItem(
                  "Escalate to Manager",
                  "For high priority issues",
                  Icons.arrow_upward,
                  dangerColor,
                ),
                _buildActionItem(
                  "Transfer to Specialist",
                  "For technical problems",
                  Icons.transfer_within_a_station,
                  warningColor,
                ),
                _buildActionItem(
                  "Schedule Callback",
                  "For complex issues",
                  Icons.phone_callback,
                  infoColor,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Customer Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildActionItem(
                  "Send Coupon",
                  "10% discount for next order",
                  Icons.local_offer,
                  successColor,
                ),
                _buildActionItem(
                  "Free Delivery",
                  "Complimentary delivery voucher",
                  Icons.delivery_dining,
                  primaryColor,
                ),
                _buildActionItem(
                  "Priority Support",
                  "Add to VIP customer list",
                  Icons.star,
                  warningColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(String title, String description) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Use",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.arrow_forward,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return dangerColor;
      case "In Progress":
        return warningColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
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
        return primaryColor;
    }
  }
}
