import 'package:flutter/material.dart';

class Slots extends StatefulWidget {
  final List slots;
  const Slots(this.slots, {super.key});

  @override
  State<Slots> createState() => _SlotsState();
}

class _SlotsState extends State<Slots> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Available Slots"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: widget.slots.isEmpty
              ? Text("No Vaccines Available")
              : ListView.builder(
                  itemCount: widget.slots.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(5),
                      height: 200,
                      color: Colors.grey.withOpacity(0.3),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Center ID - ${widget.slots[index]['center_id'].toString()}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Center Name - ${widget.slots[index]['name'].toString()}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Center Address - ${widget.slots[index]['address'].toString()}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Divider(),
                            Text(
                              'Vaccine Name - ${widget.slots[index]['vaccine'].toString()}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Divider(),
                            Text(
                              'Slots Timing - ${widget.slots[index]['slots'].toString()}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
