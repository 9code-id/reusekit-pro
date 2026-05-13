import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaBankListView extends StatefulWidget {
  const ReaBankListView({super.key});

  @override
  State<ReaBankListView> createState() => _ReaBankListViewState();
}

class _ReaBankListViewState extends State<ReaBankListView> {
  String searchQuery = "";
  String selectedBankType = "All";
  String sortBy = "interest_rate";

  List<Map<String, dynamic>> bankTypes = [
    {"label": "All", "value": "all"},
    {"label": "Public Banks", "value": "public"},
    {"label": "Private Banks", "value": "private"},
    {"label": "NBFC", "value": "nbfc"},
    {"label": "Cooperative Banks", "value": "cooperative"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Lowest Interest Rate", "value": "interest_rate"},
    {"label": "Highest Processing Speed", "value": "processing_speed"},
    {"label": "Best Customer Rating", "value": "rating"},
    {"label": "Minimum Documentation", "value": "documentation"},
  ];

  List<Map<String, dynamic>> banks = [
    {
      "id": "1",
      "name": "State Bank of America",
      "logo": "https://picsum.photos/80/80?random=301&keyword=bank",
      "type": "public",
      "interestRate": 8.25,
      "maxLoanAmount": 5000000,
      "minLoanAmount": 100000,
      "processingFee": 0.50,
      "processingTime": "7-10 days",
      "customerRating": 4.2,
      "totalReviews": 8934,
      "features": ["Pre-approved loans", "Flexible EMI", "Quick processing"],
      "eligibilityCriteria": [
        "Minimum age: 21 years",
        "Maximum age: 65 years",
        "Minimum income: \$3,000/month",
        "Credit score: 650+"
      ],
      "documentation": "Minimal",
      "specialOffers": ["0% processing fee for government employees"],
      "loanToValue": 80,
      "prepaymentCharges": "Nil after 1 year"
    },
    {
      "id": "2",
      "name": "HDFC Home Loans",
      "logo": "https://picsum.photos/80/80?random=302&keyword=building",
      "type": "private",
      "interestRate": 8.40,
      "maxLoanAmount": 10000000,
      "minLoanAmount": 100000,
      "processingFee": 0.35,
      "processingTime": "5-7 days",
      "customerRating": 4.5,
      "totalReviews": 12456,
      "features": ["Digital approval", "Doorstep service", "Balance transfer"],
      "eligibilityCriteria": [
        "Minimum age: 21 years",
        "Maximum age: 65 years",
        "Minimum income: \$2,500/month",
        "Credit score: 700+"
      ],
      "documentation": "Standard",
      "specialOffers": ["Cashback on loan approval", "Free property valuation"],
      "loanToValue": 85,
      "prepaymentCharges": "2% for first 2 years"
    },
    {
      "id": "3",
      "name": "ICICI Bank",
      "logo": "https://picsum.photos/80/80?random=303&keyword=finance",
      "type": "private",
      "interestRate": 8.35,
      "maxLoanAmount": 7500000,
      "minLoanAmount": 200000,
      "processingFee": 0.50,
      "processingTime": "6-8 days",
      "customerRating": 4.3,
      "totalReviews": 9876,
      "features": ["Online application", "Quick sanction", "Multiple repayment options"],
      "eligibilityCriteria": [
        "Minimum age: 23 years",
        "Maximum age: 60 years",
        "Minimum income: \$3,500/month",
        "Credit score: 720+"
      ],
      "documentation": "Standard",
      "specialOffers": ["Special rates for women borrowers"],
      "loanToValue": 80,
      "prepaymentCharges": "1.5% for first year"
    },
    {
      "id": "4",
      "name": "LIC Housing Finance",
      "logo": "https://picsum.photos/80/80?random=304&keyword=house",
      "type": "nbfc",
      "interestRate": 8.50,
      "maxLoanAmount": 3000000,
      "minLoanAmount": 100000,
      "processingFee": 0.25,
      "processingTime": "10-15 days",
      "customerRating": 4.0,
      "totalReviews": 5432,
      "features": ["Lower processing fee", "Flexible tenure", "Construction finance"],
      "eligibilityCriteria": [
        "Minimum age: 18 years",
        "Maximum age: 70 years",
        "Minimum income: \$2,000/month",
        "Credit score: 600+"
      ],
      "documentation": "Minimal",
      "specialOffers": ["Special rates for senior citizens"],
      "loanToValue": 75,
      "prepaymentCharges": "Nil"
    },
    {
      "id": "5",
      "name": "Axis Bank",
      "logo": "https://picsum.photos/80/80?random=305&keyword=money",
      "type": "private",
      "interestRate": 8.45,
      "maxLoanAmount": 5000000,
      "minLoanAmount": 500000,
      "processingFee": 1.00,
      "processingTime": "7-12 days",
      "customerRating": 4.1,
      "totalReviews": 6789,
      "features": ["Express approval", "Home loan against property", "Top-up loans"],
      "eligibilityCriteria": [
        "Minimum age: 21 years",
        "Maximum age: 60 years",
        "Minimum income: \$4,000/month",
        "Credit score: 750+"
      ],
      "documentation": "Comprehensive",
      "specialOffers": ["No prepayment charges for floating rate"],
      "loanToValue": 85,
      "prepaymentCharges": "Nil for floating rate"
    },
    {
      "id": "6",
      "name": "PNB Housing Finance",
      "logo": "https://picsum.photos/80/80?random=306&keyword=home",
      "type": "nbfc",
      "interestRate": 8.55,
      "maxLoanAmount": 2500000,
      "minLoanAmount": 100000,
      "processingFee": 0.50,
      "processingTime": "8-10 days",
      "customerRating": 3.9,
      "totalReviews": 4321,
      "features": ["Rural housing loans", "Affordable housing", "NRI loans"],
      "eligibilityCriteria": [
        "Minimum age: 21 years",
        "Maximum age: 65 years",
        "Minimum income: \$2,500/month",
        "Credit score: 650+"
      ],
      "documentation": "Standard",
      "specialOffers": ["Special scheme for first-time buyers"],
      "loanToValue": 80,
      "prepaymentCharges": "2% for first 3 years"
    }
  ];

  List<Map<String, dynamic>> get filteredBanks {
    var filtered = banks.where((bank) {
      bool matchesType = selectedBankType == "All" || bank["type"] == selectedBankType.toLowerCase().replaceAll(" banks", "").replaceAll(" ", "_");
      bool matchesSearch = searchQuery.isEmpty || 
        "${bank["name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
    
    // Sort banks
    filtered.sort((a, b) {
      switch (sortBy) {
        case "processing_speed":
          String aTime = "${a["processingTime"]}".split("-")[0];
          String bTime = "${b["processingTime"]}".split("-")[0];
          return int.parse(aTime).compareTo(int.parse(bTime));
        case "rating":
          return (b["customerRating"] as double).compareTo(a["customerRating"] as double);
        case "documentation":
          Map<String, int> docPriority = {"Minimal": 1, "Standard": 2, "Comprehensive": 3};
          return docPriority[a["documentation"]]!.compareTo(docPriority[b["documentation"]]!);
        default: // interest_rate
          return (a["interestRate"] as double).compareTo(b["interestRate"] as double);
      }
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banks & Lenders"),
        actions: [
          IconButton(
            icon: Icon(Icons.compare),
            onPressed: () {
              // Navigate to comparison view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search banks",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Home Loan Lenders",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Compare and choose the best loan offer",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filter Section
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Bank Type",
                    items: bankTypes,
                    value: selectedBankType,
                    onChanged: (value, label) {
                      selectedBankType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredBanks.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Lenders",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredBanks.isNotEmpty ? (filteredBanks.map((b) => b["interestRate"] as double).reduce((a, b) => a < b ? a : b)).toStringAsFixed(2) : '0'}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Best Rate",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${filteredBanks.isNotEmpty ? ((filteredBanks.map((b) => b["maxLoanAmount"] as int).reduce((a, b) => a > b ? a : b)) / 1000000).toStringAsFixed(1) : '0'}M",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Max Loan",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Text(
              "${filteredBanks.length} Lenders Available",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            // Bank List
            ...filteredBanks.map((bank) {
              Color typeColor = bank["type"] == "public" ? primaryColor :
                              bank["type"] == "private" ? infoColor :
                              bank["type"] == "nbfc" ? warningColor :
                              successColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bank Header
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${bank["logo"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${bank["name"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: typeColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${bank["type"]}".toUpperCase(),
                                    style: TextStyle(
                                      color: typeColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${bank["customerRating"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "(${bank["totalReviews"]} reviews)",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Interest Rate Highlight
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      color: primaryColor.withAlpha(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.trending_down,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Interest Rate: ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${(bank["interestRate"] as double).toStringAsFixed(2)}% p.a.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Processing: ${bank["processingTime"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Key Details
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildDetailItem(
                                  "Loan Amount",
                                  "\$${((bank["minLoanAmount"] as int) / 1000).toInt()}K - \$${((bank["maxLoanAmount"] as int) / 1000000).toStringAsFixed(1)}M",
                                  Icons.account_balance_wallet,
                                ),
                              ),
                              Expanded(
                                child: _buildDetailItem(
                                  "Processing Fee",
                                  "${(bank["processingFee"] as double).toStringAsFixed(2)}%",
                                  Icons.receipt_long,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDetailItem(
                                  "Loan to Value",
                                  "${bank["loanToValue"]}%",
                                  Icons.pie_chart,
                                ),
                              ),
                              Expanded(
                                child: _buildDetailItem(
                                  "Documentation",
                                  "${bank["documentation"]}",
                                  Icons.description,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Features
                          Text(
                            "Key Features",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          QHorizontalScroll(
                            children: (bank["features"] as List).map((feature) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$feature",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          if ((bank["specialOffers"] as List).isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_offer,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${(bank["specialOffers"] as List)[0]}",
                                      style: TextStyle(
                                        color: warningColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Apply Now",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to loan comparison
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.compare_arrows),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryColor,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
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
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
