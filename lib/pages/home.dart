import 'package:flutter/material.dart';
import 'package:optimizer/include/navbar.dart';
import 'package:optimizer/pages/lot.dart';
import 'package:optimizer/pages/payment.dart';
import 'package:optimizer/pages/reserve.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
          backgroundColor: Colors.orange,
        ),
        drawer: const Navbar(),
        body: Column(children: [
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/logo.png'))),
            ),
          ),
          const Text(
            'Cemetery Record Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Reserve(),
                        ));
                  },
                  icon: const Column(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 50,
                      ),
                      Text('Appointment'),
                      // Text('view details')
                    ],
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YourPayment(),
                        ));
                  },
                  icon: const Column(
                    children: [
                      Icon(
                        Icons.payment,
                        size: 50,
                      ),
                      Text('Pending Payment'),
                    ],
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Lot(),
                        ));
                  },
                  icon: const Column(
                    children: [
                      Icon(
                        Icons.map,
                        size: 50,
                      ),
                      Text('Lot'),
                      // Text('views details')
                    ],
                  ))
            ],
          )
        ]));
  }
}
