import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:provider/provider.dart';
import 'package:BOARDING/signup.dart';
import 'package:BOARDING/login_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider<OnBoardState>(
      create: (_) => OnBoardState(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: OnBoard(
          pageController: _pageController,
          onSkip: () {
            // print('skipped');
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return new Signup();
            }));
          },
          onDone: () {
            // print('skipped');
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return new LoginPage();
            }));

            // print('skipped');
          },
          onBoardData: onBoardData,
          titleStyles: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.15,
          ),
          descriptionStyles: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
          pageIndicatorStyle: PageIndicatorStyle(
            width: 50,
            inactiveColor: Colors.blue[100],
            activeColor: Colors.blue[500],
            inactiveSize: Size(8, 8),
            activeSize: Size(12, 12),
          ),
          skipButton: FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new LoginPage();
              }));

            },
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.blue[300]),
            ),
          ),
          nextButton: Consumer<OnBoardState>(
            builder: (BuildContext context, OnBoardState state, Widget child) {
              return InkWell(
                onTap: () => _onNextTap(state, context),
                child: Container(
                  width: 230,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue],
                    ),
                  ),
                  child: Text(
                    state.isLastPage ? "Let's Get Started" : "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState, BuildContext context) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}

final List<OnBoardModel> onBoardData = [
  OnBoardModel(
    title: "Welcome to Neon",
    description: "Manage all your activities ",
    imgUrl: 'assets/images/image-1.jpeg',
  ),
  OnBoardModel(
    title: "What is Lorem ipsum?",
    description: "i dont know what is lorem ipsum plz tell",
    imgUrl: 'assets/images/image-2.jpeg',
  ),
  OnBoardModel(
    title: "Do you know who is lorem ipsum",
    description: "Nobody i dont know head to next page",
    imgUrl: 'assets/images/image-3.jpeg',
  ),
];
