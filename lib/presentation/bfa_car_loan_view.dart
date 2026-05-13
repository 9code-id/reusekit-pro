import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCarLoanView extends StatefulWidget {
  const BfaCarLoanView({super.key});

  @override
  State<BfaCarLoanView> createState() => _BfaCarLoanViewState();
}

class _BfaCarLoanViewState extends State<BfaCarLoanView> {
  int selectedTab = 0;
  String selectedCarType = "new";

  List<Map<String, dynamic>> carLoanOffers = [
    {
      "bankName": "Auto Finance Bank",
      "logo": "https://picsum.photos/60/60?random=21",
      "interestRate": 7.5,
      "maxAmount": 2000000,
      "tenure": "1-7 years",
      "processingFee": "1%",
      "ltvRatio": "90%",
      "features": ["Zero down payment", "Instant approval", "Flexible tenure"],
      "rating": 4.5,
      "totalReviews": 1850
    },
    {
      "bankName": "Vehicle Loans Ltd",
      "logo": "https://picsum.photos/60/60?random=22",
      "interestRate": 8.2,
      "maxAmount": 1500000,
      "tenure": "2-5 years",
      "processingFee": "0.5%",
      "ltvRatio": "85%",
      "features": ["Low processing fee", "Quick disbursal", "Competitive rates"],
      "rating": 4.3,
      "totalReviews": 1200
    },
    {
      "bankName": "Motor Credit Corp",
      "logo": "https://picsum.photos/60/60?random=23",
      "interestRate": 8.8,
      "maxAmount": 1000000,
      "tenure": "1-6 years",
      "processingFee": "1.5%",
      "ltvRatio": "80%",
      "features": ["Simple documentation", "Digital process", "Fast approval"],
      "rating": 4.1,
      "totalReviews": 950
    },
  ];

  List<Map<String, dynamic>> carTypes = [
    {
      "type": "New Car",
      "description": "Brand new vehicles from dealers",
      "icon": Icons.directions_car,
      "color": primaryColor,
      "maxLoan": "90% of car value",
      "interestRate": "7.5% onwards"
    },
    {
      "type": "Used Car",
      "description": "Pre-owned vehicles",
      "icon": Icons.time_to_leave,
      "color": warningColor,
      "maxLoan": "80% of car value",
      "interestRate": "9% onwards"
    },
    {
      "type": "Commercial Vehicle",
      "description": "Trucks, buses, and commercial vehicles",
      "icon": Icons.local_shipping,
      "color": infoColor,
      "maxLoan": "75% of vehicle value",
      "interestRate": "10% onwards"
    },
    {
      "type": "Two Wheeler",
      "description": "Motorcycles and scooters",
      "icon": Icons.two_wheeler,
      "color": successColor,
      "maxLoan": "95% of vehicle value",
      "interestRate": "11% onwards"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Car Loan",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Offers", icon: Icon(Icons.local_offer)),
        Tab(text: "Calculator", icon: Icon(Icons.calculate)),
        Tab(text: "Vehicle Types", icon: Icon(Icons.directions_car)),
      ],
      tabChildren: [
        _buildOffersTab(),
        _buildCalculatorTab(),
        _buildVehicleTypesTab(),
      ],
    );
  }

  Widget _buildOffersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCarLoanHeader(),
          _buildCarTypeSelector(),
          _buildLoanOffers(),
        ],
      ),
    );
  }

  Widget _buildCarLoanHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_car,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Car Loan",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Drive your dream car home with our attractive car loan offers",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: spSm),
            child: Row(
              children: [
                Expanded(
                  child: _buildHeaderStat("Loan Amount", "Up to ₹20 L", Icons.currency_rupee),
                ),
                Container(width: 1, height: 50, color: Colors.white.withAlpha(100)),
                Expanded(
                  child: _buildHeaderStat("Interest Rate", "Starting 7.5%", Icons.percent),
                ),
                Container(width: 1, height: 50, color: Colors.white.withAlpha(100)),
                Expanded(
                  child: _buildHeaderStat("Approval", "In 24 hours", Icons.schedule),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withAlpha(200),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCarTypeSelector() {
    List<Map<String, dynamic>> options = [
      {"label": "New Car", "value": "new"},
      {"label": "Used Car", "value": "used"},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vehicle Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: List.generate(options.length, (index) {
              final option = options[index];
              bool isSelected = selectedCarType == option["value"];
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedCarType = option["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: index < options.length - 1 ? spSm : 0),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "${option["label"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanOffers() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${selectedCarType == "new" ? "New" : "Used"} Car Loan Offers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Filter offers
              },
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ...List.generate(carLoanOffers.length, (index) {
          final offer = carLoanOffers[index];
          double adjustedRate = selectedCarType == "used" 
              ? (offer["interestRate"] as double) + 1.5 
              : (offer["interestRate"] as double);
          
          return Container(
            padding: EdgeInsets.all(spMd),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${offer["logo"]}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${offer["bankName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              ...List.generate(5, (starIndex) {
                                return Icon(
                                  starIndex < (offer["rating"] as double).floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: warningColor,
                                  size: 12,
                                );
                              }),
                              SizedBox(width: spXs),
                              Text(
                                "${offer["rating"]} (${offer["totalReviews"]})",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${adjustedRate.toStringAsFixed(1)}% p.a.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildOfferDetail("Max Amount", "₹${((offer["maxAmount"] as int) / 100000).toStringAsFixed(0)} L"),
                    _buildOfferDetail("Tenure", "${offer["tenure"]}"),
                    _buildOfferDetail("Processing Fee", "${offer["processingFee"]}"),
                    _buildOfferDetail("Loan to Value", "${offer["ltvRatio"]}"),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Key Features:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (offer["features"] as List).map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Check Eligibility",
                        size: bs.sm,
                        onPressed: () {
                          // Check eligibility
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Apply Now",
                        size: bs.sm,
                        onPressed: () {
                          // Apply for loan
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildOfferDetail(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorTab() {
    String carPrice = "800000";
    String downPayment = "160000";
    String interestRate = "8.5";
    String tenure = "5";
    
    double loanAmount = (double.tryParse(carPrice) ?? 0) - (double.tryParse(downPayment) ?? 0);
    double monthlyEmi = _calculateEmi(loanAmount, double.tryParse(interestRate) ?? 0, int.tryParse(tenure) ?? 0);
    double totalAmount = monthlyEmi * (int.tryParse(tenure) ?? 0) * 12;
    double totalInterest = totalAmount - loanAmount;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Car Loan EMI Calculator",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QNumberField(
                  label: "Car Price (₹)",
                  value: carPrice,
                  onChanged: (value) {
                    carPrice = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Down Payment (₹)",
                  value: downPayment,
                  onChanged: (value) {
                    downPayment = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Interest Rate (% per annum)",
                  value: interestRate,
                  onChanged: (value) {
                    interestRate = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Loan Tenure (years)",
                  value: tenure,
                  onChanged: (value) {
                    tenure = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Calculate EMI",
                    size: bs.md,
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Text(
                  "EMI Calculation Results",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildResultCard("Loan Amount", "₹${loanAmount.currency}", Icons.account_balance),
                    ),
                    Container(width: 1, height: 60, color: Colors.white.withAlpha(100)),
                    Expanded(
                      child: _buildResultCard("Monthly EMI", "₹${monthlyEmi.currency}", Icons.payment),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildResultCard("Total Interest", "₹${totalInterest.currency}", Icons.trending_up),
                    ),
                    Container(width: 1, height: 60, color: Colors.white.withAlpha(100)),
                    Expanded(
                      child: _buildResultCard("Total Amount", "₹${totalAmount.currency}", Icons.account_balance_wallet),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildInsuranceCard(),
        ],
      ),
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withAlpha(200),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildInsuranceCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.shield,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Car Insurance & Protection",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Protect your investment with comprehensive car insurance coverage",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Comprehensive Insurance:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "₹15,000 - ₹25,000/year",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Extended Warranty:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "₹8,000 - ₹15,000",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Get Insurance Quote",
              size: bs.sm,
              onPressed: () {
                // Get insurance quote
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleTypesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildVehicleTypesHeader(),
          _buildVehicleTypesList(),
          _buildDocumentRequirements(),
        ],
      ),
    );
  }

  Widget _buildVehicleTypesHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [infoColor, infoColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_car,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Vehicle Types & Financing",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Different financing options for various types of vehicles",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleTypesList() {
    return Column(
      spacing: spSm,
      children: List.generate(carTypes.length, (index) {
        final carType = carTypes[index];
        
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (carType["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  carType["icon"],
                  color: carType["color"],
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${carType["type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${carType["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${carType["maxLoan"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: (carType["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${carType["interestRate"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: carType["color"],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.arrow_forward,
                size: bs.sm,
                onPressed: () {
                  // View details
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDocumentRequirements() {
    List<Map<String, dynamic>> documents = [
      {
        "category": "Identity & Address Proof",
        "documents": ["PAN Card", "Aadhaar Card", "Passport", "Utility Bills"],
        "icon": Icons.badge,
        "color": primaryColor
      },
      {
        "category": "Income Proof",
        "documents": ["Salary Slips", "Bank Statements", "ITR", "Form 16"],
        "icon": Icons.receipt_long,
        "color": successColor
      },
      {
        "category": "Vehicle Documents",
        "documents": ["Quotation", "Invoice", "RC (for used cars)", "Insurance"],
        "icon": Icons.description,
        "color": infoColor
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Required Documents",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(documents.length, (index) {
            final docCategory = documents[index];
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (docCategory["color"] as Color).withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        docCategory["icon"],
                        color: docCategory["color"],
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${docCategory["category"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: docCategory["color"],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Required: ${(docCategory["documents"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 11,
                      color: docCategory["color"],
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Additional documents may be required based on lender requirements and your profile.",
                    style: TextStyle(
                      fontSize: 11,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateEmi(double principal, double rate, int years) {
    if (principal <= 0 || rate <= 0 || years <= 0) return 0;
    
    double monthlyRate = rate / 100 / 12;
    int months = years * 12;
    
    if (monthlyRate == 0) return principal / months;
    
    double emi = principal * monthlyRate * (pow(1 + monthlyRate, months)) / 
                 ((pow(1 + monthlyRate, months)) - 1);
    return emi;
  }

  double pow(double base, int exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
}
