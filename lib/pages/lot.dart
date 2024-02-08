// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optimizer/model/reserveModel.dart';

class Lot extends StatefulWidget {
  @override
  _LotState createState() => _LotState();
}

class _LotState extends State<Lot> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> documents = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List filteredRows(List<ReserveModel> products) {
    String query = _searchController.text.toLowerCase();
    // Filter the products based on the search query
    List<ReserveModel> filteredProducts = products.where((product) {
      return product.blockNumber.toLowerCase().contains(query) ||
          product.deceasedName.toLowerCase().contains(query) ||
          product.lotNumber.toLowerCase().contains(query) ||
          product.deathDate.toLowerCase().contains(query);
    }).toList();
    // Build the DataRow widgets for the filtered products
    return filteredProducts.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.orange,
                      onChanged: (query) {
                        // Filter the data based on the search query
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              // IconButton(
              //   icon: Icon(Icons.search),
              //   onPressed: () {
              //     _search();
              //   },
              //   color: Colors.amber,
              // ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Appointment')
            .where('payment', isLessThanOrEqualTo: 0)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Text('No data available');
          }

          final documents = snapshot.data!.docs;
          final reserveModels = documents.map((doc) {
            return ReserveModel(
                lotNumber: doc['lot number'],
                sectionLetters: doc['section letters'],
                blockNumber: doc['block number'],
                deceasedName: doc['deceased name'],
                birthDate: doc['birth date'],
                deathDate: doc['death date'],
                message: doc['message'],
                email: doc["email"],
                payment: doc["payment"].toDouble());
          }).toList();

          final snap = filteredRows(reserveModels);

          return ListView.builder(
            itemCount: snap.length,
            itemBuilder: (context, index) {
              final ReserveModel dtr = snap[index];
              return ListTile(
                leading: Text("lot #: " + dtr.lotNumber),
                title: Text("Deceased: " + dtr.deceasedName),
                subtitle: Text("death date: " + dtr.deathDate),
                trailing: Text("block #: " + dtr.blockNumber),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Detailed Information"),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            const Text("Deceased information: "),
                            const Divider(),
                            Text("Lot #: " + dtr.lotNumber),
                            Text("Deceased: " + dtr.deceasedName),
                            Text("Death date: " + dtr.deathDate),
                            Text("Block #: " + dtr.blockNumber),
                            // Add more information as needed
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(),
                            const Text("Reservation by: "),
                            const Divider(),
                            Text(dtr.email),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(),
                            const Text("Payment Bal: "),
                            const Divider(),
                            ListTile(
                              leading: Text("₱" + dtr.payment.toString()),
                              trailing: Text(
                                  dtr.payment <= 0.0 ? "PAID" : "Pending",
                                  style: TextStyle(
                                      color: dtr.payment <= 0.0
                                          ? Colors.green
                                          : Colors.blue)),
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
