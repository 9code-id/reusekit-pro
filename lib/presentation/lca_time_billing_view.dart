import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaTimeBillingView extends StatefulWidget {
  const LcaTimeBillingView({super.key});

  @override
  State<LcaTimeBillingView> createState() => _LcaTimeBillingViewState();
}

class _LcaTimeBillingViewState extends State<LcaTimeBillingView> {
  String selectedPeriod = "This Month";
  String selectedClient = "All Clients";
  String selectedAttorney = "All Attorneys";
  
  List<Map<String, dynamic>> billingEntries = [
    {
      "id": 1,
      "date": "2025-06-19",
      "attorney": "Sarah Wilson",
      "client": "TechCorp Industries",
      "matter": "Contract Review - Software License",
      "description": "Reviewed software licensing agreement terms and conditions",
      "timeStart": "09:00",
      "timeEnd": "11:30",
      "duration": 2.5,
      "hourlyRate": 350.0,
      "amount": 875.0,
      "billable": true,
      "invoiced": false,
      "category": "Legal Research",
      "status": "Approved",
    },
    {
      "id": 2,
      "date": "2025-06-19",
      "attorney": "Michael Davis",
      "client": "Johnson Corp",
      "matter": "Litigation - Employment Dispute",
      "description": "Prepared court documents and reviewed case precedents",
      "timeStart": "14:00",
      "timeEnd": "17:00",
      "duration": 3.0,
      "hourlyRate": 425.0,
      "amount": 1275.0,
      "billable": true,
      "invoiced": true,
      "category": "Court Preparation",
      "status": "Invoiced",
    },
    {
      "id": 3,
      "date": "2025-06-18",
      "attorney": "Lisa Chen",
      "client": "Smith Family Trust",
      "matter": "Estate Planning - Will Drafting",
      "description": "Drafted comprehensive will and trust documents",
      "timeStart": "10:00",
      "timeEnd": "12:00",
      "duration": 2.0,
      "hourlyRate": 300.0,
      "amount": 600.0,
      "billable": true,
      "invoiced": false,
      "category": "Document Drafting",
      "status": "Pending Review",
    },
    {
      "id": 4,
      "date": "2025-06-18",
      "attorney": "David Rodriguez",
      "client": "Metro Construction",
      "matter": "Real Estate - Property Acquisition",
      "description": "Conducted due diligence review of property documents",
      "timeStart": "13:30",
      "timeEnd": "16:00",
      "duration": 2.5,
      "hourlyRate": 375.0,
      "amount": 937.5,
      "billable": true,
      "invoiced": false,
      "category": "Due Diligence",
      "status": "Approved",
    },
    {
      "id": 5,
      "date": "2025-06-17",
      "attorney": "Emily Taylor",
      "client": "Healthcare Partners",
      "matter": "Compliance Review - HIPAA",
      "description": "Administrative tasks and internal meetings",
      "timeStart": "11:00",
      "timeEnd": "12:30",
      "duration": 1.5,
      "hourlyRate": 325.0,
      "amount": 0.0,
      "billable": false,
      "invoiced": false,
      "category": "Administration",
      "status": "Non-Billable",
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> clientOptions = [
    {"label": "All Clients", "value": "All Clients"},
    {"label": "TechCorp Industries", "value": "TechCorp Industries"},
    {"label": "Johnson Corp", "value": "Johnson Corp"},
    {"label": "Smith Family Trust", "value": "Smith Family Trust"},
    {"label": "Metro Construction", "value": "Metro Construction"},
    {"label": "Healthcare Partners", "value": "Healthcare Partners"},
  ];

  List<Map<String, dynamic>> attorneyOptions = [
    {"label": "All Attorneys", "value": "All Attorneys"},
    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
    {"label": "Michael Davis", "value": "Michael Davis"},
    {"label": "Lisa Chen", "value": "Lisa Chen"},
    {"label": "David Rodriguez", "value": "David Rodriguez"},
    {"label": "Emily Taylor", "value": "Emily Taylor"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Invoiced":
        return primaryColor;
      case "Pending Review":
        return warningColor;
      case "Non-Billable":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  List<Map<String, dynamic>> get filteredEntries {
    return billingEntries.where((entry) {
      bool clientMatch = selectedClient == "All Clients" || entry["client"] == selectedClient;
      bool attorneyMatch = selectedAttorney == "All Attorneys" || entry["attorney"] == selectedAttorney;
      return clientMatch && attorneyMatch;
    }).toList();
  }

  Widget _buildBillingSummary() {
    List<Map<String, dynamic>> entries = filteredEntries;
    double totalBillable = entries
        .where((e) => e["billable"] == true)
        .fold(0.0, (sum, e) => sum + (e["amount"] as double));
    double totalInvoiced = entries
        .where((e) => e["invoiced"] == true)
        .fold(0.0, (sum, e) => sum + (e["amount"] as double));
    double pendingAmount = entries
        .where((e) => e["billable"] == true && e["invoiced"] == false)
        .fold(0.0, (sum, e) => sum + (e["amount"] as double));
    double totalHours = entries
        .where((e) => e["billable"] == true)
        .fold(0.0, (sum, e) => sum + (e["duration"] as double));

    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        children: [
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
                    children: [
                      Text(
                        "\$${totalBillable.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Billable",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    children: [
                      Text(
                        "\$${totalInvoiced.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Invoiced",
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
          SizedBox(height: spSm),
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
                    children: [
                      Text(
                        "\$${pendingAmount.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending Invoice",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    children: [
                      Text(
                        "${totalHours.toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Billable Hours",
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
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spSm),
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
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Client",
                  items: clientOptions,
                  value: selectedClient,
                  onChanged: (value, label) {
                    selectedClient = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Attorney",
            items: attorneyOptions,
            value: selectedAttorney,
            onChanged: (value, label) {
              selectedAttorney = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBillingEntries() {
    List<Map<String, dynamic>> entries = filteredEntries;

    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Billing Entries",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${entries.length} entries",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...entries.map((entry) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(entry["status"]),
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
                              "${entry["matter"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${entry["client"]} • ${entry["attorney"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            entry["billable"] ? "\$${(entry["amount"] as double).currency}" : "Non-Billable",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: entry["billable"] ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(entry["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${entry["status"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(entry["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${entry["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${entry["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${entry["timeStart"]} - ${entry["timeEnd"]} (${entry["duration"]}h)",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.category,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${entry["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (entry["billable"] == true)
                    Container(
                      margin: EdgeInsets.only(top: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Rate: \$${(entry["hourlyRate"] as double).currency}/hr",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${entry["duration"]}h × \$${(entry["hourlyRate"] as double).currency} = \$${(entry["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          size: bs.sm,
                          onPressed: () {
                            ss("Edit functionality");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      if (!entry["invoiced"])
                        Expanded(
                          child: QButton(
                            label: entry["billable"] ? "Invoice" : "Mark Billable",
                            size: bs.sm,
                            onPressed: () {
                              if (entry["billable"]) {
                                entry["invoiced"] = true;
                                entry["status"] = "Invoiced";
                                ss("Entry invoiced successfully");
                              } else {
                                entry["billable"] = true;
                                entry["status"] = "Approved";
                                ss("Entry marked as billable");
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      if (entry["invoiced"])
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.center,
                            child: Text(
                              "Invoiced",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Billing"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              ss("Add new time entry");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Export billing report");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBillingSummary(),
            _buildFilters(),
            _buildBillingEntries(),
          ],
        ),
      ),
    );
  }
}
