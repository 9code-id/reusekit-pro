import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaJournalEntriesView extends StatefulWidget {
  const AbaJournalEntriesView({super.key});

  @override
  State<AbaJournalEntriesView> createState() => _AbaJournalEntriesViewState();
}

class _AbaJournalEntriesViewState extends State<AbaJournalEntriesView> {
  String searchQuery = "";
  String selectedPeriod = "This Month";
  String selectedStatus = "All";
  bool loading = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Posted", "value": "Posted"},
    {"label": "Reviewed", "value": "Reviewed"},
    {"label": "Archived", "value": "Archived"},
  ];

  List<Map<String, dynamic>> journalEntries = [
    {
      "id": "je001",
      "entryNumber": "JE-2024-001",
      "date": "2024-12-19",
      "reference": "INV-1234",
      "description": "Customer payment received",
      "status": "Posted",
      "totalDebit": 2500.00,
      "totalCredit": 2500.00,
      "createdBy": "John Smith",
      "createdDate": "2024-12-19T10:30:00",
      "reviewedBy": "Jane Doe",
      "reviewedDate": "2024-12-19T14:15:00",
      "entries": [
        {
          "account": "Bank Account - Checking",
          "accountNumber": "1002",
          "description": "Payment from customer ABC Corp",
          "debit": 2500.00,
          "credit": 0.0
        },
        {
          "account": "Accounts Receivable",
          "accountNumber": "1200",
          "description": "Payment received for Invoice #1234",
          "debit": 0.0,
          "credit": 2500.00
        }
      ]
    },
    {
      "id": "je002",
      "entryNumber": "JE-2024-002",
      "date": "2024-12-18",
      "reference": "PO-567",
      "description": "Office supplies purchase",
      "status": "Posted",
      "totalDebit": 450.00,
      "totalCredit": 450.00,
      "createdBy": "Sarah Wilson",
      "createdDate": "2024-12-18T09:15:00",
      "reviewedBy": "John Smith",
      "reviewedDate": "2024-12-18T16:30:00",
      "entries": [
        {
          "account": "Office Supplies",
          "accountNumber": "5001",
          "description": "Monthly office supplies",
          "debit": 450.00,
          "credit": 0.0
        },
        {
          "account": "Accounts Payable",
          "accountNumber": "2001",
          "description": "Purchase from Office Depot",
          "debit": 0.0,
          "credit": 450.00
        }
      ]
    },
    {
      "id": "je003",
      "entryNumber": "JE-2024-003",
      "date": "2024-12-17",
      "reference": "RENT-12",
      "description": "Monthly rent payment",
      "status": "Reviewed",
      "totalDebit": 2000.00,
      "totalCredit": 2000.00,
      "createdBy": "Mike Johnson",
      "createdDate": "2024-12-17T08:00:00",
      "reviewedBy": "Jane Doe",
      "reviewedDate": "2024-12-17T10:45:00",
      "entries": [
        {
          "account": "Rent Expense",
          "accountNumber": "5100",
          "description": "December office rent",
          "debit": 2000.00,
          "credit": 0.0
        },
        {
          "account": "Bank Account - Checking",
          "accountNumber": "1002",
          "description": "Rent payment to landlord",
          "debit": 0.0,
          "credit": 2000.00
        }
      ]
    },
    {
      "id": "je004",
      "entryNumber": "JE-2024-004",
      "date": "2024-12-16",
      "reference": "DEP-001",
      "description": "Monthly depreciation entry",
      "status": "Draft",
      "totalDebit": 500.00,
      "totalCredit": 500.00,
      "createdBy": "Jane Doe",
      "createdDate": "2024-12-16T17:20:00",
      "reviewedBy": null,
      "reviewedDate": null,
      "entries": [
        {
          "account": "Depreciation Expense",
          "accountNumber": "5500",
          "description": "Monthly equipment depreciation",
          "debit": 500.00,
          "credit": 0.0
        },
        {
          "account": "Accumulated Depreciation",
          "accountNumber": "1402",
          "description": "Equipment depreciation accumulation",
          "debit": 0.0,
          "credit": 500.00
        }
      ]
    },
    {
      "id": "je005",
      "entryNumber": "JE-2024-005",
      "date": "2024-12-15",
      "reference": "SAL-789",
      "description": "Service revenue recognition",
      "status": "Posted",
      "totalDebit": 1800.00,
      "totalCredit": 1800.00,
      "createdBy": "Sarah Wilson",
      "createdDate": "2024-12-15T14:30:00",
      "reviewedBy": "John Smith",
      "reviewedDate": "2024-12-15T15:45:00",
      "entries": [
        {
          "account": "Accounts Receivable",
          "accountNumber": "1200",
          "description": "Service provided to Client XYZ",
          "debit": 1800.00,
          "credit": 0.0
        },
        {
          "account": "Service Revenue",
          "accountNumber": "4002",
          "description": "Consulting services revenue",
          "debit": 0.0,
          "credit": 1800.00
        }
      ]
    },
    {
      "id": "je006",
      "entryNumber": "JE-2024-006",
      "date": "2024-12-14",
      "reference": "ADJ-001",
      "description": "Accrued expense adjustment",
      "status": "Archived",
      "totalDebit": 300.00,
      "totalCredit": 300.00,
      "createdBy": "Mike Johnson",
      "createdDate": "2024-12-14T11:00:00",
      "reviewedBy": "Jane Doe",
      "reviewedDate": "2024-12-14T13:30:00",
      "entries": [
        {
          "account": "Utilities Expense",
          "accountNumber": "5300",
          "description": "Accrued utility expenses",
          "debit": 300.00,
          "credit": 0.0
        },
        {
          "account": "Accrued Expenses",
          "accountNumber": "2200",
          "description": "Utility expenses accrual",
          "debit": 0.0,
          "credit": 300.00
        }
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredEntries {
    return journalEntries.where((entry) {
      bool matchesSearch = "${entry["entryNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${entry["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${entry["reference"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || entry["status"] == selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Posted":
        return successColor;
      case "Reviewed":
        return infoColor;
      case "Draft":
        return warningColor;
      case "Archived":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Posted":
        return Icons.check_circle;
      case "Reviewed":
        return Icons.verified;
      case "Draft":
        return Icons.edit;
      case "Archived":
        return Icons.archive;
      default:
        return Icons.receipt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal Entries"),
        actions: [
          IconButton(
            onPressed: () {
              //navigateTo('JournalReportsView')
            },
            icon: Icon(Icons.analytics),
          ),
          IconButton(
            onPressed: () {
              //navigateTo('AddJournalEntryView')
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Search and Filter Section
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
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Search journal entries...",
                                value: searchQuery,
                                hint: "Entry number, description, or reference",
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: spSm,
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

                  // Summary Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildSummaryCard(
                        "Total Entries",
                        "${journalEntries.length}",
                        Icons.receipt,
                        primaryColor,
                      ),
                      _buildSummaryCard(
                        "Posted",
                        "${journalEntries.where((e) => e["status"] == "Posted").length}",
                        Icons.check_circle,
                        successColor,
                      ),
                      _buildSummaryCard(
                        "Pending Review",
                        "${journalEntries.where((e) => e["status"] == "Draft").length}",
                        Icons.pending,
                        warningColor,
                      ),
                      _buildSummaryCard(
                        "Total Debits",
                        "${journalEntries.map((e) => e["totalDebit"] as double).fold(0.0, (sum, amount) => sum + amount).currency}",
                        Icons.trending_up,
                        infoColor,
                      ),
                    ],
                  ),

                  // Journal Entries List
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
                            children: [
                              Icon(
                                Icons.list,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Journal Entries (${filteredEntries.length})",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredEntries.length,
                          separatorBuilder: (context, index) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final entry = filteredEntries[index];
                            String status = "${entry["status"]}";
                            List<Map<String, dynamic>> entryLines = entry["entries"] as List<Map<String, dynamic>>;

                            return GestureDetector(
                              onTap: () {
                                //navigateTo('JournalEntryDetailView', entry)
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Entry Header
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(status).withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            _getStatusIcon(status),
                                            color: _getStatusColor(status),
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "${entry["entryNumber"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: spXs,
                                                      vertical: 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: _getStatusColor(status).withAlpha(20),
                                                      borderRadius: BorderRadius.circular(radiusXs),
                                                    ),
                                                    child: Text(
                                                      status,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        color: _getStatusColor(status),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                "${entry["description"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: disabledBoldColor,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${DateTime.parse("${entry["date"]}").dMMMy}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                  if (entry["reference"] != null) ...[
                                                    SizedBox(width: spSm),
                                                    Container(
                                                      width: 4,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                        color: disabledColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    SizedBox(width: spSm),
                                                    Text(
                                                      "${entry["reference"]}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: disabledBoldColor,
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${(entry["totalDebit"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${entryLines.length} lines",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: spSm),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: disabledColor,
                                          size: 16,
                                        ),
                                      ],
                                    ),

                                    // Entry Lines Preview
                                    SizedBox(height: spSm),
                                    Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: disabledColor.withAlpha(5),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Column(
                                        children: entryLines.take(2).map((line) {
                                          double debit = (line["debit"] as num).toDouble();
                                          double credit = (line["credit"] as num).toDouble();
                                          bool isDebit = debit > 0;

                                          return Padding(
                                            padding: EdgeInsets.symmetric(vertical: 2),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 60,
                                                  child: Text(
                                                    "${line["accountNumber"]}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: spSm),
                                                Expanded(
                                                  child: Text(
                                                    "${line["account"]}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: spSm),
                                                Text(
                                                  "${isDebit ? 'Dr.' : 'Cr.'} ${(isDebit ? debit : credit).currency}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: isDebit ? successColor : dangerColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),

                                    // Created/Reviewed Info
                                    SizedBox(height: spSm),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: disabledColor,
                                          size: 14,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Created by ${entry["createdBy"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        if (entry["reviewedBy"] != null) ...[
                                          SizedBox(width: spSm),
                                          Container(
                                            width: 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: disabledColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Icon(
                                            Icons.verified,
                                            color: successColor,
                                            size: 14,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Reviewed by ${entry["reviewedBy"]}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('AddJournalEntryView')
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              Spacer(),
              Icon(
                Icons.book,
                color: color,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
