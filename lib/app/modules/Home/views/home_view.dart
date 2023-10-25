import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MQW = MediaQuery.of(context).size.width;
    final MQH = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MQW,
              height: MQH,
            ),
            Positioned(
                top: 30,
                left: 10,
                child: Text(
                  'YOUR',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                )),
            Positioned(
              top: 50,
              left: 10,
              child: Text(
                'STORAGE',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Positioned(
              top: 90,
              left: 10,
              child: Form(
                child: Container(
                  width: MQW * 0.7,
                  height: MQH * 0.07,
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        label: Text('Search'),
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              child: Container(
                width: MQW,
                height: MQH * 0.65,
                child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('Testing'),
                        leading: Image.asset('images/wi.png'),
                        subtitle: Text('lorem ipsum si jamet keren'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
