import 'dart:convert';
import 'package:covid_vaccine_slots/slots.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController dayController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  List slots = [];
  String dropdownValue = '01';
  List<String> list = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];

  fetchSlots() async {
    await http
        .get(Uri.parse(
            'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=${pincodeController.text.trim()}&date=${dayController.text.trim()}-$dropdownValue-2023'))
        .then((value) {
      Map res = jsonDecode(value.body);
      setState(() {
        slots = res['sessions'];
      });
      print(res);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Slots(slots)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Vaccination Slots"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/vaccine.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    hintText: 'Enter PIN Code',
                    labelText: 'Enter PIN Code',
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dayController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: "Enter Date"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 60,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.grey,
                          ),
                          onChanged: (String? value) {
                            dropdownValue = value!;
                            setState(() {});
                          },
                          items: list.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: size.width,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        fetchSlots();
                      },
                      child: const Text(
                        "Find Slots",
                        style: TextStyle(letterSpacing: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
