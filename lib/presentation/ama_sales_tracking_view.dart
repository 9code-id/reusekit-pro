import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSalesTrackingView extends StatefulWidget {
  const AmaSalesTrackingView({super.key});

  @override
  State<AmaSalesTrackingView> createState() => _AmaSalesTrackingViewState();
}

class _AmaSalesTrackingViewState extends State<AmaSalesTrackingView> {
  int selectedTab = 0;
  String selectedPeriod = "This Month";
  String selectedCrop = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "All Crops", "value": "All"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Soybeans", "value": "Soybeans"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Shipped", "value": "Shipped"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> salesData = [
    {
      "id": "SAL-2024-001",
      "date": "2024-12-15",
      "buyer": "Green Valley Foods",
      "crop": "Rice",
      "variety": "Basmati",
      "quantity": 500.0,
      "unit": "kg",
      "pricePerUnit": 50.25,
      "totalAmount": 25125.0,
      "status": "Completed",
      "paymentStatus": "Paid",
      "deliveryDate": "2024-12-18",
      "location": "Regional Market",
    },
    {
      "id": "SAL-2024-002",
      "date": "2024-12-14",
      "buyer": "Harvest Trading Co.",
      "crop": "Wheat",
      "variety": "Hard Red",
      "quantity": 750.0,
      "unit": "kg",
      "pricePerUnit": 35.80,
      "totalAmount": 26850.0,
      "status": "Shipped",
      "paymentStatus": "Paid",
      "deliveryDate": "2024-12-16",
      "location": "Local Market",
    },
    {
      "id": "SAL-2024-003",
      "date": "2024-12-13",
      "buyer": "AgriCorp Solutions",
      "crop": "Corn",
      "variety": "Sweet Corn",
      "quantity": 1200.0,
      "unit": "kg",
      "pricePerUnit": 28.90,
      "totalAmount": 34680.0,
      "status": "Pending",
      "paymentStatus": "Pending",
      "deliveryDate": "2024-12-20",
      "location": "International Market",
    },
    {
      "id": "SAL-2024-004",
      "date": "2024-12-12",
      "buyer": "Premium Grains Ltd",
      "crop": "Soybeans",
      "variety": "Organic",
      "quantity": 400.0,
      "unit": "kg",
      "pricePerUnit": 65.40,
      "totalAmount": 26160.0,
      "status": "Completed",
      "paymentStatus": "Paid",
      "deliveryDate": "2024-12-15",
      "location": "Regional Market",
    },
    {
      "id": "SAL-2024-005",
      "date": "2024-12-10",
      "buyer": "Farm Fresh Distributors",
      "crop": "Rice",
      "variety": "Jasmine",
      "quantity": 800.0,
      "unit": "kg",
      "pricePerUnit": 48.75,
      "totalAmount": 39000.0,
      "status": "Cancelled",
      "paymentStatus": "Refunded",
      "deliveryDate": "2024-12-13",
      "location": "Local Market",
    },
  ];

  List<Map<String, dynamic>> topBuyers = [
    {
      "name": "Green Valley Foods",
      "totalOrders": 15,
      "totalVolume": 4500.0,
      "totalValue": 185000.0,
      "lastOrder": "2024-12-15",
    },
    {
      "name": "Harvest Trading Co.",
      "totalOrders": 12,
      "totalVolume": 3800.0,
      "totalValue": 142000.0,
      "lastOrder": "2024-12-14",
    },
    {
      "name": "AgriCorp Solutions",
      "totalOrders": 8,
      "totalVolume": 2200.0,
      "totalValue": 98000.0,
      "lastOrder": "2024-12-13",
    },
  ];

  List<Map<String, dynamic>> monthlySales = [
    {"month": "Jan", "sales": 145000.0, "volume": 2800.0},
    {"month": "Feb", "sales": 165000.0, "volume": 3200.0},
    {"month": "Mar", "sales": 178000.0, "volume": 3500.0},
    {"month": "Apr", "sales": 192000.0, "volume": 3800.0},
    {"month": "May", "sales": 210000.0, "volume": 4100.0},
    {"month": "Jun", "sales": 185000.0, "volume": 3600.0},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Sales Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Sales Orders", icon: Icon(Icons.receipt_long)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Buyers", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSalesOrdersTab(),
        _buildAnalyticsTab(),
        _buildBuyersTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    double totalSales = salesData.where((sale) => sale["status"] != "Cancelled")
        .fold(0.0, (sum, sale) => sum + (sale["totalAmount"] as double));
    double totalVolume = salesData.where((sale) => sale["status"] != "Cancelled")
        .fold(0.0, (sum, sale) => sum + (sale["quantity"] as double));
    int completedOrders = salesData.where((sale) => sale["status"] == "Completed").length;
    int pendingOrders = salesData.where((sale) => sale["status"] == "Pending").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sales Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Sales",
                "\$${totalSales.currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildStatCard(
                "Total Volume",
                "${totalVolume.toStringAsFixed(0)} kg",
                Icons.scale,
                infoColor,
              ),
              _buildStatCard(
                "Completed Orders",
                "$completedOrders",
                Icons.check_circle,
                primaryColor,
              ),
              _buildStatCard(
                "Pending Orders",
                "$pendingOrders",
                Icons.pending,
                warningColor,
              ),
            ],
          ),
          Text(
            "Recent Sales",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: salesData.take(3).map((sale) => _buildSaleCard(sale)).toList(),
          ),
          QButton(
            label: "View All Sales",
            size: bs.md,
            onPressed: () {
              setState(() {
                selectedTab = 1;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSalesOrdersTab() {
    List<Map<String, dynamic>> filteredSales = salesData.where((sale) {
      bool matchesCrop = selectedCrop == "All" || sale["crop"] == selectedCrop;
      bool matchesStatus = selectedStatus == "All" || sale["status"] == selectedStatus;
      return matchesCrop && matchesStatus;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  label: "Crop",
                  items: cropOptions,
                  value: selectedCrop,
                  onChanged: (value, label) {
                    selectedCrop = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
          Text(
            "Sales Orders (${filteredSales.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: filteredSales.map((sale) => _buildDetailedSaleCard(sale)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sales Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 250,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monthly Sales Trend",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: monthlySales.map((data) => _buildSalesBar(data)).toList(),
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: monthlySales.map((data) => _buildMonthLabel(data)).toList(),
                ),
              ],
            ),
          ),
          Text(
            "Crop Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildCropPerformanceCard("Rice", 8, 65000.0, 15.2),
              _buildCropPerformanceCard("Wheat", 6, 42000.0, 8.7),
              _buildCropPerformanceCard("Corn", 4, 35000.0, 12.3),
              _buildCropPerformanceCard("Soybeans", 3, 28000.0, 6.8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBuyersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Buyers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: topBuyers.map((buyer) => _buildBuyerCard(buyer)).toList(),
          ),
          QButton(
            label: "View All Buyers",
            size: bs.md,
            onPressed: () {
              //navigateTo AmaBuyerDirectoryView
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 20),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaleCard(Map<String, dynamic> sale) {
    Color statusColor = sale["status"] == "Completed" ? successColor :
                       sale["status"] == "Shipped" ? infoColor :
                       sale["status"] == "Pending" ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${sale["id"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${sale["buyer"]}",
                  style: TextStyle(color: disabledBoldColor, fontSize: 12),
                ),
                Text(
                  "${sale["crop"]} - ${(sale["quantity"] as num).toStringAsFixed(0)} kg",
                  style: TextStyle(color: disabledBoldColor, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${(sale["totalAmount"] as double).currency}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: successColor,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${sale["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedSaleCard(Map<String, dynamic> sale) {
    Color statusColor = sale["status"] == "Completed" ? successColor :
                       sale["status"] == "Shipped" ? infoColor :
                       sale["status"] == "Pending" ? warningColor : dangerColor;

    Color paymentColor = sale["paymentStatus"] == "Paid" ? successColor :
                        sale["paymentStatus"] == "Pending" ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Text(
                  "${sale["id"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${sale["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Buyer", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("${sale["buyer"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("${sale["date"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("${sale["crop"]} - ${sale["variety"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quantity", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("${(sale["quantity"] as num).toStringAsFixed(0)} ${sale["unit"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Unit Price", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("\$${(sale["pricePerUnit"] as num).toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Amount", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("\$${(sale["totalAmount"] as double).currency}", style: TextStyle(fontWeight: FontWeight.bold, color: successColor)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text("Payment: ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: paymentColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${sale["paymentStatus"]}",
                        style: TextStyle(
                          color: paymentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text("Delivery: ${sale["deliveryDate"]}", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalesBar(Map<String, dynamic> data) {
    double sales = (data["sales"] as num).toDouble();
    double maxSales = monthlySales.map((e) => e["sales"] as num).reduce((a, b) => a > b ? a : b).toDouble();
    double height = (sales / maxSales) * 150;

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthLabel(Map<String, dynamic> data) {
    return Expanded(
      child: Text(
        "${data["month"]}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildCropPerformanceCard(String crop, int orders, double revenue, double growth) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            crop,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Orders", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("$orders", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Revenue", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("\$${revenue.currency}", style: TextStyle(fontWeight: FontWeight.bold, color: successColor)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.trending_up, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "+${growth.toStringAsFixed(1)}%",
                style: TextStyle(
                  color: successColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBuyerCard(Map<String, dynamic> buyer) {
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
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(Icons.business, color: primaryColor, size: 24),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${buyer["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text("${buyer["totalOrders"]} orders", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text(" • ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                    Text("${(buyer["totalVolume"] as num).toStringAsFixed(0)} kg", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                  ],
                ),
                Text("Last order: ${buyer["lastOrder"]}", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
              ],
            ),
          ),
          Text(
            "\$${(buyer["totalValue"] as double).currency}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }
}
