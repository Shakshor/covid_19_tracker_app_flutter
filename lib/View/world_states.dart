import 'package:covid_tracker/Services/state_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';

// pie chart
import 'package:pie_chart/pie_chart.dart';

// spin_kit
import 'package:flutter_spinkit/flutter_spinkit.dart';

// WorldStatesModel
import 'package:covid_tracker/Model/WorldStatesModel.dart';




class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  // animation controller
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
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

    // calling the world state_services
    StateServices stateServices = StateServices();

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


                // show the data
                // future builder
                FutureBuilder(

                    future: stateServices.fetchWorldStatesRecord(),
                    builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){

                      if(!snapshot.hasData){

                        // spinner showing for loading
                        return Expanded(

                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ),
                        );

                      }else{

                        return Column(
                          children: [

                            // pie chart
                            PieChart(

                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
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
                                  'Total': double.parse(snapshot.data!.cases!.toString()),
                                  'Recovered' : double.parse(snapshot.data!.recovered!.toString()),
                                  'Deaths' : double.parse(snapshot.data!.deaths!.toString()),
                                }
                            ),


                            // card
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                              child: Card(
                                child: Column(
                                  children: [

                                    ReusableRow(title: 'total', value: snapshot.data!.cases!.toString()),

                                    ReusableRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),

                                    ReusableRow(title: 'Deaths', value: snapshot.data!.deaths!.toString()),

                                    ReusableRow(title: 'Active', value: snapshot.data!.deaths!.toString()),

                                    ReusableRow(title: 'Critical', value: snapshot.data!.critical!.toString()),

                                    ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths!.toString()),

                                    ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),

                                  ],
                                ),
                              ),
                            ),


                            // track countries button
                            GestureDetector(

                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => const CountriesListScreen() ));
                            },

                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child: Center(child: Text('Track Countries')),
                              ),
                            ),

                          ],
                        );


                      }


                    }
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

