import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaTransactionHistoryView extends StatefulWidget {
  const ReaTransactionHistoryView({super.key});

  @override
  State<ReaTransactionHistoryView> createState() => _ReaTransactionHistoryViewState();
}

class _ReaTransactionHistoryViewState extends State<ReaTransactionHistoryView> {
  String selectedFilter = "All";
  String selectedTimeFrame = "All Time";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Purchase", "value": "Purchase"},
    {"label": "Sale", "value": "Sale"},
    {"label": "Rent", "value": "Rent"},
    {"label": "Lease", "value": "Lease"},
    {"label": "Investment", "value": "Investment"},
  ];

  List<Map<String, dynamic>> timeFrameOptions = [
    {"label": "All Time", "value": "All Time"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last Month", "value": "Last Month"},
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "property_title": "Luxury 3BHK Apartment",
      "property_location": "Downtown Paradise, Mumbai",
      "property_image": "https://picsum.photos/120/120?random=501&keyword=apartment",
      "transaction_type": "Purchase",
      "transaction_amount": 2300000.0,
      "transaction_date": "2024-01-25",
      "completion_date": "2024-03-15",
      "status": "In Progress",
      "buyer_name": "John Doe",
      "seller_name": "Rajesh Kumar",
      "agent_name": "Sarah Wilson",
      "financing_type": "Home Loan",
      "down_payment": 575000.0,
      "loan_amount": 1725000.0,
      "property_type": "Residential",
      "area_sqft": 1200,
      "price_per_sqft": 1916.67,
      "commission_paid": 69000.0,
      "closing_costs": 115000.0,
      "profit_loss": 0.0,
      "roi_percentage": 0.0,
      "milestones": [
        {"status": "Contract Signed", "date": "2024-01-25", "completed": true},
        {"status": "Inspection", "date": "2024-02-01", "completed": true},
        {"status": "Loan Approval", "date": "2024-02-15", "completed": false},
        {"status": "Closing", "date": "2024-03-15", "completed": false},
      ],
    },
    {
      "id": "TXN002",
      "property_title": "Modern 2BHK Villa",
      "property_location": "Green Valley, Pune",
      "property_image": "https://picsum.photos/120/120?random=502&keyword=villa",
      "transaction_type": "Sale",
      "transaction_amount": 1650000.0,
      "transaction_date": "2023-11-20",
      "completion_date": "2023-12-15",
      "status": "Completed",
      "buyer_name": "Michael Chen",
      "seller_name": "John Doe",
      "agent_name": "David Kumar",
      "financing_type": "Cash",
      "down_payment": 1650000.0,
      "loan_amount": 0.0,
      "property_type": "Residential",
      "area_sqft": 950,
      "price_per_sqft": 1736.84,
      "commission_paid": 49500.0,
      "closing_costs": 82500.0,
      "profit_loss": 250000.0,
      "roi_percentage": 17.8,
      "original_purchase_price": 1400000.0,
      "holding_period": "2 years 3 months",
      "milestones": [
        {"status": "Listed", "date": "2023-10-15", "completed": true},
        {"status": "Offer Received", "date": "2023-11-18", "completed": true},
        {"status": "Contract Signed", "date": "2023-11-20", "completed": true},
        {"status": "Closing", "date": "2023-12-15", "completed": true},
      ],
    },
    {
      "id": "TXN003",
      "property_title": "Commercial Office Space",
      "property_location": "Business District, Bangalore",
      "property_image": "https://picsum.photos/120/120?random=503&keyword=office",
      "transaction_type": "Lease",
      "transaction_amount": 180000.0,
      "transaction_date": "2024-01-01",
      "completion_date": "2025-12-31",
      "status": "Active",
      "tenant_name": "TechCorp Solutions",
      "landlord_name": "Commercial Properties Ltd",
      "agent_name": "Priya Sharma",
      "lease_duration": "24 months",
      "monthly_rent": 75000.0,
      "security_deposit": 150000.0,
      "property_type": "Commercial",
      "area_sqft": 2500,
      "rent_per_sqft": 30.0,
      "total_lease_value": 1800000.0,
      "milestones": [
        {"status": "Lease Signed", "date": "2024-01-01", "completed": true},
        {"status": "Security Deposit", "date": "2024-01-01", "completed": true},
        {"status": "Possession", "date": "2024-01-05", "completed": true},
        {"status": "First Rent", "date": "2024-01-31", "completed": true},
      ],
    },
    {
      "id": "TXN004",
      "property_title": "Investment Plot",
      "property_location": "New Town Development, Hyderabad",
      "property_image": "https://picsum.photos/120/120?random=505&keyword=land",
      "transaction_type": "Investment",
      "transaction_amount": 800000.0,
      "transaction_date": "2023-08-15",
      "completion_date": "2023-09-01",
      "status": "Completed",
      "buyer_name": "John Doe",
      "seller_name": "Land Development Corp",
      "agent_name": "Rakesh Gupta",
      "financing_type": "Self-Financed",
      "property_type": "Land",
      "area_sqft": 2000,
      "price_per_sqft": 400.0,
      "current_market_value": 950000.0,
      "profit_loss": 150000.0,
      "roi_percentage": 18.75,
      "appreciation_period": "5 months",
      "milestones": [
        {"status": "Site Visit", "date": "2023-08-10", "completed": true},
        {"status": "Due Diligence", "date": "2023-08-12", "completed": true},
        {"status": "Payment", "date": "2023-08-15", "completed": true},
        {"status": "Registration", "date": "2023-09-01", "completed": true},
      ],
    },
    {
      "id": "TXN005",
      "property_title": "Studio Apartment",
      "property_location": "Metro Central, Delhi",
      "property_image": "https://picsum.photos/120/120?random=506&keyword=studio",
      "transaction_type": "Rent",
      "transaction_amount": 25000.0,
      "transaction_date": "2024-01-10",
      "completion_date": "2025-01-09",
      "status": "Active",
      "tenant_name": "John Doe",
      "landlord_name": "Urban Living Properties",
      "agent_name": "Neha Verma",
      "lease_duration": "12 months",
      "monthly_rent": 25000.0,
      "security_deposit": 50000.0,
      "property_type": "Residential",
      "area_sqft": 600,
      "rent_per_sqft": 41.67,
      "amenities_included": ["Gym", "Parking", "Security"],
      "milestones": [
        {"status": "Application", "date": "2024-01-08", "completed": true},
        {"status": "Approval", "date": "2024-01-09", "completed": true},
        {"status": "Lease Signed", "date": "2024-01-10", "completed": true},
        {"status": "Move In", "date": "2024-01-15", "completed": true},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = transactions.where((txn) {
      final typeMatch = selectedFilter == "All" || txn["transaction_type"] == selectedFilter;
      final searchMatch = searchQuery.isEmpty || 
          txn["property_title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          txn["property_location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return typeMatch && searchMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _showExportOptions();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              _showAnalytics();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: QTextField(
              label: "Search transactions...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),

          // Filters
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Frame",
                    items: timeFrameOptions,
                    value: selectedTimeFrame,
                    onChanged: (value, label) {
                      selectedTimeFrame = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Summary Stats
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${transactions.length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Transactions",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "₹${((transactions.fold(0.0, (sum, txn) => sum + (txn["transaction_amount"] as double))) / 100000).toStringAsFixed(1)}L",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Total Value",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${transactions.where((t) => t["status"] == "Completed").length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Completed",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "₹${((transactions.where((t) => t["profit_loss"] != null && (t["profit_loss"] as double) > 0).fold(0.0, (sum, t) => sum + (t["profit_loss"] as double))) / 100000).toStringAsFixed(1)}L",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Total Profit",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${((transactions.where((t) => t["roi_percentage"] != null && (t["roi_percentage"] as double) > 0).fold(0.0, (sum, t) => sum + (t["roi_percentage"] as double))) / transactions.where((t) => t["roi_percentage"] != null && (t["roi_percentage"] as double) > 0).length).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Avg ROI",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${transactions.where((t) => t["status"] == "Active").length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Active",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
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

          SizedBox(height: spMd),

          // Transactions List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Transaction Header
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${transaction["property_image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${transaction["property_title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${transaction["property_location"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${transaction["transaction_type"]} • ${transaction["id"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(transaction["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${transaction["status"]}",
                                  style: TextStyle(
                                    color: _getStatusColor(transaction["status"]),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getTransactionTypeColor(transaction["transaction_type"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${transaction["transaction_type"]}",
                                  style: TextStyle(
                                    color: _getTransactionTypeColor(transaction["transaction_type"]),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Financial Summary
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _getAmountLabel(transaction["transaction_type"]),
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "₹${((transaction["transaction_amount"] as double) / 100000).toStringAsFixed(1)}L",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (transaction["profit_loss"] != null && (transaction["profit_loss"] as double) != 0) ...[
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (transaction["profit_loss"] as double) > 0 ? "Profit:" : "Loss:",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "₹${((transaction["profit_loss"] as double).abs() / 100000).toStringAsFixed(1)}L",
                                    style: TextStyle(
                                      color: (transaction["profit_loss"] as double) > 0 ? successColor : dangerColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (transaction["roi_percentage"] != null && (transaction["roi_percentage"] as double) != 0) ...[
                              SizedBox(height: spXs),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ROI:",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "${(transaction["roi_percentage"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      color: (transaction["roi_percentage"] as double) > 0 ? successColor : dangerColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Property Details
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Area",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${transaction["area_sqft"]} sq ft",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
                                  "Date",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${transaction["transaction_date"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
                                  _getPricePerSqftLabel(transaction["transaction_type"]),
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "₹${_getPricePerSqft(transaction).toStringAsFixed(0)}/sq ft",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              icon: Icons.visibility,
                              size: bs.sm,
                              onPressed: () {
                                _showTransactionDetails(transaction);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Documents",
                              icon: Icons.folder,
                              size: bs.sm,
                              onPressed: () {
                                si("Opening transaction documents...");
                              },
                            ),
                          ),
                          if (transaction["status"] == "In Progress") ...[
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Track",
                                icon: Icons.timeline,
                                size: bs.sm,
                                onPressed: () {
                                  _showProgressTracking(transaction);
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Active":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTransactionTypeColor(String type) {
    switch (type) {
      case "Purchase":
        return infoColor;
      case "Sale":
        return successColor;
      case "Rent":
        return warningColor;
      case "Lease":
        return primaryColor;
      case "Investment":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getAmountLabel(String type) {
    switch (type) {
      case "Purchase":
        return "Purchase Price:";
      case "Sale":
        return "Sale Price:";
      case "Rent":
        return "Monthly Rent:";
      case "Lease":
        return "Monthly Lease:";
      case "Investment":
        return "Investment Amount:";
      default:
        return "Amount:";
    }
  }

  String _getPricePerSqftLabel(String type) {
    switch (type) {
      case "Rent":
      case "Lease":
        return "Rent/sq ft";
      default:
        return "Price/sq ft";
    }
  }

  double _getPricePerSqft(Map<String, dynamic> transaction) {
    if (transaction["rent_per_sqft"] != null) {
      return transaction["rent_per_sqft"] as double;
    } else if (transaction["price_per_sqft"] != null) {
      return transaction["price_per_sqft"] as double;
    } else {
      return (transaction["transaction_amount"] as double) / (transaction["area_sqft"] as int);
    }
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.6,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Transaction Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => back(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      // Transaction overview content would go here
                      _buildDetailSection("Property Information", [
                        _buildDetailRow("Title", "${transaction["property_title"]}"),
                        _buildDetailRow("Location", "${transaction["property_location"]}"),
                        _buildDetailRow("Type", "${transaction["property_type"]}"),
                        _buildDetailRow("Area", "${transaction["area_sqft"]} sq ft"),
                      ]),
                      
                      _buildDetailSection("Transaction Details", [
                        _buildDetailRow("Type", "${transaction["transaction_type"]}"),
                        _buildDetailRow("Amount", "₹${((transaction["transaction_amount"] as double) / 100000).toStringAsFixed(1)}L"),
                        _buildDetailRow("Date", "${transaction["transaction_date"]}"),
                        _buildDetailRow("Status", "${transaction["status"]}"),
                      ]),

                      if (transaction["buyer_name"] != null) ...[
                        _buildDetailSection("Parties Involved", [
                          if (transaction["buyer_name"] != null) 
                            _buildDetailRow("Buyer", "${transaction["buyer_name"]}"),
                          if (transaction["seller_name"] != null) 
                            _buildDetailRow("Seller", "${transaction["seller_name"]}"),
                          if (transaction["tenant_name"] != null) 
                            _buildDetailRow("Tenant", "${transaction["tenant_name"]}"),
                          if (transaction["landlord_name"] != null) 
                            _buildDetailRow("Landlord", "${transaction["landlord_name"]}"),
                          if (transaction["agent_name"] != null) 
                            _buildDetailRow("Agent", "${transaction["agent_name"]}"),
                        ]),
                      ],

                      if (transaction["financing_type"] != null) ...[
                        _buildDetailSection("Financial Details", [
                          _buildDetailRow("Financing Type", "${transaction["financing_type"]}"),
                          if (transaction["down_payment"] != null) 
                            _buildDetailRow("Down Payment", "₹${((transaction["down_payment"] as double) / 100000).toStringAsFixed(1)}L"),
                          if (transaction["loan_amount"] != null && (transaction["loan_amount"] as double) > 0) 
                            _buildDetailRow("Loan Amount", "₹${((transaction["loan_amount"] as double) / 100000).toStringAsFixed(1)}L"),
                          if (transaction["monthly_rent"] != null) 
                            _buildDetailRow("Monthly Rent", "₹${((transaction["monthly_rent"] as double) / 1000).toStringAsFixed(1)}K"),
                          if (transaction["security_deposit"] != null) 
                            _buildDetailRow("Security Deposit", "₹${((transaction["security_deposit"] as double) / 1000).toStringAsFixed(1)}K"),
                        ]),
                      ],

                      if (transaction["profit_loss"] != null && (transaction["profit_loss"] as double) != 0) ...[
                        _buildDetailSection("Investment Performance", [
                          _buildDetailRow("Profit/Loss", "₹${((transaction["profit_loss"] as double).abs() / 100000).toStringAsFixed(1)}L"),
                          if (transaction["roi_percentage"] != null) 
                            _buildDetailRow("ROI", "${(transaction["roi_percentage"] as double).toStringAsFixed(1)}%"),
                          if (transaction["holding_period"] != null) 
                            _buildDetailRow("Holding Period", "${transaction["holding_period"]}"),
                          if (transaction["appreciation_period"] != null) 
                            _buildDetailRow("Appreciation Period", "${transaction["appreciation_period"]}"),
                        ]),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showProgressTracking(Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Progress Tracking",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => back(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.all(spMd),
                  itemCount: (transaction["milestones"] as List).length,
                  itemBuilder: (context, index) {
                    final milestone = (transaction["milestones"] as List)[index];
                    final isCompleted = milestone["completed"] as bool;
                    final isLast = index == (transaction["milestones"] as List).length - 1;
                    
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted ? successColor : disabledColor,
                              ),
                              child: Icon(
                                isCompleted ? Icons.check : Icons.schedule,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            if (!isLast) ...[
                              Container(
                                width: 2,
                                height: 40,
                                color: isCompleted ? successColor : disabledColor,
                              ),
                            ],
                          ],
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${milestone["status"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${milestone["date"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              if (!isLast) SizedBox(height: spMd),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExportOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Export Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QButton(
              label: "Export to PDF",
              icon: Icons.picture_as_pdf,
              size: bs.sm,
              onPressed: () {
                back();
                si("Exporting to PDF...");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Export to Excel",
              icon: Icons.table_chart,
              size: bs.sm,
              onPressed: () {
                back();
                si("Exporting to Excel...");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Email Report",
              icon: Icons.email,
              size: bs.sm,
              onPressed: () {
                back();
                si("Sending email report...");
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showAnalytics() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Transaction Analytics"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Advanced analytics features:"),
            SizedBox(height: spMd),
            QButton(
              label: "Portfolio Performance",
              icon: Icons.trending_up,
              size: bs.sm,
              onPressed: () {
                back();
                si("Opening portfolio analytics...");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Market Comparison",
              icon: Icons.compare_arrows,
              size: bs.sm,
              onPressed: () {
                back();
                si("Opening market comparison...");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Tax Report",
              icon: Icons.receipt_long,
              size: bs.sm,
              onPressed: () {
                back();
                si("Generating tax report...");
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
