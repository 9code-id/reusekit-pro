import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaScheduleVisitView extends StatefulWidget {
  const ReaScheduleVisitView({super.key});

  @override
  State<ReaScheduleVisitView> createState() => _ReaScheduleVisitViewState();
}

class _ReaScheduleVisitViewState extends State<ReaScheduleVisitView> {
  String selectedDate = DateTime.now().add(Duration(days: 1)).toString();
  String selectedTime = "10:00";
  String visitType = "Physical Visit";
  String agentId = "1";
  String notes = "";
  String visitorName = "";
  String visitorPhone = "";
  String visitorEmail = "";
  int guestCount = 1;
  
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> visitTypes = [
    {"label": "Physical Visit", "value": "Physical Visit"},
    {"label": "Virtual Tour", "value": "Virtual Tour"},
    {"label": "Video Call", "value": "Video Call"},
  ];

  List<Map<String, dynamic>> agents = [
    {"label": "Sarah Johnson", "value": "1"},
    {"label": "Michael Chen", "value": "2"},
    {"label": "Emily Davis", "value": "3"},
    {"label": "David Wilson", "value": "4"},
  ];

  Map<String, dynamic> property = {
    "id": "1",
    "title": "Modern Luxury Villa",
    "address": "123 Ocean Drive, Miami Beach",
    "price": 2500000,
    "image": "https://picsum.photos/400/250?random=101&keyword=villa",
    "bedrooms": 4,
    "bathrooms": 3,
    "area": 3200,
    "type": "Villa",
  };

  List<String> availableTimes = [
    "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
    "12:00", "12:30", "13:00", "13:30", "14:00", "14:30",
    "15:00", "15:30", "16:00", "16:30", "17:00", "17:30",
  ];

  List<Map<String, dynamic>> requirements = [
    {"text": "Valid ID required", "icon": Icons.badge},
    {"text": "Appointment confirmation needed", "icon": Icons.confirmation_number},
    {"text": "Agent will contact you 30 minutes before", "icon": Icons.phone},
    {"text": "Please arrive 10 minutes early", "icon": Icons.access_time},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Visit"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildPropertyCard(),
                  _buildVisitorInfo(),
                  _buildScheduleDetails(),
                  _buildRequirements(),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildPropertyCard() {
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
            "Property Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${property["image"]}",
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${property["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${property["address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((property["price"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisitorInfo() {
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
            "Visitor Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Your Name",
            value: visitorName,
            validator: Validator.required,
            onChanged: (value) {
              visitorName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: visitorPhone,
                  validator: Validator.required,
                  onChanged: (value) {
                    visitorPhone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Email",
                  value: visitorEmail,
                  validator: Validator.email,
                  onChanged: (value) {
                    visitorEmail = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QNumberField(
            label: "Number of Guests",
            value: guestCount.toString(),
            validator: Validator.required,
            onChanged: (value) {
              guestCount = int.tryParse("$value") ?? 1;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleDetails() {
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
            "Schedule Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Visit Type",
            items: visitTypes,
            value: visitType,
            onChanged: (value, label) {
              visitType = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Preferred Agent",
            items: agents,
            value: agentId,
            onChanged: (value, label) {
              agentId = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDatePicker(
            label: "Visit Date",
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString();
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Text(
            "Available Times",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          _buildTimeSlots(),
          SizedBox(height: spMd),
          QMemoField(
            label: "Special Notes (Optional)",
            value: notes,
            hint: "Any special requirements or notes for the visit",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlots() {
    return Container(
      child: Column(
        children: [
          for (int i = 0; i < availableTimes.length; i += 3)
            Row(
              children: [
                for (int j = i; j < i + 3 && j < availableTimes.length; j++)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        right: j < i + 2 && j < availableTimes.length - 1 ? spXs : 0,
                        bottom: spXs,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          selectedTime = availableTimes[j];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTime == availableTimes[j] 
                              ? primaryColor 
                              : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: selectedTime == availableTimes[j] 
                                ? primaryColor 
                                : Colors.grey.shade300,
                            ),
                          ),
                          child: Text(
                            availableTimes[j],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTime == availableTimes[j] 
                                ? Colors.white 
                                : primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRequirements() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Visit Requirements",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...requirements.map((req) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: Row(
              children: [
                Icon(
                  req["icon"] as IconData,
                  size: 16,
                  color: infoColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${req["text"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Schedule Visit",
        onPressed: _scheduleVisit,
      ),
    );
  }

  void _scheduleVisit() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(seconds: 2));

      loading = false;
      setState(() {});

      ss("Visit scheduled successfully!");
      back();
    }
  }
}
