import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {

  // state declare
  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

  DetailsScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appBar
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),

      // main body
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          // show details
          Stack(
            alignment: Alignment.topCenter,
            children: [

              // card element
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(

                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                      ReusableRow(title: 'cases', value: widget.totalCases.toString()),
                      ReusableRow(title: 'totalDeaths', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'totalRecovered', value: widget.totalRecovered.toString()),
                      ReusableRow(title: 'active', value: widget.active.toString()),
                      ReusableRow(title: 'critical', value: widget.critical.toString()),
                      ReusableRow(title: 'todayRecovered', value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),


              // upper image element
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
              


            ],
          ),

        ],

      ),




    );
  }
}
