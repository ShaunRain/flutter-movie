import 'package:flutter/material.dart';
import 'package:flutter_movie/page/login_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  List<String> welcomeTexts = [
    "Connect people around the wolrd",
    "Live your life smarter with us",
    "Get a new experience of imagination"
  ];
  List<String> welcomeImages = [
    "assets/welcome0.png",
    "assets/welcome1.png",
    "assets/welcome2.png"
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              "Log in to your account",
              style: TextStyle(
                  color: Color.fromRGBO(62, 74, 89, 1.0), fontSize: 16),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: PageView.builder(
                  onPageChanged: (index) => _tabController.animateTo(index),
                  itemCount: 3,
                  itemBuilder: (context, index) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                "${welcomeTexts[index]}",
                                style: TextStyle(
                                    color: Color.fromRGBO(58, 210, 159, 1.0),
                                    fontSize: 30),
                              )),
                          Image.asset('${welcomeImages[index]}'),
                        ],
                      ))),
          TabPageSelector(
            indicatorSize: 8,
            color: Color.fromRGBO(181, 187, 223, 0.2),
            selectedColor: Color.fromRGBO(181, 187, 223, 1.0),
            controller: _tabController,
          ),
          Hero(
              tag: "login_button",
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    onPressed: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new LoginPage())),
                    textColor: Colors.white,
                    child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints.expand(
                          width: double.infinity, height: 40),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    color: Color.fromRGBO(58, 210, 159, 1.0),
                  ))),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
