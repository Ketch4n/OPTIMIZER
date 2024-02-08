import 'package:flutter/material.dart';
import 'package:optimizer/auth/login.dart';
import 'package:optimizer/data/session.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 140,
              decoration: const BoxDecoration(color: Colors.orange),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'assets/profile.jpeg',
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Session.email,
                                // textScaleFactor:
                                //     ScaleSize.textScaleFactor(
                                //         context),
                                style: const TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Log-out'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () async {
                // Navigator.of(context).pop(false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
