import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaAppointmentCalendarView extends StatefulWidget {
  const MhaAppointmentCalendarView({super.key});

  @override
  State<MhaAppointmentCalendarView> createState() => _MhaAppointmentCalendarViewState();
}

class _MhaAppointmentCalendarViewState extends State<MhaAppointmentCalendarView> {
  DateTime selectedDate = DateTime.now();
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Upcoming", "value": "upcoming"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];
  
  Map<String, List<Map<String, dynamic>>> appointmentsByDate = {
    "2024-06-14": [
      {
        "id": "1",
        "time": "10:00 AM",
        "doctor": "Dr. Sarah Johnson",
        "specialty": "Cardiology",
        "type": "In-Person",
        "status": "confirmed",
        "reason": "Heart checkup",
        "location": "City General Hospital",
        "avatar": "https://picsum.photos/50/50?random=1&keyword=doctor",
      },
      {
        "id": "2",
        "time": "3:00 PM",
        "doctor": "Dr. Michael Chen",
        "specialty": "General Medicine",
        "type": "Video Call",
        "status": "confirmed",
        "reason": "Follow-up consultation",
        "location": "Online",
        "avatar": "https://picsum.photos/50/50?random=2&keyword=doctor",
      },
    ],
    "2024-06-15": [
      {
        "id": "3",
        "time": "11:00 AM",
        "doctor": "Dr. Emily Rodriguez",
        "specialty": "Dermatology",
        "type": "In-Person",
        "status": "pending",
        "reason": "Skin examination",
        "location": "Derma Care Center",
        "avatar": "https://picsum.photos/50/50?random=3&keyword=doctor",
      },
    ],
    "2024-06-16": [
      {
        "id": "4",
        "time": "2:00 PM",
        "doctor": "Dr. Ahmed Hassan",
        "specialty": "Neurology",
        "type": "In-Person",
        "status": "completed",
        "reason": "Headache consultation",
        "location": "Neuro Specialist Center",
        "avatar": "https://picsum.photos/50/50?random=4&keyword=doctor",
      },
    ],
    "2024-06-17": [
      {
        "id": "5",
        "time": "9:00 AM",
        "doctor": "Dr. Jennifer Lee",
        "specialty": "Pediatrics",
        "type": "Video Call",
        "status": "cancelled",
        "reason": "Child health consultation",
        "location": "Online",
        "avatar": "https://picsum.photos/50/50?random=5&keyword=doctor",
      },
    ],
  };
  
  List<Map<String, dynamic>> get todayAppointments {
    String today = selectedDate.toString().split(' ')[0];
    List<Map<String, dynamic>> appointments = appointmentsByDate[today] ?? [];
    
    if (selectedFilter == "all") return appointments;
    return appointments.where((apt) => apt["status"] == selectedFilter).toList();
  }
  
  bool hasAppointmentOnDate(DateTime date) {
    String dateKey = date.toString().split(' ')[0];
    return appointmentsByDate.containsKey(dateKey) && 
           appointmentsByDate[dateKey]!.isNotEmpty;
  }
  
  Color getStatusColor(String status) {
    switch (status) {
      case "confirmed":
        return successColor;
      case "pending":
        return warningColor;
      case "completed":
        return primaryColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo(MhaBookAppointmentView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spMd,
              children: [
                QCategoryPicker(
                  label: "Filter Appointments",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (index, label, value, item) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
                
                Container(
                  height: 100,
                  child: QHorizontalScroll(
                    children: List.generate(30, (index) {
                      DateTime date = DateTime.now().add(Duration(days: index - 7));
                      bool isSelected = date.day == selectedDate.day &&
                                      date.month == selectedDate.month &&
                                      date.year == selectedDate.year;
                      bool isToday = date.day == DateTime.now().day &&
                                   date.month == DateTime.now().month &&
                                   date.year == DateTime.now().year;
                      bool hasAppointment = hasAppointmentOnDate(date);
                      
                      return GestureDetector(
                        onTap: () {
                          selectedDate = date;
                          setState(() {});
                        },
                        child: Container(
                          width: 70,
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: isSelected ? primaryColor : 
                                     isToday ? primaryColor : disabledColor,
                              width: isToday && !isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected ? [shadowSm] : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][date.weekday % 7],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${date.day}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              if (hasAppointment)
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : primaryColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: todayAppointments.isEmpty
                ? Container(
                    padding: EdgeInsets.all(spXl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 80,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No appointments",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "You don't have any appointments on ${selectedDate.dMMMy}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                        ),
                        SizedBox(height: spLg),
                        QButton(
                          label: "Book Appointment",
                          size: bs.md,
                          onPressed: () {
                            //navigateTo(MhaBookAppointmentView());
                          },
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Appointments for ${selectedDate.dMMMy}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${todayAppointments.length}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        ...todayAppointments.map((appointment) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: getStatusColor(appointment["status"]),
                                ),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(radiusMd),
                                onTap: () {
                                  //navigateTo(MhaAppointmentDetailView(appointmentId: appointment["id"]));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spMd),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(radiusLg),
                                              boxShadow: [shadowSm],
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(radiusLg),
                                              child: Image.network(
                                                "${appointment["avatar"]}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spMd),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "${appointment["doctor"]}",
                                                        style: TextStyle(
                                                          fontSize: fsH6,
                                                          fontWeight: FontWeight.bold,
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: spSm,
                                                        vertical: spXs,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: getStatusColor(appointment["status"]).withAlpha(20),
                                                        borderRadius: BorderRadius.circular(radiusXs),
                                                      ),
                                                      child: Text(
                                                        "${appointment["status"]}".toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.bold,
                                                          color: getStatusColor(appointment["status"]),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: spXs),
                                                Text(
                                                  "${appointment["specialty"]}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: disabledBoldColor,
                                                  ),
                                                ),
                                                SizedBox(height: spXs),
                                                Text(
                                                  "${appointment["reason"]}",
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
                                      SizedBox(height: spMd),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                color: disabledBoldColor,
                                                size: 16,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "${appointment["time"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: spMd),
                                          Row(
                                            children: [
                                              Icon(
                                                appointment["type"] == "Video Call" 
                                                    ? Icons.video_call
                                                    : Icons.location_on,
                                                color: disabledBoldColor,
                                                size: 16,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "${appointment["location"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          if (appointment["status"] == "confirmed") ...[
                                            if (appointment["type"] == "Video Call")
                                              QButton(
                                                label: "Join",
                                                size: bs.sm,
                                                onPressed: () {
                                                  //navigateTo(MhaVideoConsultationView(appointmentId: appointment["id"]));
                                                },
                                              )
                                            else
                                              QButton(
                                                label: "Directions",
                                                size: bs.sm,
                                                onPressed: () {
                                                  ss("Opening directions to ${appointment["location"]}");
                                                },
                                              ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          //navigateTo(MhaBookAppointmentView());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
