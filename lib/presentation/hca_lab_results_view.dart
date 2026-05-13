import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaLabResultsView extends StatefulWidget {
  const HcaLabResultsView({super.key});

  @override
  State<HcaLabResultsView> createState() => _HcaLabResultsViewState();
}

class _HcaLabResultsViewState extends State<HcaLabResultsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "";
  String selectedPeriod = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All Tests", "value": ""},
    {"label": "Blood Work", "value": "blood"},
    {"label": "Urine Tests", "value": "urine"},
    {"label": "Imaging", "value": "imaging"},
    {"label": "Cardiology", "value": "cardiology"},
    {"label": "Pathology", "value": "pathology"},
    {"label": "Microbiology", "value": "microbiology"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "All Time", "value": ""},
    {"label": "Last 30 Days", "value": "30"},
    {"label": "Last 3 Months", "value": "90"},
    {"label": "Last 6 Months", "value": "180"},
    {"label": "Last Year", "value": "365"},
  ];

  List<Map<String, dynamic>> labResults = [
    {
      "id": "1",
      "testName": "Complete Blood Count (CBC)",
      "category": "blood",
      "orderDate": "2024-01-15",
      "resultDate": "2024-01-16",
      "status": "Completed",
      "priority": "Normal",
      "doctor": "Dr. Sarah Johnson",
      "lab": "Metropolitan Lab Services",
      "summary": "All values within normal range",
      "abnormalResults": 0,
      "totalTests": 12,
      "flagged": false,
      "results": [
        {"name": "White Blood Cells", "value": "7.2", "unit": "K/uL", "range": "4.5-11.0", "status": "Normal"},
        {"name": "Red Blood Cells", "value": "4.8", "unit": "M/uL", "range": "4.2-5.8", "status": "Normal"},
        {"name": "Hemoglobin", "value": "14.5", "unit": "g/dL", "range": "12.0-16.0", "status": "Normal"},
        {"name": "Hematocrit", "value": "42.3", "unit": "%", "range": "36.0-48.0", "status": "Normal"},
        {"name": "Platelets", "value": "285", "unit": "K/uL", "range": "150-450", "status": "Normal"},
        {"name": "Neutrophils", "value": "58", "unit": "%", "range": "50-70", "status": "Normal"},
        {"name": "Lymphocytes", "value": "32", "unit": "%", "range": "20-40", "status": "Normal"},
        {"name": "Monocytes", "value": "8", "unit": "%", "range": "2-10", "status": "Normal"},
        {"name": "Eosinophils", "value": "2", "unit": "%", "range": "1-4", "status": "Normal"},
        {"name": "Basophils", "value": "0.5", "unit": "%", "range": "0-2", "status": "Normal"},
        {"name": "Mean Corpuscular Volume", "value": "88", "unit": "fL", "range": "80-100", "status": "Normal"},
        {"name": "Mean Corpuscular Hemoglobin", "value": "30", "unit": "pg", "range": "27-33", "status": "Normal"}
      ]
    },
    {
      "id": "2",
      "testName": "Comprehensive Metabolic Panel",
      "category": "blood",
      "orderDate": "2024-01-10",
      "resultDate": "2024-01-11",
      "status": "Completed",
      "priority": "High",
      "doctor": "Dr. Michael Chen",
      "lab": "Heart & Vascular Lab",
      "summary": "Glucose slightly elevated, cholesterol high",
      "abnormalResults": 2,
      "totalTests": 14,
      "flagged": true,
      "results": [
        {"name": "Glucose", "value": "125", "unit": "mg/dL", "range": "70-100", "status": "High"},
        {"name": "Sodium", "value": "142", "unit": "mEq/L", "range": "136-145", "status": "Normal"},
        {"name": "Potassium", "value": "4.2", "unit": "mEq/L", "range": "3.5-5.0", "status": "Normal"},
        {"name": "Chloride", "value": "101", "unit": "mEq/L", "range": "98-107", "status": "Normal"},
        {"name": "CO2", "value": "24", "unit": "mEq/L", "range": "22-28", "status": "Normal"},
        {"name": "BUN", "value": "18", "unit": "mg/dL", "range": "7-20", "status": "Normal"},
        {"name": "Creatinine", "value": "1.0", "unit": "mg/dL", "range": "0.7-1.3", "status": "Normal"},
        {"name": "Total Protein", "value": "7.2", "unit": "g/dL", "range": "6.0-8.3", "status": "Normal"},
        {"name": "Albumin", "value": "4.1", "unit": "g/dL", "range": "3.5-5.0", "status": "Normal"},
        {"name": "Total Bilirubin", "value": "0.8", "unit": "mg/dL", "range": "0.2-1.2", "status": "Normal"},
        {"name": "AST", "value": "28", "unit": "U/L", "range": "10-40", "status": "Normal"},
        {"name": "ALT", "value": "32", "unit": "U/L", "range": "10-40", "status": "Normal"},
        {"name": "Alkaline Phosphatase", "value": "85", "unit": "U/L", "range": "44-147", "status": "Normal"},
        {"name": "Total Cholesterol", "value": "245", "unit": "mg/dL", "range": "<200", "status": "High"}
      ]
    },
    {
      "id": "3",
      "testName": "Thyroid Function Panel",
      "category": "blood",
      "orderDate": "2024-01-05",
      "resultDate": "2024-01-06",
      "status": "Completed",
      "priority": "Normal",
      "doctor": "Dr. Emily Rodriguez",
      "lab": "Endocrine Specialists Lab",
      "summary": "Thyroid function normal",
      "abnormalResults": 0,
      "totalTests": 4,
      "flagged": false,
      "results": [
        {"name": "TSH", "value": "2.1", "unit": "mIU/L", "range": "0.4-4.0", "status": "Normal"},
        {"name": "Free T4", "value": "1.2", "unit": "ng/dL", "range": "0.8-1.8", "status": "Normal"},
        {"name": "Free T3", "value": "3.1", "unit": "pg/mL", "range": "2.3-4.2", "status": "Normal"},
        {"name": "Reverse T3", "value": "18", "unit": "ng/dL", "range": "9-25", "status": "Normal"}
      ]
    },
    {
      "id": "4",
      "testName": "Urinalysis",
      "category": "urine",
      "orderDate": "2024-01-03",
      "resultDate": "2024-01-04",
      "status": "Completed",
      "priority": "Normal",
      "doctor": "Dr. Sarah Johnson",
      "lab": "Metropolitan Lab Services",
      "summary": "Normal urinalysis",
      "abnormalResults": 0,
      "totalTests": 10,
      "flagged": false,
      "results": [
        {"name": "Color", "value": "Yellow", "unit": "", "range": "Yellow", "status": "Normal"},
        {"name": "Clarity", "value": "Clear", "unit": "", "range": "Clear", "status": "Normal"},
        {"name": "Specific Gravity", "value": "1.015", "unit": "", "range": "1.003-1.030", "status": "Normal"},
        {"name": "pH", "value": "6.5", "unit": "", "range": "5.0-8.0", "status": "Normal"},
        {"name": "Protein", "value": "Negative", "unit": "", "range": "negative", "status": "Normal"},
        {"name": "Glucose", "value": "Negative", "unit": "", "range": "negative", "status": "Normal"},
        {"name": "Ketones", "value": "Negative", "unit": "", "range": "negative", "status": "Normal"},
        {"name": "Blood", "value": "Negative", "unit": "", "range": "negative", "status": "Normal"},
        {"name": "Nitrites", "value": "Negative", "unit": "", "range": "negative", "status": "Normal"},
        {"name": "Leukocyte Esterase", "value": "Negative", "unit": "", "range": "negative", "status": "Normal"}
      ]
    },
    {
      "id": "5",
      "testName": "Chest X-Ray",
      "category": "imaging",
      "orderDate": "2023-12-28",
      "resultDate": "2023-12-29",
      "status": "Completed",
      "priority": "Normal",
      "doctor": "Dr. Jennifer Kim",
      "lab": "Radiology Associates",
      "summary": "Clear chest X-ray, no abnormalities",
      "abnormalResults": 0,
      "totalTests": 1,
      "flagged": false,
      "results": [
        {"name": "Chest X-Ray Findings", "value": "Normal", "unit": "", "range": "Normal", "status": "Normal"}
      ],
      "imageUrl": "https://picsum.photos/400/300?random=1&keyword=xray"
    },
    {
      "id": "6",
      "testName": "Echocardiogram",
      "category": "cardiology",
      "orderDate": "2023-12-20",
      "resultDate": "2023-12-21",
      "status": "Completed",
      "priority": "Normal",
      "doctor": "Dr. Michael Chen",
      "lab": "Cardiac Imaging Center",
      "summary": "Normal cardiac function",
      "abnormalResults": 0,
      "totalTests": 8,
      "flagged": false,
      "results": [
        {"name": "Ejection Fraction", "value": "65", "unit": "%", "range": "55-70", "status": "Normal"},
        {"name": "Left Ventricular Wall Motion", "value": "Normal", "unit": "", "range": "Normal", "status": "Normal"},
        {"name": "Mitral Valve", "value": "Normal", "unit": "", "range": "Normal", "status": "Normal"},
        {"name": "Aortic Valve", "value": "Normal", "unit": "", "range": "Normal", "status": "Normal"},
        {"name": "Tricuspid Valve", "value": "Normal", "unit": "", "range": "Normal", "status": "Normal"},
        {"name": "Pulmonary Valve", "value": "Normal", "unit": "", "range": "Normal", "status": "Normal"},
        {"name": "Pericardium", "value": "Normal", "unit": "", "range": "Normal", "status": "Normal"},
        {"name": "Estimated Pulmonary Pressure", "value": "25", "unit": "mmHg", "range": "15-30", "status": "Normal"}
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredResults {
    return labResults.where((result) {
      bool matchesSearch = searchQuery.isEmpty || 
          result["testName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          result["doctor"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          result["summary"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || 
          result["category"].toString().toLowerCase() == selectedCategory.toLowerCase();
      
      bool matchesPeriod = selectedPeriod.isEmpty || _isWithinPeriod(result["resultDate"], selectedPeriod);
      
      return matchesSearch && matchesCategory && matchesPeriod;
    }).toList();
  }

  bool _isWithinPeriod(String dateString, String period) {
    if (period.isEmpty) return true;
    
    DateTime resultDate = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    int daysDifference = now.difference(resultDate).inDays;
    
    return daysDifference <= int.parse(period);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab Results"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ss("Viewing lab result notifications");
            },
          ),
          IconButton(
            icon: Icon(Icons.cloud_download),
            onPressed: () {
              ss("Syncing lab results");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          _buildTabSection(),
          _buildSummarySection(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Icon(
                    Icons.search,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search lab tests, doctors...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: disabledColor,
                        fontSize: 14,
                      ),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
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

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildTab("All Results", 0),
          _buildTab("Flagged", 1),
          _buildTab("Recent", 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    List<Map<String, dynamic>> displayResults = filteredResults;
    
    if (selectedTab == 1) {
      displayResults = filteredResults.where((r) => r["flagged"]).toList();
    } else if (selectedTab == 2) {
      displayResults = filteredResults.take(5).toList();
    }

    int totalTests = displayResults.fold(0, (sum, result) => sum + (result["totalTests"] as int));
    int abnormalTests = displayResults.fold(0, (sum, result) => sum + (result["abnormalResults"] as int));
    int flaggedResults = displayResults.where((r) => r["flagged"]).length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 100,
        children: [
          _buildSummaryCard("Total Tests", totalTests.toString(), Icons.science, infoColor),
          _buildSummaryCard("Abnormal", abnormalTests.toString(), Icons.warning, warningColor),
          _buildSummaryCard("Flagged", flaggedResults.toString(), Icons.flag, dangerColor),
          _buildSummaryCard("Normal", (totalTests - abnormalTests).toString(), Icons.check_circle, successColor),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    List<Map<String, dynamic>> displayResults = filteredResults;
    
    if (selectedTab == 1) {
      displayResults = filteredResults.where((r) => r["flagged"]).toList();
    } else if (selectedTab == 2) {
      displayResults = filteredResults.take(5).toList();
    }

    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(spMd),
        children: [
          if (displayResults.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.science,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No lab results found",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search criteria",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...displayResults.map((result) => _buildResultCard(result)).toList(),
        ],
      ),
    );
  }

  Widget _buildResultCard(Map<String, dynamic> result) {
    Color statusColor = result["flagged"] ? dangerColor : 
                       result["abnormalResults"] > 0 ? warningColor : successColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    _getCategoryIcon(result["category"]),
                    color: statusColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${result["testName"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${result["doctor"]} • ${result["lab"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (result["flagged"])
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "FLAGGED",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: primaryColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Result Date",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${DateTime.parse(result["resultDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 14,
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
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.assignment,
                              color: primaryColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Tests Count",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${result["totalTests"]} tests",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.summarize,
                        color: statusColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Summary:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${result["summary"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (result["abnormalResults"] > 0) ...[
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(40)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: warningColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${result["abnormalResults"]} abnormal results found",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      _showResultDetails(result);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () {
                    ss("Sharing lab result");
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Downloading lab result");
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.print,
                  size: bs.sm,
                  onPressed: () {
                    ss("Printing lab result");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'blood':
        return Icons.bloodtype;
      case 'urine':
        return Icons.local_hospital;
      case 'imaging':
        return Icons.medical_services;
      case 'cardiology':
        return Icons.favorite;
      case 'pathology':
        return Icons.biotech;
      case 'microbiology':
        return Icons.science;
      default:
        return Icons.science;
    }
  }

  void _showResultDetails(Map<String, dynamic> result) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${result["testName"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (result["imageUrl"] != null) ...[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            image: DecorationImage(
                              image: NetworkImage("${result["imageUrl"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: spMd),
                      ],
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Test Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Order Date: ${DateTime.parse(result["orderDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.assignment_turned_in,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Result Date: ${DateTime.parse(result["resultDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Doctor: ${result["doctor"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_hospital,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Lab: ${result["lab"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Test Results",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...((result["results"] as List).map((testResult) {
                        Color resultColor = testResult["status"] == "Normal" ? successColor :
                                          testResult["status"] == "High" ? dangerColor :
                                          testResult["status"] == "Low" ? warningColor : infoColor;
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${testResult["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (testResult["range"].toString().isNotEmpty)
                                      Text(
                                        "Normal Range: ${testResult["range"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${testResult["value"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: resultColor,
                                        ),
                                      ),
                                      if (testResult["unit"].toString().isNotEmpty)
                                        Text(
                                          " ${testResult["unit"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: resultColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${testResult["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: resultColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Download Report",
                        icon: Icons.download,
                        onPressed: () {
                          Navigator.pop(context);
                          ss("Downloading full lab report");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Sharing lab result");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
