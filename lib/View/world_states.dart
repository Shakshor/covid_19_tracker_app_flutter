import 'package:flutter/material.dart';

// pie chart
import 'package:pie_chart/pie_chart.dart';


class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  // animation controller
  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();


  // dispose the controller
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // call the controller
    _controller.dispose();

  }

  // color list
  final colorList = <Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [

                // height
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),

                // pie chart
                PieChart(

                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    chartType: ChartType.ring,
                    centerText: 'Covid-19',
                    colorList: colorList,
                    legendOptions: const LegendOptions(
                      legendPosition: LegendPosition.left
                    ),

                    // animation duration
                    animationDuration: const Duration(microseconds: 1200),

                    dataMap: {
                    'Total': 20,
                    'Recovered' : 15,
                    'Deaths' : 5,
                  }
                ),


                // card
                Padding(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                  child: Card(
                    child: Column(
                      children: [

                        ReusableRow(title: 'total', value: '200'),

                        ReusableRow(title: 'total', value: '200'),

                        ReusableRow(title: 'total', value: '200'),

                      ],
                    ),
                  ),
                ),


                // button
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10)
                  ),

                  child: Center(child: Text('Track Countries')),
                ),



              ],
            ),
          ),
      ),
    );
  }
}



// reusable row
class ReusableRow extends StatelessWidget {

  // state
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(title),
              Text(value)
            ],
          ),

          SizedBox(height: 5,),

          Divider(),
        ],
      ),
    );
  }
}

