import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaExpenseDetailView extends StatefulWidget {
  const AbaExpenseDetailView({super.key});

  @override
  State<AbaExpenseDetailView> createState() => _AbaExpenseDetailViewState();
}

class _AbaExpenseDetailViewState extends State<AbaExpenseDetailView> {
  Map<String, dynamic>? expenseData;
  List<Map<String, dynamic>> relatedExpenses = [];
  List<Map<String, dynamic>> expenseHistory = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadExpenseDetail();
  }

  Future<void> _loadExpenseDetail() async {
    await Future.delayed(Duration(milliseconds: 800));
    
    expenseData = {
      "id": "EXP-2024-001",
      "title": "Office Supplies & Materials",
      "category": "Office Supplies",
      "categoryColor": primaryColor,
      "amount": 245.67,
      "currency": "USD",
      "date": "2024-03-15",
      "status": "Approved",
      "statusColor": successColor,
      "description": "Purchased sensory toys, worksheets, and office supplies for therapy sessions",
      "vendor": "ABC Educational Supply",
      "paymentMethod": "Credit Card",
      "receipt": "https://picsum.photos/300/400?random=1&keyword=receipt",
      "submittedBy": "Dr. Sarah Johnson",
      "submittedDate": "2024-03-15",
      "approvedBy": "Michael Davis",
      "approvedDate": "2024-03-16",
      "notes": "All items are necessary for upcoming therapy programs",
      "taxAmount": 19.65,
      "subtotal": 226.02,
      "billable": true,
      "clientReference": "Multiple clients",
      "fundingSource": "Insurance - Blue Cross",
      "tags": ["therapy", "supplies", "office"]
    };

    relatedExpenses = [
      {
        "id": "EXP-2024-002",
        "title": "Educational Materials",
        "amount": 89.50,
        "date": "2024-03-12",
        "category": "Office Supplies",
        "status": "Pending"
      },
      {
        "id": "EXP-2024-003",
        "title": "Sensory Equipment",
        "amount": 156.78,
        "date": "2024-03-10",
        "category": "Equipment",
        "status": "Approved"
      },
      {
        "id": "EXP-2024-004",
        "title": "Office Furniture",
        "amount": 445.23,
        "date": "2024-03-08",
        "category": "Office Supplies",
        "status": "Rejected"
      }
    ];

    expenseHistory = [
      {
        "action": "Expense Approved",
        "user": "Michael Davis",
        "date": "2024-03-16 14:30",
        "notes": "Approved for reimbursement"
      },
      {
        "action": "Under Review",
        "user": "System",
        "date": "2024-03-15 16:45",
        "notes": "Submitted for approval"
      },
      {
        "action": "Expense Submitted",
        "user": "Dr. Sarah Johnson",
        "date": "2024-03-15 10:15",
        "notes": "Initial submission with receipt"
      }
    ];

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Expense Details"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // navigateTo(AbaAddExpenseView())
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildExpenseHeader(),
            _buildExpenseDetails(),
            _buildReceiptSection(),
            _buildApprovalInfo(),
            _buildExpenseHistory(),
            _buildRelatedExpenses(),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  Widget _buildExpenseHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: expenseData!["categoryColor"],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${expenseData!["category"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: expenseData!["statusColor"],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${expenseData!["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${expenseData!["title"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "ID: ${expenseData!["id"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "\$${(expenseData!["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${expenseData!["date"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Expense Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildDetailRow("Description", expenseData!["description"]),
          _buildDetailRow("Vendor", expenseData!["vendor"]),
          _buildDetailRow("Payment Method", expenseData!["paymentMethod"]),
          _buildDetailRow("Client Reference", expenseData!["clientReference"]),
          _buildDetailRow("Funding Source", expenseData!["fundingSource"]),
          Divider(),
          Row(
            children: [
              Expanded(
                child: _buildAmountItem("Subtotal", expenseData!["subtotal"]),
              ),
              Expanded(
                child: _buildAmountItem("Tax", expenseData!["taxAmount"]),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Text(
                  "Total Amount",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${(expenseData!["amount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (expenseData!["notes"] != null && expenseData!["notes"].isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notes",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${expenseData!["notes"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildReceiptSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Receipt",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Full",
                size: bs.sm,
                onPressed: () => _viewFullReceipt(),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _viewFullReceipt(),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${expenseData!["receipt"]}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Approval Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildDetailRow("Submitted By", expenseData!["submittedBy"]),
          _buildDetailRow("Submitted Date", expenseData!["submittedDate"]),
          if (expenseData!["approvedBy"] != null)
            _buildDetailRow("Approved By", expenseData!["approvedBy"]),
          if (expenseData!["approvedDate"] != null)
            _buildDetailRow("Approved Date", expenseData!["approvedDate"]),
        ],
      ),
    );
  }

  Widget _buildExpenseHistory() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Activity History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...expenseHistory.map((history) => _buildHistoryItem(history)),
        ],
      ),
    );
  }

  Widget _buildRelatedExpenses() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Related Expenses",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // navigateTo(AbaExpenseListView())
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...relatedExpenses.map((expense) => _buildRelatedExpenseItem(expense)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountItem(String label, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> history) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: primaryColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "${history["action"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${history["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "By: ${history["user"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (history["notes"] != null && history["notes"].isNotEmpty)
            Text(
              "${history["notes"]}",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRelatedExpenseItem(Map<String, dynamic> expense) {
    Color statusColor = expense["status"] == "Approved" 
        ? successColor 
        : expense["status"] == "Pending" 
            ? warningColor 
            : dangerColor;

    return GestureDetector(
      onTap: () {
        // navigateTo(AbaExpenseDetailView())
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(5),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "${expense["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${expense["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(" • ", style: TextStyle(color: disabledBoldColor)),
                      Text(
                        "${expense["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: spXs,
              children: [
                Text(
                  "\$${(expense["amount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${expense["status"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          if (expenseData!["status"] == "Pending")
            Expanded(
              child: QButton(
                label: "Approve",
                onPressed: () => _approveExpense(),
              ),
            ),
          if (expenseData!["status"] == "Pending")
            Expanded(
              child: QButton(
                label: "Reject",
                color: dangerColor,
                onPressed: () => _rejectExpense(),
              ),
            ),
          if (expenseData!["status"] != "Pending")
            Expanded(
              child: QButton(
                label: "Download Receipt",
                onPressed: () => _downloadReceipt(),
              ),
            ),
          Expanded(
            child: QButton(
              label: "Share",
              color: secondaryColor,
              onPressed: () => _shareExpense(),
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: primaryColor),
              title: Text("Edit Expense"),
              onTap: () {
                Navigator.pop(context);
                // navigateTo(AbaAddExpenseView())
              },
            ),
            ListTile(
              leading: Icon(Icons.copy, color: primaryColor),
              title: Text("Duplicate Expense"),
              onTap: () {
                Navigator.pop(context);
                _duplicateExpense();
              },
            ),
            ListTile(
              leading: Icon(Icons.download, color: primaryColor),
              title: Text("Export Details"),
              onTap: () {
                Navigator.pop(context);
                _exportExpense();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Expense"),
              onTap: () {
                Navigator.pop(context);
                _deleteExpense();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewFullReceipt() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Text(
                      "Receipt",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.network(
                  "${expenseData!["receipt"]}",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _approveExpense() async {
    bool isConfirmed = await confirm("Are you sure you want to approve this expense?");
    if (isConfirmed) {
      ss("Expense approved successfully");
      setState(() {
        expenseData!["status"] = "Approved";
        expenseData!["statusColor"] = successColor;
        expenseData!["approvedBy"] = "Michael Davis";
        expenseData!["approvedDate"] = DateTime.now().toString().split(' ')[0];
      });
    }
  }

  void _rejectExpense() async {
    bool isConfirmed = await confirm("Are you sure you want to reject this expense?");
    if (isConfirmed) {
      se("Expense rejected");
      setState(() {
        expenseData!["status"] = "Rejected";
        expenseData!["statusColor"] = dangerColor;
      });
    }
  }

  void _downloadReceipt() {
    ss("Receipt download started");
  }

  void _shareExpense() {
    ss("Expense details shared");
  }

  void _duplicateExpense() {
    ss("Expense duplicated");
    // navigateTo(AbaAddExpenseView())
  }

  void _exportExpense() {
    ss("Expense details exported");
  }

  void _deleteExpense() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this expense? This action cannot be undone.");
    if (isConfirmed) {
      ss("Expense deleted successfully");
      back();
    }
  }
}
