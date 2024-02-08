// Import necessary packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optimizer/data/session.dart';

class YourPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Payment',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Appointment')
            .where('email', isEqualTo: Session.email)
            .where('payment', isGreaterThan: 0)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check if there is no data
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Pending Payment.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              // Access the document data using document.data()
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              TextEditingController subtractController =
                  TextEditingController(); // Controller for the TextField

              return ListTile(
                title: Text(data['deceased name']),
                subtitle: Text('Payment: ${data['payment']}'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Downpayment"),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            ListTile(
                              leading: const Text("Payment Bal: "),
                              trailing: Text("₱" + data["payment"].toString()),
                            ),
                            data["payment"] > 0
                                ? TextField(
                                    controller: subtractController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Amount to pay',
                                    ),
                                  )
                                : const Text("PAID",
                                    style: TextStyle(color: Colors.green)),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Subtract the entered amount from the payment balance
                              double subtractAmount =
                                  double.parse(subtractController.text);
                              double updatedPayment =
                                  data['payment'] - subtractAmount;

                              // Update the payment balance in the database
                              FirebaseFirestore.instance
                                  .collection('Appointment')
                                  .doc(document.id)
                                  .update({'payment': updatedPayment});

                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: data["payment"] > 0
                                ? const Text('Pay')
                                : const SizedBox(),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
