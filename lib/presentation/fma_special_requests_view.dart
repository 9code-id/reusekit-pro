import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaSpecialRequestsView extends StatefulWidget {
  const FmaSpecialRequestsView({super.key});

  @override
  State<FmaSpecialRequestsView> createState() => _FmaSpecialRequestsViewState();
}

class _FmaSpecialRequestsViewState extends State<FmaSpecialRequestsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedType = "all";
  String selectedStatus = "all";

  List<Map<String, dynamic>> requests = [
    {
      "id": "SR001",
      "customer": "Emma Thompson",
      "type": "Dietary Restriction",
      "status": "In Progress",
      "priority": "High",
      "request_date": "2024-06-19 09:30",
      "expected_date": "2024-06-19 20:30",
      "description": "Gluten-free pasta with extra vegetables, no dairy products",
      "special_instructions": "Customer has severe celiac disease, requires separate cooking utensils",
      "additional_cost": 5.50,
      "estimated_time": "45 minutes",
      "chef_assigned": "Marco Rodriguez",
      "ingredients_available": true,
      "approval_required": false,
      "customer_rating": 5,
      "complexity": "Medium"
    },
    {
      "id": "SR002",
      "customer": "James Wilson",
      "type": "Custom Order",
      "status": "Pending Approval",
      "priority": "Medium",
      "request_date": "2024-06-19 11:15",
      "expected_date": "2024-06-20 12:00",
      "description": "Birthday cake with custom decorations and message",
      "special_instructions": "Blue frosting with 'Happy 5th Birthday Alex' in yellow letters",
      "additional_cost": 25.00,
      "estimated_time": "2 hours",
      "chef_assigned": "Sarah Chen",
      "ingredients_available": false,
      "approval_required": true,
      "customer_rating": 0,
      "complexity": "High"
    },
    {
      "id": "SR003",
      "customer": "Maria Garcia",
      "type": "Preparation Method",
      "status": "Completed",
      "priority": "Low",
      "request_date": "2024-06-18 16:20",
      "expected_date": "2024-06-18 19:30",
      "description": "Steak cooked medium-rare with garlic butter sauce on the side",
      "special_instructions": "Temperature must be exactly 135°F, sauce served separately",
      "additional_cost": 3.00,
      "estimated_time": "25 minutes",
      "chef_assigned": "David Kim",
      "ingredients_available": true,
      "approval_required": false,
      "customer_rating": 4,
      "complexity": "Low"
    },
    {
      "id": "SR004",
      "customer": "Robert Johnson",
      "type": "Allergen Modification",
      "status": "Under Review",
      "priority": "High",
      "request_date": "2024-06-19 14:45",
      "expected_date": "2024-06-19 19:00",
      "description": "Seafood paella without shellfish, extra chicken and vegetables",
      "special_instructions": "No cross-contamination with shellfish, use separate pans",
      "additional_cost": 8.00,
      "estimated_time": "50 minutes",
      "chef_assigned": "Isabella Martinez",
      "ingredients_available": true,
      "approval_required": true,
      "customer_rating": 0,
      "complexity": "High"
    },
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "all"},
    {"label": "Dietary Restriction", "value": "Dietary Restriction"},
    {"label": "Custom Order", "value": "Custom Order"},
    {"label": "Preparation Method", "value": "Preparation Method"},
    {"label": "Allergen Modification", "value": "Allergen Modification"},
    {"label": "Portion Size", "value": "Portion Size"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending Approval", "value": "Pending Approval"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Special Requests",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Guidelines", icon: Icon(Icons.rule)),
      ],
      tabChildren: [
        _buildRequestsTab(),
        _buildAnalyticsTab(),
        _buildGuidelinesTab(),
      ],
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildRequestsList(),
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
                label: "Search requests...",
                value: searchQuery,
                hint: "Search by customer, type, or request ID",
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
                label: "Type",
                items: typeItems,
                value: selectedType,
                onChanged: (value, label) {
                  selectedType = value;
                  setState(() {});
                },
              ),
            ),
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
          ],
        ),
      ],
    );
  }

  Widget _buildRequestsList() {
    return Column(
      spacing: spSm,
      children: requests.map((request) => _buildRequestCard(request)).toList(),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    Color statusColor = _getStatusColor("${request["status"]}");
    Color priorityColor = _getPriorityColor("${request["priority"]}");
    Color complexityColor = _getComplexityColor("${request["complexity"]}");
    double additionalCost = request["additional_cost"] as double;
    int rating = request["customer_rating"] as int;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${request["id"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${request["type"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
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
                      "${request["priority"]}",
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
                      "${request["status"]}",
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
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${request["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${request["special_instructions"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${request["customer"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              Spacer(),
              if (rating > 0)
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      size: 12,
                      color: index < rating ? warningColor : disabledColor,
                    );
                  }),
                ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Est. ${request["estimated_time"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: complexityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${request["complexity"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: complexityColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person_outline, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Chef: ${request["chef_assigned"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              if (additionalCost > 0)
                Text(
                  "+\$${additionalCost.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Due: ${request["expected_date"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Row(
                spacing: spXs,
                children: [
                  if (request["ingredients_available"] as bool)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, size: 10, color: successColor),
                          SizedBox(width: 2),
                          Text(
                            "Available",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.close, size: 10, color: dangerColor),
                          SizedBox(width: 2),
                          Text(
                            "Missing",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (request["approval_required"] as bool)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.approval, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Text(
                    "Manager approval required",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
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
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              if (request["status"] == "Pending Approval")
                Expanded(
                  child: QButton(
                    label: "Approve",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              if (request["status"] == "Under Review")
                Expanded(
                  child: QButton(
                    label: "Start",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Requests", "89", Icons.restaurant_menu, primaryColor),
              _buildMetricCard("Pending", "15", Icons.pending, warningColor),
              _buildMetricCard("Avg Cost", "\$12.30", Icons.attach_money, infoColor),
              _buildMetricCard("Success Rate", "96%", Icons.check_circle, successColor),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Request Types",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildTypeItem("Dietary Restriction", 32, dangerColor),
                      _buildTypeItem("Custom Order", 28, warningColor),
                      _buildTypeItem("Preparation Method", 22, infoColor),
                      _buildTypeItem("Allergen Modification", 18, primaryColor),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Complexity Breakdown",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildComplexityItem("Low", 45, successColor),
                      _buildComplexityItem("Medium", 35, warningColor),
                      _buildComplexityItem("High", 20, dangerColor),
                    ],
                  ),
                ),
              ),
            ],
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
                  "Top Chefs by Special Requests",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildChefItem("Marco Rodriguez", 24, 4.8, primaryColor),
                _buildChefItem("Sarah Chen", 18, 4.6, infoColor),
                _buildChefItem("Isabella Martinez", 16, 4.9, successColor),
                _buildChefItem("David Kim", 12, 4.7, warningColor),
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
                  "Average Processing Time",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildProcessingTimeItem("< 30 minutes", 38, successColor),
                _buildProcessingTimeItem("30-60 minutes", 42, infoColor),
                _buildProcessingTimeItem("1-2 hours", 18, warningColor),
                _buildProcessingTimeItem("> 2 hours", 2, dangerColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
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

  Widget _buildTypeItem(String type, int percentage, Color color) {
    return Row(
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
          child: Text(type, style: TextStyle(fontSize: 14)),
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
    );
  }

  Widget _buildComplexityItem(String complexity, int percentage, Color color) {
    return Row(
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
          child: Text(complexity, style: TextStyle(fontSize: 14)),
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
    );
  }

  Widget _buildChefItem(String chef, int requests, double rating, Color color) {
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
            child: Icon(Icons.person, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chef,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "$requests requests",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: warningColor),
              SizedBox(width: 2),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingTimeItem(String timeframe, int percentage, Color color) {
    return Row(
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
          child: Text(timeframe, style: TextStyle(fontSize: 14)),
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
    );
  }

  Widget _buildGuidelinesTab() {
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
                  "Request Handling Process",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildProcessStep(1, "Receive Request", "Customer submits special request with details"),
                _buildProcessStep(2, "Review Feasibility", "Check ingredients, equipment, and chef availability"),
                _buildProcessStep(3, "Cost Assessment", "Calculate additional costs and time requirements"),
                _buildProcessStep(4, "Approval Process", "Manager approval for complex or costly requests"),
                _buildProcessStep(5, "Chef Assignment", "Assign to qualified chef based on expertise"),
                _buildProcessStep(6, "Preparation", "Execute request according to specifications"),
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
                  "Approval Thresholds",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildThresholdItem("Auto-approve", "< \$5", "Simple modifications", successColor),
                _buildThresholdItem("Supervisor", "\$5 - \$15", "Medium complexity", warningColor),
                _buildThresholdItem("Manager", "\$15 - \$50", "High complexity", infoColor),
                _buildThresholdItem("Director", "> \$50", "Custom creations", dangerColor),
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
                  "Special Dietary Requirements",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildDietaryItem("Gluten-Free", "Separate utensils and preparation area", Icons.no_food, dangerColor),
                _buildDietaryItem("Vegan/Vegetarian", "No animal products, check all ingredients", Icons.eco, successColor),
                _buildDietaryItem("Nut Allergy", "Strict no-contact policy, emergency protocols", Icons.warning, warningColor),
                _buildDietaryItem("Halal/Kosher", "Certified ingredients and preparation methods", Icons.dining, infoColor),
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
                  "Quality Standards",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildQualityItem("Ingredient Freshness", "All ingredients must be within expiration dates"),
                _buildQualityItem("Temperature Control", "Maintain proper temperatures throughout preparation"),
                _buildQualityItem("Cross-Contamination", "Prevent contact between allergens and safe foods"),
                _buildQualityItem("Presentation", "Special requests should meet standard presentation quality"),
                _buildQualityItem("Documentation", "Record all modifications for quality control"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessStep(int step, String title, String description) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Center(
            child: Text(
              "$step",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
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
      ],
    );
  }

  Widget _buildThresholdItem(String level, String amount, String description, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: color.withAlpha(50)),
        borderRadius: BorderRadius.circular(radiusXs),
        color: color.withAlpha(10),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      level,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Spacer(),
                    Text(
                      amount,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
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
        ],
      ),
    );
  }

  Widget _buildDietaryItem(String type, String requirements, IconData icon, Color color) {
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
                  type,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  requirements,
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
  }

  Widget _buildQualityItem(String standard, String description) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: successColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  standard,
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
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending Approval":
        return warningColor;
      case "Under Review":
        return infoColor;
      case "In Progress":
        return primaryColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
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

  Color _getComplexityColor(String complexity) {
    switch (complexity) {
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
