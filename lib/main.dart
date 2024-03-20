import 'package:flutter/material.dart';
import 'package:among_us2/nameYourTeam.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset(
          //   'assets/main login.png',
          //   fit: BoxFit.fill,
          // ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(16, 21, 33, 1),
                  Color.fromRGBO(5, 18, 51, 0.47),
                  // Color.fromRGBO(37, 56, 106, 0.66),
                  // Color.fromRGBO(210, 177, 127, 0.5),
                  // Color.fromRGBO(195, 167, 113, 0.54),
                  Color.fromRGBO(169, 132, 88, 0.58),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            child: Image.asset(
              'assets/Component 4.png',
              fit: BoxFit.none,
            ),
          ),
          Positioned(
            top: 580,
            left: 35,
            child: Image.asset(
              'assets/Red.png',
            ),
          ),
          Positioned(
            top: 190,
            left: 130,
            child: Container(
              width: 135, // Set the desired width
              height: 42, // Set the desired height
              child: Image.asset(
                'assets/login_here.png',
                fit: BoxFit.cover, // Adjust image fit as needed
              ),
            ),
          ),

          Positioned(
            top: 120,
            left: 330,
            child: Image.asset(
              'assets/Lime.png',
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/Component 3.png',
            ),
          ),
          Positioned(
            top: 40,
            left: 30,
            child: Image.asset(
              'assets/Group.png',
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(38.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: 0),

                    SizedBox(height: 60.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Enter your ID',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'e.g., @nith.ac.in',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 188, 210, 228)),
                        filled: true,
                        fillColor: Color.fromRGBO(45, 54, 81, 1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Enter password',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 188, 210, 228)),
                        filled: true,
                        fillColor: Color.fromRGBO(45, 54, 81, 1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    ElevatedButton(
                      onPressed: () {
                        // Perform validation before navigating
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          // Show a snackbar or any other feedback to inform the user about the missing fields
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Please enter both ID and password.'),
                            ),
                          );
                        } else {
                          // If both fields are not empty, navigate to the next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NameYourTeam()),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(17, 24, 40, 1),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(200, 50), // Change button size here
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
