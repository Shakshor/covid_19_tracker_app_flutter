import 'dart:async';

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

// math import
import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{


  // controller for animation
  late final AnimationController _controller = AnimationController(
      duration: const Duration (seconds: 3),
      vsync: this)..repeat();


  @override
  // dispose the controller
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  // init function
  void initState() {
    // TODO: implement initState
    super.initState();

    // loading & navigate to different screen
    Timer(Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WorldStatesScreen()));
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children:  [

            // animation
            AnimatedBuilder(

                animation: _controller,
                child:Container(
                  width: 200,
                  height: 200,
                  child: const Center(
                    child: Image(
                      image: AssetImage('images/virus.png'),
                    ),
                  ),
                ),
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }
            ),


            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),

            // text
            const Align(
              alignment: Alignment.center,
              child: Text('Covid-19\nTracker App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
