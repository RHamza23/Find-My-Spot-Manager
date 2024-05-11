// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class ManageVehicleModel {
//   final String vehicleName;
//   final String vehicleType;
//
//   ManageVehicleModel({required this.vehicleName, required this.vehicleType});
// }
//
// class CalendarScreen extends StatefulWidget {
//   @override
//   _CalendarScreenState createState() => _CalendarScreenState();
// }
//
// class _CalendarScreenState extends State<CalendarScreen> {
//   DateTime _selectedDate = DateTime.now();
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   Map<DateTime, List<ManageVehicleModel>> _events = {};
//   List<ManageVehicleModel> _selectedEvents = [];
//
//   Future<void> getDataForSelectedDate(DateTime selectedDate) async {
//     // Create a DateTime object with time set to 00:00:00
//     DateTime startDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
//
//     // Create a DateTime object with time set to 23:59:59
//     DateTime endDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);
//
//     // Convert the DateTime objects to Firestore Timestamps
//     Timestamp startTimestamp = Timestamp.fromDate(startDateTime);
//     Timestamp endTimestamp = Timestamp.fromDate(endDateTime);
//
//     // Query Firestore to retrieve the data for the selected date range
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('your_collection')
//         .where('date', isGreaterThanOrEqualTo: startTimestamp)
//         .where('date', isLessThanOrEqualTo: endTimestamp)
//         .get();
//
//     // Extract the data from the snapshot
//     List<ManageVehicleModel> dataList = snapshot.docs.map((doc) {
//       Map<String, dynamic> data = doc.data();
//       return ManageVehicleModel(
//         vehicleName: data['vehicleName'],
//         vehicleType: data['vehicleType'],
//       );
//     }).toList();
//
//     setState(() {
//       _events[selectedDate] = dataList;
//       _selectedEvents = dataList;
//     });
//   }
//
//   void _onDaySelected(DateTime selectedDate, List<dynamic> events) {
//     setState(() {
//       _selectedDate = selectedDate;
//       _selectedEvents = events.cast<ManageVehicleModel>();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Calendar'),
//       ),
//       body: Column(
//         children: [
//           TableCalendar(
//             calendarFormat: _calendarFormat,
//             startingDayOfWeek: StartingDayOfWeek.monday,
//             availableCalendarFormats: {
//               CalendarFormat.month: 'Month',
//               CalendarFormat.week: 'Week',
//             },
//             events: _events,
//             onDaySelected: _onDaySelected,
//             calendarStyle: CalendarStyle(
//               todayColor: Theme.of(context).primaryColor,
//               selectedColor: Theme.of(context).accentColor,
//               todayStyle: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18.0,
//                 color: Colors.white,
//               ),
//             ),
//             headerStyle: HeaderStyle(
//               formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
//               formatButtonDecoration: BoxDecoration(
//                 color: Theme.of(context).accentColor,
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           _selectedEvents.isNotEmpty
//               ? Text(
//             'Selected Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
//             style: TextStyle(fontSize: 18),
//           )
//               : Container(),
//           SizedBox(height: 20),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _selectedEvents.length,
//               itemBuilder: (BuildContext context, int index) {
//                 ManageVehicleModel vehicleModel = _selectedEvents[index];
//                 return ListTile(
//                   title: Text(vehicleModel.vehicleName),
//                   subtitle: Text(vehicleModel.vehicleType),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: CalendarScreen(),
//   ));
// }
