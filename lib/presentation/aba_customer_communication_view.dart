import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCustomerCommunicationView extends StatefulWidget {
  const AbaCustomerCommunicationView({super.key});

  @override
  State<AbaCustomerCommunicationView> createState() => _AbaCustomerCommunicationViewState();
}

class _AbaCustomerCommunicationViewState extends State<AbaCustomerCommunicationView> {
  String searchQuery = "";
  String selectedType = "all";
  String selectedStatus = "all";
  String selectedCustomer = "all";
  bool loading = false;
  int currentTab = 0;

  // Compose Communication
  String selectedTemplate = "";
  String recipientType = "individual";
  String selectedRecipient = "";
  String subject = "";
  String message = "";

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Email", "value": "email"},
    {"label": "SMS", "value": "sms"},
    {"label": "Letter", "value": "letter"},
    {"label": "Phone Call", "value": "phone"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Sent", "value": "sent"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Read", "value": "read"},
    {"label": "Failed", "value": "failed"},
    {"label": "Pending", "value": "pending"},
  ];

  List<Map<String, dynamic>> customerOptions = [
    {"label": "All Customers", "value": "all"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Brown", "value": "michael_brown"},
    {"label": "Emily Davis", "value": "emily_davis"},
  ];

  List<Map<String, dynamic>> templateOptions = [
    {"label": "Payment Reminder", "value": "payment_reminder"},
    {"label": "Invoice Notification", "value": "invoice_notification"},
    {"label": "Account Statement", "value": "account_statement"},
    {"label": "Credit Limit Update", "value": "credit_limit_update"},
    {"label": "Welcome Message", "value": "welcome_message"},
    {"label": "Custom Message", "value": "custom"},
  ];

  List<Map<String, dynamic>> recipientTypeOptions = [
    {"label": "Individual Customer", "value": "individual"},
    {"label": "Customer Group", "value": "group"},
    {"label": "All Customers", "value": "all_customers"},
    {"label": "Overdue Customers", "value": "overdue"},
  ];

  List<Map<String, dynamic>> communications = [
    {
      "id": "COMM-001",
      "customer_name": "John Smith",
      "customer_id": "CUST-001",
      "type": "email",
      "subject": "Payment Reminder - Invoice INV-2024-001",
      "content": "Dear John, this is a friendly reminder that your payment of \$1,250.00 is due.",
      "status": "delivered",
      "sent_date": "2024-06-19",
      "delivery_date": "2024-06-19",
      "read_date": "2024-06-19",
      "template_used": "payment_reminder",
      "sender": "system",
    },
    {
      "id": "COMM-002",
      "customer_name": "Sarah Johnson",
      "customer_id": "CUST-002",
      "type": "sms",
      "subject": "Invoice Notification",
      "content": "Hi Sarah, your new invoice INV-2024-002 for \$890.50 is ready for payment.",
      "status": "read",
      "sent_date": "2024-06-18",
      "delivery_date": "2024-06-18",
      "read_date": "2024-06-18",
      "template_used": "invoice_notification",
      "sender": "admin",
    },
    {
      "id": "COMM-003",
      "customer_name": "Michael Brown",
      "customer_id": "CUST-003",
      "type": "phone",
      "subject": "Follow-up Call - Overdue Payment",
      "content": "Called to discuss overdue payment of \$2,100.75. Customer promised payment by end of week.",
      "status": "completed",
      "sent_date": "2024-06-17",
      "delivery_date": "2024-06-17",
      "read_date": "",
      "template_used": "custom",
      "sender": "collections_team",
    },
    {
      "id": "COMM-004",
      "customer_name": "Emily Davis",
      "customer_id": "CUST-004",
      "type": "email",
      "subject": "Account Statement - May 2024",
      "content": "Please find attached your account statement for May 2024.",
      "status": "sent",
      "sent_date": "2024-06-16",
      "delivery_date": "",
      "read_date": "",
      "template_used": "account_statement",
      "sender": "system",
    },
    {
      "id": "COMM-005",
      "customer_name": "David Wilson",
      "customer_id": "CUST-005",
      "type": "letter",
      "subject": "Final Notice - Account Suspension",
      "content": "This is a final notice regarding your overdue account balance of \$3,200.00.",
      "status": "failed",
      "sent_date": "2024-06-15",
      "delivery_date": "",
      "read_date": "",
      "template_used": "custom",
      "sender": "collections_team",
    },
  ];

  List<Map<String, dynamic>> get filteredCommunications {
    return communications.where((comm) {
      final matchesSearch = comm["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          comm["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          comm["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesType = selectedType == "all" || comm["type"] == selectedType;
      final matchesStatus = selectedStatus == "all" || comm["status"] == selectedStatus;
      final matchesCustomer = selectedCustomer == "all" || 
          comm["customer_name"].toString().toLowerCase().contains(selectedCustomer.replaceAll("_", " "));
      
      return matchesSearch && matchesType && matchesStatus && matchesCustomer;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
      case 'read':
      case 'completed':
        return successColor;
      case 'sent':
      case 'pending':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'email':
        return Icons.email;
      case 'sms':
        return Icons.sms;
      case 'letter':
        return Icons.mail;
      case 'phone':
        return Icons.phone;
      default:
        return Icons.message;
    }
  }

  void _sendCommunication() async {
    if (subject.isEmpty || message.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    bool isConfirmed = await confirm("Send communication to selected recipients?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    // Clear form
    selectedTemplate = "";
    recipientType = "individual";
    selectedRecipient = "";
    subject = "";
    message = "";
    setState(() {});
    
    ss("Communication sent successfully");
  }

  void _resendCommunication(Map<String, dynamic> comm) async {
    bool isConfirmed = await confirm("Resend communication to ${comm["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Communication resent successfully");
  }

  Widget _buildHistoryTab() {
    return Column(
      spacing: spMd,
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
                    Text(
                      "Total Sent",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${communications.length}",
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
                    Text(
                      "Delivered",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${communications.where((c) => c["status"] == "delivered" || c["status"] == "read").length}",
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
                      label: "Search communications...",
                      value: searchQuery,
                      hint: "Customer name, subject, or ID",
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
                      label: "Type",
                      items: typeOptions,
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
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
            ],
          ),
        ),

        // Communications List
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
                      "Communication History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${filteredCommunications.length} records",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              ...List.generate(filteredCommunications.length, (index) {
                final comm = filteredCommunications[index];
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: index < filteredCommunications.length - 1 
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
                            _getTypeIcon("${comm["type"]}"),
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${comm["customer_name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${comm["id"]} • ${comm["type"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${comm["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${comm["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor("${comm["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${comm["subject"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${comm["content"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sent: ${comm["sent_date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (comm["read_date"] != "")
                            Text(
                              "Read: ${comm["read_date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              si("Communication details viewed");
                            },
                          ),
                          if (comm["status"] == "failed")
                            ...[
                              SizedBox(width: spXs),
                              QButton(
                                label: "Resend",
                                size: bs.sm,
                                onPressed: () => _resendCommunication(comm),
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
    );
  }

  Widget _buildComposeTab() {
    return Column(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Compose Communication",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QDropdownField(
                label: "Template",
                items: templateOptions,
                value: selectedTemplate,
                onChanged: (value, label) {
                  selectedTemplate = value;
                  
                  // Auto-fill based on template
                  switch (value) {
                    case "payment_reminder":
                      subject = "Payment Reminder - Invoice Due";
                      message = "Dear Customer,\n\nThis is a friendly reminder that your payment is due. Please process your payment at your earliest convenience.\n\nThank you for your business.";
                      break;
                    case "invoice_notification":
                      subject = "New Invoice Available";
                      message = "Dear Customer,\n\nYour new invoice is now available for payment. Please review and process payment by the due date.\n\nThank you.";
                      break;
                    case "account_statement":
                      subject = "Monthly Account Statement";
                      message = "Dear Customer,\n\nPlease find your monthly account statement attached. If you have any questions, please contact us.\n\nBest regards.";
                      break;
                    case "custom":
                      subject = "";
                      message = "";
                      break;
                  }
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Recipient Type",
                      items: recipientTypeOptions,
                      value: recipientType,
                      onChanged: (value, label) {
                        recipientType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  if (recipientType == "individual")
                    Expanded(
                      child: QDropdownField(
                        label: "Select Customer",
                        items: customerOptions,
                        value: selectedRecipient,
                        onChanged: (value, label) {
                          selectedRecipient = value;
                          setState(() {});
                        },
                      ),
                    ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              QTextField(
                label: "Subject",
                value: subject,
                hint: "Enter email subject or communication title",
                onChanged: (value) {
                  subject = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Message",
                value: message,
                hint: "Enter your message content here...",
                maxLines: 8,
                onChanged: (value) {
                  message = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  QButton(
                    label: "Save Draft",
                    size: bs.sm,
                    onPressed: () {
                      si("Draft saved");
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Send Communication",
                    size: bs.md,
                    onPressed: _sendCommunication,
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Communication Stats
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Communication Statistics",
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
                    child: Column(
                      children: [
                        Text(
                          "${communications.where((c) => c["type"] == "email").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Emails",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${communications.where((c) => c["type"] == "sms").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "SMS",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${communications.where((c) => c["type"] == "phone").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Calls",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${communications.where((c) => c["type"] == "letter").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Letters",
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
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Communication",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Compose", icon: Icon(Icons.create)),
      ],
      tabChildren: [
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildHistoryTab(),
          ),
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildComposeTab(),
          ),
      ],
    );
  }
}
