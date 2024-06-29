import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../controller/manageVehicleController.dart';
import '../../utils/commonWidgets/CustomBottomNavigationBarWithWallet.dart';
import '../../utils/commonWidgets/FloatingactionButtonWithNotched.dart';

class manageBikes extends StatefulWidget {
  const manageBikes({Key? key}) : super(key: key);

  @override
  State<manageBikes> createState() => _manageBikesState();
}

class _manageBikesState extends State<manageBikes> {
   DateTime? _selectedDate;
   final manageVehicleController _manageVehicleController = Get.put(manageVehicleController());
   String _searchString = '';
   TextEditingController _searchController = TextEditingController();

   @override
   void initState() {
     super.initState();
     _searchController.addListener(_onSearchChanged);
   }

   void _onSearchChanged() {
     setState(() {
       _searchString = _searchController.text;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: CustomNavigationBar1(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButtonWithNotched(),
      backgroundColor: PrimaryColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              child: Image.asset(
                whiteBackground,
              ),
            ),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "BIKES",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: 'Lobster'),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: 45,
                  child: CupertinoSearchTextField(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25,
                    ),
                    prefixInsets: const EdgeInsets.symmetric(horizontal: 20),
                    placeholder: "Search...",
                    placeholderStyle: const TextStyle(color: Colors.black),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: PrimaryColor,
                    ),
                    controller: _searchController,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Entries',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: SecondaryColor,
                      ),
                      softWrap: false,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0))),
                          builder: (BuildContext builder) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                                child: TableCalendar(
                                  focusedDay: _selectedDate ?? DateTime.now(),
                                  firstDay: DateTime(DateTime.now().year - 1),
                                  lastDay: DateTime(DateTime.now().year + 1),
                                  calendarFormat: CalendarFormat.month,
                                  selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                                  headerStyle: HeaderStyle(
                                    formatButtonTextStyle: const TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
                                    formatButtonDecoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      _selectedDate = selectedDay;
                                      print(_selectedDate);
                                      _manageVehicleController.getDataFromBikesForSelectedDateAndSearchQuery(_selectedDate! , _searchString);
                                      Navigator.pop(context); // Close the calendar modal
                                    });
                                  },
                                ),
                              ),

                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Row(children: const [
                        Icon(Icons.filter_list, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Filter...", style: TextStyle(fontSize: 18),)
                      ],),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: FutureBuilder(
                    future: _manageVehicleController.getDataFromBikesForSelectedDateAndSearchQuery(_selectedDate, _searchString),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount:snapshot.data!.length,
                              physics: const ClampingScrollPhysics(),
                              reverse: true,
                              itemBuilder: (context, index) {
                               String date = snapshot.data![index].date.toDate().toString();
                                   return Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    height: MediaQuery.of(context).size.height/8.6,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      color: PrimaryColor, borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          // crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the left
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data![index].vehicleNo,
                                              style: const TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 25,
                                                color: Colors.white
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].name,
                                              style: const TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 20,
                                                color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),

                                        const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 15),
                                          child: VerticalDivider(
                                            color: Colors.white, // Customize the color of the divider line
                                            thickness: 1, // Set the thickness of the divider line
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the right
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                                              child: Text(
                                                date.substring(0, 10),
                                                style: const TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 15,
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),Text(
                                              'In Time: ${snapshot.data![index].timeIn}',
                                              style: const TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: Colors.white
                                              ),
                                            ),
                                            Text(
                                              'Out Time: ${snapshot.data![index].timeOut} ',
                                              style: const TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: Colors.white
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 70),
                                              child: Text(
                                                'RS: ${snapshot.data![index].fees}',
                                                style: const TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 15,
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
