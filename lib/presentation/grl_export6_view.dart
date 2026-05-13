import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlExport6View extends StatefulWidget {
  @override
  State<GrlExport6View> createState() => _GrlExport6ViewState();
}

class _GrlExport6ViewState extends State<GrlExport6View> {
  int currentTab = 0;
  String selectedDatabase = "PostgreSQL";
  String selectedTable = "users";
  List<String> selectedColumns = [];
  String whereCondition = "";
  String orderBy = "";
  int limitRecords = 0;
  bool useCustomQuery = false;
  String customQuery = "";
  
  List<Map<String, dynamic>> databaseOptions = [
    {"label": "PostgreSQL", "value": "PostgreSQL"},
    {"label": "MySQL", "value": "MySQL"},
    {"label": "MongoDB", "value": "MongoDB"},
    {"label": "SQLite", "value": "SQLite"},
  ];
  
  List<Map<String, dynamic>> tableOptions = [
    {"label": "users", "value": "users"},
    {"label": "orders", "value": "orders"},
    {"label": "products", "value": "products"},
    {"label": "customers", "value": "customers"},
    {"label": "transactions", "value": "transactions"},
  ];
  
  List<Map<String, dynamic>> columnOptions = [
    {"label": "id", "value": "id", "type": "INTEGER", "checked": true},
    {"label": "name", "value": "name", "type": "VARCHAR", "checked": true},
    {"label": "email", "value": "email", "type": "VARCHAR", "checked": true},
    {"label": "phone", "value": "phone", "type": "VARCHAR", "checked": false},
    {"label": "address", "value": "address", "type": "TEXT", "checked": false},
    {"label": "created_at", "value": "created_at", "type": "TIMESTAMP", "checked": true},
    {"label": "updated_at", "value": "updated_at", "type": "TIMESTAMP", "checked": false},
    {"label": "status", "value": "status", "type": "VARCHAR", "checked": true},
  ];
  
  List<Map<String, dynamic>> queryHistory = [
    {
      "query": "SELECT * FROM users WHERE created_at >= '2024-01-01'",
      "table": "users",
      "records": 1245,
      "executedAt": "2024-01-15 10:30:00",
      "duration": "0.85s"
    },
    {
      "query": "SELECT id, name, email FROM customers ORDER BY created_at DESC LIMIT 1000",
      "table": "customers",
      "records": 1000,
      "executedAt": "2024-01-15 09:15:00",
      "duration": "0.42s"
    },
    {
      "query": "SELECT * FROM orders JOIN products ON orders.product_id = products.id",
      "table": "orders",
      "records": 3567,
      "executedAt": "2024-01-14 16:45:00",
      "duration": "1.23s"
    },
  ];
  
  Map<String, dynamic> queryResults = {
    "totalRecords": 0,
    "executionTime": "",
    "columns": [],
    "sampleData": [],
    "isExecuting": false,
  };

  @override
  void initState() {
    super.initState();
    selectedColumns = columnOptions
        .where((col) => col["checked"] == true)
        .map((col) => col["value"] as String)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Database Export Tool",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Query Builder", icon: Icon(Icons.build)),
        Tab(text: "Custom Query", icon: Icon(Icons.code)),
        Tab(text: "Results", icon: Icon(Icons.table_chart)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildQueryBuilderTab(),
        _buildCustomQueryTab(),
        _buildResultsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildQueryBuilderTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDatabaseTableSection(),
          _buildColumnSelectionSection(),
          _buildConditionsSection(),
          _buildOrderLimitSection(),
          _buildQueryPreview(),
          _buildExecuteButton(),
        ],
      ),
    );
  }

  Widget _buildDatabaseTableSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.storage, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Database & Table",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Database Type",
                  items: databaseOptions,
                  value: selectedDatabase,
                  onChanged: (value, label) {
                    selectedDatabase = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Table",
                  items: tableOptions,
                  value: selectedTable,
                  onChanged: (value, label) {
                    selectedTable = value;
                    _loadTableColumns();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          _buildConnectionStatus(),
        ],
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: successColor, size: 16),
          SizedBox(width: spXs),
          Text(
            "Connected to $selectedDatabase database",
            style: TextStyle(
              fontSize: 12,
              color: successColor,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              _testConnection();
            },
            child: Text(
              "Test Connection",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnSelectionSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.view_column, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Column Selection",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  bool allSelected = columnOptions.every((col) => col["checked"] == true);
                  for (var col in columnOptions) {
                    col["checked"] = !allSelected;
                  }
                  selectedColumns = columnOptions
                      .where((col) => col["checked"] == true)
                      .map((col) => col["value"] as String)
                      .toList();
                  setState(() {});
                },
                child: Text(
                  "Select All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          _buildColumnGrid(),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "${selectedColumns.length} columns selected from ${columnOptions.length} available",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnGrid() {
    return Wrap(
      spacing: spXs,
      runSpacing: spXs,
      children: columnOptions.map((column) {
        bool isSelected = column["checked"] == true;
        return GestureDetector(
          onTap: () {
            column["checked"] = !isSelected;
            selectedColumns = columnOptions
                .where((col) => col["checked"] == true)
                .map((col) => col["value"] as String)
                .toList();
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: isSelected ? primaryColor : Colors.grey.withAlpha(100),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  color: isSelected ? Colors.white : disabledBoldColor,
                  size: 14,
                ),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${column["label"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                    Text(
                      "${column["type"]}",
                      style: TextStyle(
                        fontSize: 9,
                        color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConditionsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.filter_alt, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Filter Conditions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "WHERE Clause",
            value: whereCondition,
            hint: "e.g., status = 'active' AND created_at >= '2024-01-01'",
            onChanged: (value) {
              whereCondition = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Use standard SQL WHERE syntax. Leave empty to export all records.",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderLimitSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.sort, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Sorting & Limit",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "ORDER BY",
                  value: orderBy,
                  hint: "e.g., created_at DESC, name ASC",
                  onChanged: (value) {
                    orderBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "LIMIT",
                  value: limitRecords > 0 ? limitRecords.toString() : "",
                  hint: "0 = no limit",
                  onChanged: (value) {
                    limitRecords = int.tryParse(value) ?? 0;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQueryPreview() {
    String query = _generateQuery();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.preview, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Query Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Copy",
                icon: Icons.copy,
                size: bs.sm,
                onPressed: () {
                  _copyQuery(query);
                },
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.grey.withAlpha(100)),
            ),
            child: Text(
              query,
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Courier",
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExecuteButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: queryResults["isExecuting"] ? "Executing..." : "Execute Query",
        icon: queryResults["isExecuting"] ? Icons.sync : Icons.play_arrow,
        size: bs.md,
        onPressed: queryResults["isExecuting"] ? null : () {
          _executeQuery();
        },
      ),
    );
  }

  Widget _buildCustomQueryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCustomQueryEditor(),
          _buildQueryTemplates(),
        ],
      ),
    );
  }

  Widget _buildCustomQueryEditor() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Custom SQL Query",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QSwitch(
                items: [
                  {
                    "label": "Use Custom",
                    "value": "custom",
                    "checked": useCustomQuery,
                  }
                ],
                value: [
                  if (useCustomQuery)
                    {
                      "label": "Use Custom",
                      "value": "custom",
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  useCustomQuery = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
          Container(
            height: 200,
            child: QMemoField(
              label: "SQL Query",
              value: customQuery,
              hint: "Enter your custom SQL query here...",
              onChanged: (value) {
                customQuery = value;
                setState(() {});
              },
            ),
          ),
          Row(
            children: [
              QButton(
                label: "Format",
                icon: Icons.format_align_left,
                size: bs.sm,
                onPressed: () {
                  _formatQuery();
                },
              ),
              SizedBox(width: spXs),
              QButton(
                label: "Validate",
                icon: Icons.check,
                size: bs.sm,
                onPressed: () {
                  _validateQuery();
                },
              ),
              Spacer(),
              QButton(
                label: "Execute",
                icon: Icons.play_arrow,
                size: bs.sm,
                onPressed: () {
                  _executeCustomQuery();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQueryTemplates() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "Basic Select",
        "query": "SELECT * FROM table_name WHERE condition = 'value'",
        "description": "Simple select with WHERE clause"
      },
      {
        "name": "Join Tables",
        "query": "SELECT a.*, b.name FROM table_a a JOIN table_b b ON a.id = b.table_a_id",
        "description": "Inner join between two tables"
      },
      {
        "name": "Group By Count",
        "query": "SELECT status, COUNT(*) as count FROM table_name GROUP BY status ORDER BY count DESC",
        "description": "Count records by status"
      },
      {
        "name": "Date Range",
        "query": "SELECT * FROM table_name WHERE created_at BETWEEN '2024-01-01' AND '2024-12-31'",
        "description": "Select records in date range"
      },
    ];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Query Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...templates.map((template) => _buildTemplateCard(template)),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "${template["name"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  customQuery = template["query"];
                  setState(() {});
                  ss("Template applied!");
                },
                child: Text(
                  "Use Template",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${template["description"]}",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${template["query"]}",
              style: TextStyle(
                fontSize: 9,
                fontFamily: "Courier",
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildResultsHeader(),
          if (queryResults["sampleData"].isNotEmpty) _buildResultsTable(),
          if (queryResults["sampleData"].isEmpty) _buildNoResults(),
        ],
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.table_chart, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Query Results",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (queryResults["totalRecords"] > 0) ...[
                QButton(
                  label: "Export All",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    _exportResults();
                  },
                ),
              ],
            ],
          ),
          if (queryResults["totalRecords"] > 0) ...[
            Row(
              children: [
                _buildStatCard("Total Records", "${queryResults["totalRecords"]}", Icons.assessment),
                SizedBox(width: spSm),
                _buildStatCard("Execution Time", "${queryResults["executionTime"]}", Icons.timer),
                SizedBox(width: spSm),
                _buildStatCard("Columns", "${(queryResults["columns"] as List).length}", Icons.view_column),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(50),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 16),
            SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsTable() {
    List<String> columns = (queryResults["columns"] as List).cast<String>();
    List<Map<String, dynamic>> data = (queryResults["sampleData"] as List).cast<Map<String, dynamic>>();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Sample Data (First 10 Records)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: columns.map((col) => DataColumn(
                label: Text(
                  col,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              )).toList(),
              rows: data.take(10).map((row) => DataRow(
                cells: columns.map((col) => DataCell(
                  Text(
                    "${row[col] ?? ""}",
                    style: TextStyle(fontSize: 11),
                  ),
                )).toList(),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 64, color: disabledBoldColor),
          SizedBox(height: spSm),
          Text(
            "No Results",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Execute a query to see results here",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHistoryHeader(),
          ...queryHistory.map((query) => _buildHistoryItem(query)),
        ],
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Icon(Icons.history, color: primaryColor),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Query History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Previous executed queries",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Clear All",
            icon: Icons.clear_all,
            size: bs.sm,
            onPressed: () {
              _clearHistory();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> query) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.query_stats, color: Colors.white, size: 16),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Table: ${query["table"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${query["records"]} records • ${query["duration"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${query["executedAt"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${query["query"]}",
              style: TextStyle(
                fontSize: 10,
                fontFamily: "Courier",
                color: primaryColor,
              ),
            ),
          ),
          Row(
            children: [
              Spacer(),
              QButton(
                label: "Reuse",
                icon: Icons.replay,
                size: bs.sm,
                onPressed: () {
                  _reuseQuery(query);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {
                  _deleteQuery(query);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _generateQuery() {
    if (selectedColumns.isEmpty) return "-- Please select columns";
    
    String query = "SELECT ${selectedColumns.join(', ')}\nFROM $selectedTable";
    
    if (whereCondition.isNotEmpty) {
      query += "\nWHERE $whereCondition";
    }
    
    if (orderBy.isNotEmpty) {
      query += "\nORDER BY $orderBy";
    }
    
    if (limitRecords > 0) {
      query += "\nLIMIT $limitRecords";
    }
    
    return query;
  }

  void _loadTableColumns() {
    // Simulate loading columns from selected table
    ss("Loaded columns for table: $selectedTable");
  }

  void _testConnection() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Database connection successful!");
    });
  }

  void _copyQuery(String query) {
    ss("Query copied to clipboard!");
  }

  void _executeQuery() {
    if (selectedColumns.isEmpty) {
      se("Please select at least one column");
      return;
    }
    
    queryResults["isExecuting"] = true;
    setState(() {});
    
    // Simulate query execution
    Future.delayed(Duration(seconds: 3), () {
      queryResults = {
        "totalRecords": 1245,
        "executionTime": "0.85s",
        "columns": selectedColumns,
        "sampleData": _generateSampleData(),
        "isExecuting": false,
      };
      
      // Add to history
      queryHistory.insert(0, {
        "query": _generateQuery(),
        "table": selectedTable,
        "records": 1245,
        "executedAt": DateTime.now().toString().substring(0, 19),
        "duration": "0.85s"
      });
      
      setState(() {});
      currentTab = 2; // Switch to results tab
      ss("Query executed successfully!");
    });
  }

  List<Map<String, dynamic>> _generateSampleData() {
    return List.generate(10, (index) {
      Map<String, dynamic> row = {};
      for (String col in selectedColumns) {
        switch (col) {
          case 'id':
            row[col] = 1000 + index;
            break;
          case 'name':
            row[col] = "User ${1000 + index}";
            break;
          case 'email':
            row[col] = "user${1000 + index}@example.com";
            break;
          case 'phone':
            row[col] = "+1-555-${1000 + index}";
            break;
          case 'status':
            row[col] = index % 2 == 0 ? "active" : "inactive";
            break;
          default:
            row[col] = "Sample data";
        }
      }
      return row;
    });
  }

  void _formatQuery() {
    if (customQuery.isNotEmpty) {
      // Simple formatting
      customQuery = customQuery
          .replaceAll(',', ',\n  ')
          .replaceAll(' FROM ', '\nFROM ')
          .replaceAll(' WHERE ', '\nWHERE ')
          .replaceAll(' ORDER BY ', '\nORDER BY ');
      setState(() {});
      ss("Query formatted!");
    }
  }

  void _validateQuery() {
    if (customQuery.isEmpty) {
      se("Please enter a query first");
      return;
    }
    
    // Basic validation
    if (customQuery.toUpperCase().contains('SELECT')) {
      ss("Query syntax looks valid!");
    } else {
      sw("Query may have syntax issues");
    }
  }

  void _executeCustomQuery() {
    if (customQuery.isEmpty) {
      se("Please enter a custom query");
      return;
    }
    
    _executeQuery();
  }

  void _exportResults() {
    ss("Exporting all ${queryResults["totalRecords"]} records...");
  }

  void _clearHistory() async {
    bool isConfirmed = await confirm("Clear all query history?");
    if (isConfirmed) {
      queryHistory.clear();
      setState(() {});
      ss("Query history cleared");
    }
  }

  void _reuseQuery(Map<String, dynamic> query) {
    customQuery = query["query"];
    useCustomQuery = true;
    currentTab = 1;
    setState(() {});
    ss("Query loaded for reuse!");
  }

  void _deleteQuery(Map<String, dynamic> query) async {
    bool isConfirmed = await confirm("Delete this query from history?");
    if (isConfirmed) {
      queryHistory.remove(query);
      setState(() {});
      ss("Query deleted from history");
    }
  }
}
