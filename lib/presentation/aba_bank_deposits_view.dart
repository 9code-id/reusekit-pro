import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaBankDepositsView extends StatefulWidget {
  const AbaBankDepositsView({super.key});

  @override
  State<AbaBankDepositsView> createState() => _AbaBankDepositsViewState();
}

class _AbaBankDepositsViewState extends State<AbaBankDepositsView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedBank = "all";
  DateTime? fromDate;
  DateTime? toDate;
  bool loading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Processing", "value": "processing"},
    {"label": "Completed", "value": "completed"},
    {"label": "Failed", "value": "failed"},
    {"label": "Rejected", "value": "rejected"},
  ];

  List<Map<String, dynamic>> bankOptions = [
    {"label": "All Banks", "value": "all"},
    {"label": "Chase Bank", "value": "chase"},
    {"label": "Bank of America", "value": "boa"},
    {"label": "Wells Fargo", "value": "wells_fargo"},
    {"label": "Citibank", "value": "citibank"},
    {"label": "PNC Bank", "value": "pnc"},
  ];

  List<Map<String, dynamic>> deposits = [
    {
      "id": "DEP-001",
      "batch_id": "BATCH-20240619-001",
      "deposit_date": "2024-06-19",
      "bank_name": "Chase Bank",
      "account_number": "****7890",
      "total_amount": 15750.50,
      "payment_count": 12,
      "status": "completed",
      "processing_time": "14:30:25",
      "completion_time": "16:45:10",
      "transaction_fee": 47.25,
      "net_amount": 15703.25,
      "reference_number": "CHB123456789",
      "deposit_type": "ACH Batch",
    },
    {
      "id": "DEP-002",
      "batch_id": "BATCH-20240619-002",
      "deposit_date": "2024-06-19",
      "bank_name": "Bank of America",
      "account_number": "****1234",
      "total_amount": 8920.75,
      "payment_count": 8,
      "status": "processing",
      "processing_time": "15:15:40",
      "completion_time": "",
      "transaction_fee": 26.76,
      "net_amount": 8893.99,
      "reference_number": "BOA987654321",
      "deposit_type": "Wire Transfer",
    },
    {
      "id": "DEP-003",
      "batch_id": "BATCH-20240618-003",
      "deposit_date": "2024-06-18",
      "bank_name": "Wells Fargo",
      "account_number": "****5678",
      "total_amount": 22100.00,
      "payment_count": 15,
      "status": "failed",
      "processing_time": "13:20:15",
      "completion_time": "",
      "transaction_fee": 66.30,
      "net_amount": 22033.70,
      "reference_number": "WF456789123",
      "deposit_type": "ACH Batch",
      "failure_reason": "Invalid account details",
    },
    {
      "id": "DEP-004",
      "batch_id": "BATCH-20240618-004",
      "deposit_date": "2024-06-18",
      "bank_name": "Citibank",
      "account_number": "****9012",
      "total_amount": 5680.25,
      "payment_count": 6,
      "status": "pending",
      "processing_time": "",
      "completion_time": "",
      "transaction_fee": 17.04,
      "net_amount": 5663.21,
      "reference_number": "CITI789123456",
      "deposit_type": "Same Day ACH",
    },
    {
      "id": "DEP-005",
      "batch_id": "BATCH-20240617-005",
      "deposit_date": "2024-06-17",
      "bank_name": "PNC Bank",
      "account_number": "****3456",
      "total_amount": 12450.80,
      "payment_count": 10,
      "status": "rejected",
      "processing_time": "11:45:30",
      "completion_time": "",
      "transaction_fee": 37.35,
      "net_amount": 12413.45,
      "reference_number": "PNC123789456",
      "deposit_type": "ACH Batch",
      "rejection_reason": "Account temporarily frozen",
    },
  ];

  List<Map<String, dynamic>> get filteredDeposits {
    return deposits.where((deposit) {
      final matchesSearch = deposit["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          deposit["batch_id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          deposit["reference_number"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "all" || deposit["status"] == selectedStatus;
      final matchesBank = selectedBank == "all" || 
          deposit["bank_name"].toString().toLowerCase().contains(selectedBank.replaceAll("_", " "));
      
      return matchesSearch && matchesStatus && matchesBank;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'processing':
        return infoColor;
      case 'pending':
        return warningColor;
      case 'failed':
      case 'rejected':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'processing':
        return Icons.sync;
      case 'pending':
        return Icons.schedule;
      case 'failed':
      case 'rejected':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  void _retryDeposit(Map<String, dynamic> deposit) async {
    bool isConfirmed = await confirm("Retry deposit ${deposit["id"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Deposit retry initiated");
  }

  void _cancelDeposit(Map<String, dynamic> deposit) async {
    bool isConfirmed = await confirm("Cancel deposit ${deposit["id"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    sw("Deposit cancelled");
  }

  void _exportDeposits() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Deposit report exported successfully");
  }

  void _createNewDeposit() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("New deposit batch created");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Deposits"),
        actions: [
          IconButton(
            onPressed: _exportDeposits,
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: _createNewDeposit,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                              Icon(Icons.account_balance, color: primaryColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "Total Deposits",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((deposits.fold(0.0, (sum, deposit) => sum + (deposit["total_amount"] as double)))).currency}",
                            style: TextStyle(
                              fontSize: fsH5,
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
                              Icon(Icons.check_circle, color: successColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${deposits.where((d) => d["status"] == "completed").length}",
                            style: TextStyle(
                              fontSize: fsH5,
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
                              Icon(Icons.sync, color: infoColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "Processing",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${deposits.where((d) => d["status"] == "processing").length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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
                              Icon(Icons.error, color: dangerColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "Failed/Rejected",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${deposits.where((d) => d["status"] == "failed" || d["status"] == "rejected").length}",
                            style: TextStyle(
                              fontSize: fsH5,
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

              // Search and Filters
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
                            label: "Search deposits...",
                            value: searchQuery,
                            hint: "Deposit ID, batch ID, or reference number",
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
                            label: "Status",
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
                            label: "Bank",
                            items: bankOptions,
                            value: selectedBank,
                            onChanged: (value, label) {
                              selectedBank = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Deposits List
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Deposit Records",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${filteredDeposits.length} deposits",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1),
                    ...List.generate(filteredDeposits.length, (index) {
                      final deposit = filteredDeposits[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: index < filteredDeposits.length - 1 
                                ? disabledOutlineBorderColor 
                                : Colors.transparent,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _getStatusIcon("${deposit["status"]}"),
                                  color: _getStatusColor("${deposit["status"]}"),
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${deposit["id"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${deposit["batch_id"]} • ${deposit["deposit_type"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${deposit["status"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${deposit["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusColor("${deposit["status"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${(deposit["total_amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${deposit["payment_count"]} payments",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${deposit["bank_name"]} ${deposit["account_number"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Fee: \$${(deposit["transaction_fee"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Net: \$${(deposit["net_amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Ref: ${deposit["reference_number"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date: ${deposit["deposit_date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (deposit["processing_time"] != "")
                                  Text(
                                    "Started: ${deposit["processing_time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                            if (deposit["completion_time"] != "")
                              Text(
                                "Completed: ${deposit["completion_time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            if (deposit.containsKey("failure_reason"))
                              Text(
                                "Failure: ${deposit["failure_reason"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            if (deposit.containsKey("rejection_reason"))
                              Text(
                                "Rejected: ${deposit["rejection_reason"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Deposit details viewed");
                                  },
                                ),
                                if (deposit["status"] == "failed" || deposit["status"] == "rejected")
                                  ...[
                                    SizedBox(width: spXs),
                                    QButton(
                                      label: "Retry",
                                      size: bs.sm,
                                      onPressed: () => _retryDeposit(deposit),
                                    ),
                                  ],
                                if (deposit["status"] == "pending" || deposit["status"] == "processing")
                                  ...[
                                    SizedBox(width: spXs),
                                    QButton(
                                      label: "Cancel",
                                      size: bs.sm,
                                      onPressed: () => _cancelDeposit(deposit),
                                    ),
                                  ],
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
