import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaContractView extends StatefulWidget {
  const EmaContractView({super.key});

  @override
  State<EmaContractView> createState() => _EmaContractViewState();
}

class _EmaContractViewState extends State<EmaContractView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";

  List<Map<String, dynamic>> contracts = [
    {
      "id": 1,
      "contractNumber": "CNT-2024-001",
      "title": "Annual Tech Conference Venue Contract",
      "clientName": "TechCorp Solutions",
      "vendorName": "Grand Convention Center",
      "contractType": "Venue Rental",
      "startDate": "2024-03-15",
      "endDate": "2024-03-17",
      "value": 75000,
      "status": "Active",
      "signingDate": "2024-01-20",
      "description": "Three-day venue rental contract for annual technology conference including main hall, breakout rooms, and catering facilities.",
      "milestones": [
        {"name": "Contract Signed", "date": "2024-01-20", "status": "Completed"},
        {"name": "Initial Payment", "date": "2024-02-01", "status": "Completed"},
        {"name": "Final Payment", "date": "2024-03-10", "status": "Pending"},
        {"name": "Event Completion", "date": "2024-03-17", "status": "Upcoming"}
      ],
      "documents": ["Contract Agreement", "Payment Schedule", "Venue Layout"],
      "contactPerson": "Sarah Johnson",
      "email": "sarah@techcorp.com",
      "phone": "+1 555 0401"
    },
    {
      "id": 2,
      "contractNumber": "CNT-2024-002",
      "title": "Wedding Photography Services",
      "clientName": "Michael & Emma Smith",
      "vendorName": "Lens Masters Photography",
      "contractType": "Photography",
      "startDate": "2024-06-15",
      "endDate": "2024-06-15",
      "value": 3500,
      "status": "Pending Approval",
      "signingDate": "",
      "description": "Full-day wedding photography package including ceremony, reception, and couple's photoshoot with digital gallery delivery.",
      "milestones": [
        {"name": "Contract Review", "date": "2024-02-15", "status": "In Progress"},
        {"name": "Contract Signing", "date": "2024-02-20", "status": "Pending"},
        {"name": "Deposit Payment", "date": "2024-02-25", "status": "Pending"},
        {"name": "Final Payment", "date": "2024-06-10", "status": "Upcoming"}
      ],
      "documents": ["Photography Package Details", "Copyright Agreement", "Payment Terms"],
      "contactPerson": "Emma Smith",
      "email": "emma.smith@email.com",
      "phone": "+1 555 0402"
    },
    {
      "id": 3,
      "contractNumber": "CNT-2024-003",
      "title": "Corporate Catering Agreement",
      "clientName": "Global Finance Inc",
      "vendorName": "Gourmet Catering Co",
      "contractType": "Catering",
      "startDate": "2024-04-01",
      "endDate": "2024-12-31",
      "value": 120000,
      "status": "Active",
      "signingDate": "2024-01-15",
      "description": "Annual corporate catering contract for monthly board meetings, quarterly events, and special occasions throughout the year.",
      "milestones": [
        {"name": "Contract Signed", "date": "2024-01-15", "status": "Completed"},
        {"name": "Q1 Services", "date": "2024-03-31", "status": "Completed"},
        {"name": "Q2 Services", "date": "2024-06-30", "status": "In Progress"},
        {"name": "Annual Review", "date": "2024-11-30", "status": "Upcoming"}
      ],
      "documents": ["Service Agreement", "Menu Options", "Quarterly Invoice", "Insurance Certificate"],
      "contactPerson": "Robert Wilson",
      "email": "robert@globalfinance.com",
      "phone": "+1 555 0403"
    },
    {
      "id": 4,
      "contractNumber": "CNT-2024-004",
      "title": "Audio Visual Equipment Rental",
      "clientName": "Education Summit 2024",
      "vendorName": "Elite Audio Solutions",
      "contractType": "Equipment Rental",
      "startDate": "2024-05-20",
      "endDate": "2024-05-22",
      "value": 8500,
      "status": "Draft",
      "signingDate": "",
      "description": "Complete audio-visual setup for education summit including sound systems, projection equipment, and live streaming capabilities.",
      "milestones": [
        {"name": "Equipment Specification", "date": "2024-02-28", "status": "In Progress"},
        {"name": "Contract Finalization", "date": "2024-03-05", "status": "Pending"},
        {"name": "Equipment Delivery", "date": "2024-05-19", "status": "Upcoming"},
        {"name": "Setup & Testing", "date": "2024-05-20", "status": "Upcoming"}
      ],
      "documents": ["Equipment List", "Technical Specifications", "Setup Timeline"],
      "contactPerson": "Dr. Maria Lopez",
      "email": "maria@educationsummit.org",
      "phone": "+1 555 0404"
    },
    {
      "id": 5,
      "contractNumber": "CNT-2023-098",
      "title": "Holiday Party Entertainment",
      "clientName": "Downtown Business Association",
      "vendorName": "City Entertainment Group",
      "contractType": "Entertainment",
      "startDate": "2023-12-15",
      "endDate": "2023-12-15",
      "value": 12000,
      "status": "Completed",
      "signingDate": "2023-10-01",
      "description": "Holiday party entertainment package including live band, DJ services, and special lighting for annual business association celebration.",
      "milestones": [
        {"name": "Contract Signed", "date": "2023-10-01", "status": "Completed"},
        {"name": "Performance Planning", "date": "2023-11-15", "status": "Completed"},
        {"name": "Event Execution", "date": "2023-12-15", "status": "Completed"},
        {"name": "Final Payment", "date": "2023-12-20", "status": "Completed"}
      ],
      "documents": ["Performance Agreement", "Equipment Rider", "Payment Receipt", "Performance Review"],
      "contactPerson": "James Thompson",
      "email": "james@downtownbusiness.org",
      "phone": "+1 555 0405"
    },
    {
      "id": 6,
      "contractNumber": "CNT-2024-005",
      "title": "Security Services Contract",
      "clientName": "Music Festival 2024",
      "vendorName": "Secure Events Protection",
      "contractType": "Security",
      "startDate": "2024-07-10",
      "endDate": "2024-07-12",
      "value": 25000,
      "status": "Under Review",
      "signingDate": "",
      "description": "Comprehensive security services for three-day music festival including crowd control, VIP protection, and emergency response coordination.",
      "milestones": [
        {"name": "Security Assessment", "date": "2024-03-01", "status": "In Progress"},
        {"name": "Contract Approval", "date": "2024-03-15", "status": "Pending"},
        {"name": "Staff Assignment", "date": "2024-06-01", "status": "Upcoming"},
        {"name": "Pre-Event Briefing", "date": "2024-07-05", "status": "Upcoming"}
      ],
      "documents": ["Security Plan", "Staff Requirements", "Emergency Procedures", "Insurance Coverage"],
      "contactPerson": "Lisa Rodriguez",
      "email": "lisa@musicfestival2024.com",
      "phone": "+1 555 0406"
    }
  ];

  List<String> statusOptions = ["All", "Active", "Pending Approval", "Draft", "Under Review", "Completed"];
  List<String> contractTypes = ["All", "Venue Rental", "Photography", "Catering", "Equipment Rental", "Entertainment", "Security"];

  List<Map<String, dynamic>> get filteredContracts {
    return contracts.where((contract) {
      bool matchesSearch = "${contract["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contract["clientName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contract["vendorName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${contract["contractNumber"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || contract["status"] == selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending Approval":
        return warningColor;
      case "Draft":
        return infoColor;
      case "Under Review":
        return Colors.purple;
      case "Completed":
        return Colors.green.shade700;
      default:
        return disabledColor;
    }
  }

  Color _getMilestoneStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Pending":
        return dangerColor;
      case "Upcoming":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildContractsOverview() {
    return Column(
      spacing: spMd,
      children: [
        // Search and Filter
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
                label: "Search contracts...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              QCategoryPicker(
                label: "Status Filter",
                items: statusOptions.map((status) => {
                  "label": status,
                  "value": status,
                }).toList(),
                value: selectedStatus,
                onChanged: (index, label, value, item) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),

        // Contract Statistics
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
                "Contract Statistics",
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
                          "${contracts.where((c) => c["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active",
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
                          "${contracts.where((c) => c["status"] == "Pending Approval" || c["status"] == "Under Review").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
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
                          "\$${((contracts.where((c) => c["status"] == "Active").map((c) => c["value"] as int).fold(0, (sum, value) => sum + value)) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Active Value",
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
                          "${contracts.where((c) => c["status"] == "Completed").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        Text(
                          "Completed",
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

        // Contracts List
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
              Row(
                children: [
                  Text(
                    "Contracts (${filteredContracts.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      // Add new contract
                    },
                  ),
                ],
              ),
              SizedBox(height: spSm),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredContracts.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final contract = filteredContracts[index];
                  final statusColor = _getStatusColor("${contract["status"]}");
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${contract["contractNumber"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: statusColor.withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${contract["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: statusColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${contract["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.business, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "${contract["clientName"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(" ↔ ", style: TextStyle(color: disabledBoldColor)),
                                      Text(
                                        "${contract["vendorName"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.category, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "${contract["contractType"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                      Text(
                                        "\$${((contract["value"] as int).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (contract["startDate"] != null && "${contract["startDate"]}".isNotEmpty) ...[
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today, size: 12, color: disabledBoldColor),
                                        SizedBox(width: 4),
                                        Text(
                                          "${DateTime.parse("${contract["startDate"]}").dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        if (contract["endDate"] != null && "${contract["endDate"]}".isNotEmpty) ...[
                                          Text(" - ", style: TextStyle(color: disabledBoldColor)),
                                          Text(
                                            "${DateTime.parse("${contract["endDate"]}").dMMMy}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                QButton(
                                  icon: Icons.visibility,
                                  size: bs.sm,
                                  onPressed: () {
                                    // View contract details
                                  },
                                ),
                                SizedBox(height: spXs),
                                QButton(
                                  icon: Icons.edit,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Edit contract
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${contract["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        
                        SizedBox(height: spXs),
                        Wrap(
                          spacing: spXs,
                          runSpacing: 4,
                          children: (contract["documents"] as List).map((doc) => 
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.description, size: 10, color: primaryColor),
                                  SizedBox(width: 2),
                                  Text(
                                    "$doc",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContractForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Create new contracts or upload existing contract documents for management and tracking.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
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
              children: [
                Text(
                  "Contract Creation Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.create, color: primaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Create New Contract",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Use our contract builder to create professional contracts with pre-defined templates for different service types.",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Start Contract Builder",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to contract builder
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.upload_file, color: secondaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Upload Existing Contract",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Upload PDF contracts that were created externally. We'll extract key information and set up tracking.",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Upload Contract Document",
                          size: bs.sm,
                          onPressed: () {
                            // Upload contract document
                          },
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contract Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: contractTypes.skip(1).length,
                  separatorBuilder: (context, index) => SizedBox(height: spXs),
                  itemBuilder: (context, index) {
                    final type = contractTypes.skip(1).toList()[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.description, color: primaryColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "$type Contract Template",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          QButton(
                            label: "Use Template",
                            size: bs.sm,
                            onPressed: () {
                              // Use contract template
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Contract Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Contracts", icon: Icon(Icons.description)),
        Tab(text: "Create Contract", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildContractsOverview(),
        ),
        SingleChildScrollView(
          child: _buildContractForm(),
        ),
      ],
    );
  }
}
