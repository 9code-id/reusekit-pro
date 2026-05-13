import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmProjectBudgetView extends StatefulWidget {
  const TpmProjectBudgetView({super.key});

  @override
  State<TpmProjectBudgetView> createState() => _TpmProjectBudgetViewState();
}

class _TpmProjectBudgetViewState extends State<TpmProjectBudgetView> {
  String selectedProject = "Mobile App Development";
  String selectedCategory = "All Categories";
  String selectedPeriod = "Current Quarter";
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> projects = [
    {"label": "Mobile App Development", "value": "Mobile App Development"},
    {"label": "Website Redesign", "value": "Website Redesign"},
    {"label": "Marketing Campaign", "value": "Marketing Campaign"},
    {"label": "Cloud Migration", "value": "Cloud Migration"},
    {"label": "AI Integration", "value": "AI Integration"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Personnel", "value": "Personnel"},
    {"label": "Equipment", "value": "Equipment"},
    {"label": "Software", "value": "Software"},
    {"label": "External Services", "value": "External Services"},
    {"label": "Travel", "value": "Travel"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Current Quarter", "value": "Current Quarter"},
    {"label": "Last Quarter", "value": "Last Quarter"},
    {"label": "Year to Date", "value": "Year to Date"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  Map<String, dynamic> projectDetails = {
    "name": "Mobile App Development",
    "status": "In Progress",
    "manager": "Sarah Johnson",
    "startDate": "2024-01-15",
    "endDate": "2024-06-30",
    "progress": 65,
    "totalBudget": 150000,
    "spentAmount": 87500,
    "remainingBudget": 62500,
    "utilization": 58.3,
    "lastUpdated": "2024-03-15",
  };

  List<Map<String, dynamic>> budgetBreakdown = [
    {
      "category": "Personnel",
      "budgeted": 80000,
      "spent": 52000,
      "remaining": 28000,
      "utilization": 65.0,
      "color": Colors.blue,
      "items": 12,
    },
    {
      "category": "Equipment",
      "budgeted": 25000,
      "spent": 18500,
      "remaining": 6500,
      "utilization": 74.0,
      "color": Colors.green,
      "items": 8,
    },
    {
      "category": "Software",
      "budgeted": 20000,
      "spent": 15000,
      "remaining": 5000,
      "utilization": 75.0,
      "color": Colors.purple,
      "items": 6,
    },
    {
      "category": "External Services",
      "budgeted": 15000,
      "spent": 2000,
      "remaining": 13000,
      "utilization": 13.3,
      "color": Colors.orange,
      "items": 3,
    },
    {
      "category": "Travel",
      "budgeted": 10000,
      "spent": 0,
      "remaining": 10000,
      "utilization": 0.0,
      "color": Colors.teal,
      "items": 0,
    },
  ];

  List<Map<String, dynamic>> budgetHistory = [
    {
      "date": "2024-03-15",
      "description": "Frontend Developer - Week 11",
      "category": "Personnel",
      "amount": 3200,
      "type": "Expense",
      "approvedBy": "Sarah Johnson",
      "status": "Approved",
    },
    {
      "date": "2024-03-14",
      "description": "Cloud Server Hosting",
      "category": "Software",
      "amount": 450,
      "type": "Expense",
      "approvedBy": "Tech Lead",
      "status": "Approved",
    },
    {
      "date": "2024-03-13",
      "description": "Testing Device Purchase",
      "category": "Equipment",
      "amount": 1200,
      "type": "Expense",
      "approvedBy": "Sarah Johnson",
      "status": "Pending",
    },
    {
      "date": "2024-03-12",
      "description": "UI/UX Consulting",
      "category": "External Services",
      "amount": 2000,
      "type": "Allocation",
      "approvedBy": "Project Manager",
      "status": "Approved",
    },
  ];

  List<Map<String, dynamic>> forecastData = [
    {
      "month": "March 2024",
      "budgeted": 25000,
      "projected": 22000,
      "actual": 18500,
      "variance": -3500,
    },
    {
      "month": "April 2024",
      "budgeted": 30000,
      "projected": 28000,
      "actual": 0,
      "variance": 0,
    },
    {
      "month": "May 2024",
      "budgeted": 35000,
      "projected": 32000,
      "actual": 0,
      "variance": 0,
    },
    {
      "month": "June 2024",
      "budgeted": 25000,
      "projected": 23000,
      "actual": 0,
      "variance": 0,
    },
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "name": "MVP Release",
      "date": "2024-04-15",
      "budget": 45000,
      "spent": 38000,
      "status": "On Track",
      "progress": 85,
    },
    {
      "name": "Beta Testing",
      "date": "2024-05-30",
      "budget": 25000,
      "spent": 12000,
      "status": "Scheduled",
      "progress": 48,
    },
    {
      "name": "Production Launch",
      "date": "2024-06-30",
      "budget": 30000,
      "spent": 5000,
      "status": "Planned",
      "progress": 17,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'on track':
        return Colors.green;
      case 'at risk':
        return Colors.orange;
      case 'delayed':
        return Colors.red;
      case 'scheduled':
        return Colors.blue;
      case 'planned':
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildProjectHeader() {
    double progress = projectDetails["progress"] as double;
    double utilization = projectDetails["utilization"] as double;
    
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${projectDetails["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Manager: ${projectDetails["manager"]}",
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
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor("${projectDetails["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${projectDetails["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${projectDetails["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Budget",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((projectDetails["totalBudget"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                      "Spent",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((projectDetails["spentAmount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
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
                      "Remaining",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((projectDetails["remainingBudget"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Project Progress",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${progress.toInt()}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Budget Utilization",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${utilization.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: utilization / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetBredownCard(Map<String, dynamic> category) {
    double utilization = category["utilization"] as double;
    
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
          Row(
            children: [
              Container(
                width: 4,
                height: 30,
                decoration: BoxDecoration(
                  color: category["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${category["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${category["items"]} items",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budgeted",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((category["budgeted"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
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
                  children: [
                    Text(
                      "Spent",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((category["spent"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
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
                      "Remaining",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((category["remaining"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Utilization",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${utilization.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: utilization / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: category["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    bool isExpense = item["type"] == "Expense";
    
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isExpense 
                  ? Colors.red.withAlpha(20)
                  : Colors.blue.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              isExpense ? Icons.remove : Icons.add,
              color: isExpense ? Colors.red : Colors.blue,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["category"]} • Approved by ${item["approvedBy"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["date"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isExpense ? '-' : '+'}\$${((item["amount"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isExpense ? Colors.red : Colors.green,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor("${item["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${item["status"]}"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard(Map<String, dynamic> milestone) {
    double progress = milestone["progress"] as double;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
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
              Expanded(
                child: Text(
                  "${milestone["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor("${milestone["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${milestone["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${milestone["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${milestone["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((milestone["budget"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
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
                  children: [
                    Text(
                      "Spent",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((milestone["spent"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
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
                      "Progress",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${progress.toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: _getStatusColor("${milestone["status"]}"),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Header
          _buildProjectHeader(),
          
          SizedBox(height: spLg),
          
          // Budget Breakdown
          Text(
            "Budget Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...budgetBreakdown.map((category) {
            return Column(
              children: [
                _buildBudgetBredownCard(category),
                SizedBox(height: spSm),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search transactions...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Transaction History
          Text(
            "Transaction History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...budgetHistory.map((item) {
            return _buildHistoryItem(item);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMilestonesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Project Milestones",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...milestones.map((milestone) {
            return _buildMilestoneCard(milestone);
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Project Budget",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Transactions", icon: Icon(Icons.receipt)),
        Tab(text: "Milestones", icon: Icon(Icons.flag)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTransactionsTab(),
        _buildMilestonesTab(),
      ],
      actions: [
        QButton(
          icon: Icons.edit,
          size: bs.sm,
          onPressed: () {},
        ),
      ],
    );
  }
}
