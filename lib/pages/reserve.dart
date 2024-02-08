import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimizer/data/session.dart';

class Reserve extends StatefulWidget {
  const Reserve({Key? key}) : super(key: key);

  @override
  State<Reserve> createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  final TextEditingController lotController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController deathDateController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != controller.text) {
      // Update the text field with the selected date
      controller.text = picked.toLocal().toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reservation',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: lotController,
                decoration: const InputDecoration(labelText: 'Lot Number'),
              ),
              TextFormField(
                controller: sectionController,
                decoration: const InputDecoration(labelText: 'Section Letters'),
              ),
              TextFormField(
                controller: blockController,
                decoration: const InputDecoration(labelText: 'Block Number'),
              ),
              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: 'Name of the Deceased'),
              ),
              GestureDetector(
                onTap: () => _selectDate(context, birthDateController),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: birthDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Birth Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selectDate(context, deathDateController),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: deathDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Death Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: messageController,
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
                onPressed: () {
                  // Perform reservation process with the entered data
                  String lotNumber = lotController.text.trim();
                  String sectionLetters = sectionController.text.trim();
                  String blockNumber = blockController.text.trim();
                  String deceasedName = nameController.text.trim();
                  String birthDate = birthDateController.text.trim();
                  String deathDate = deathDateController.text.trim();
                  String message = messageController.text.trim();

                  if (lotNumber.isEmpty ||
                      sectionLetters.isEmpty ||
                      blockNumber.isEmpty ||
                      deceasedName.isEmpty ||
                      birthDate.isEmpty ||
                      deathDate.isEmpty ||
                      message.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Alert'),
                          content: const Text('Please fill in all the fields.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    appointment(lotNumber, sectionLetters, blockNumber,
                        deceasedName, birthDate, deathDate, message);
                  }
                },
                child: const Text(
                  'Reserve',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future appointment(lotNumber, sectionLetters, blockNumber, deceasedName,
      birthDate, deathDate, message) async {
    await FirebaseFirestore.instance.collection('Appointment').doc().set({
      'lot number': lotNumber,
      'section letters': sectionLetters,
      'block number': blockNumber,
      'deceased name': deceasedName,
      'birth date': birthDate,
      'death date': deathDate,
      'message': message,
      'email': Session.email,
      "payment": 10000
    });

    Navigator.of(context).pop();
  }
}
