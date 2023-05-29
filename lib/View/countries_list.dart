import 'package:covid_tracker/Services/state_services.dart';
import 'package:covid_tracker/View/details_screen.dart';
import 'package:flutter/material.dart';

// shimmer effect
import 'package:shimmer/shimmer.dart';



class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  // state_services
  StateServices stateServices = StateServices();

  // search controller
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appbar
      appBar: AppBar(
        title: Text('countries list'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ) ,


      // body
      body:  Column(
        children: [

          // search field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(

              controller: searchController,

              onChanged: (value){
                setState(() {
                  
                });
              },

              decoration: InputDecoration(
                hintText: 'Search With Country Name',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )
              ),

            ),
          ),


          // show countries lists
          Expanded(
              child: FutureBuilder(

                future: stateServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

                  // loading shimmer effect
                  if(!snapshot.hasData){
                    return ListView.builder(

                        itemCount: 10,
                        itemBuilder: (context, index){

                          return Shimmer.fromColors(

                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,

                            child:  Column(
                                children: [

                                  ListTile(

                                    title: Container(height: 10, width: 80, color: Colors.white,),
                                    subtitle: Container(height: 10, width: 80, color: Colors.white,),

                                    leading: Container(height: 50, width: 50, color: Colors.white,),

                                  ),

                                ],
                              ),
                          );



                        });
                  }

                  else{

                    // show the data as listview
                    return ListView.builder(

                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                          String name = snapshot.data![index]['country'];

                          if(searchController.text.isEmpty){

                            return Column(
                              children: [

                                InkWell(

                                  // details with onPressed
                                  onTap:(){

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsScreen(

                                              // data passing
                                              name: snapshot.data![index]['country'],
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              totalCases: snapshot.data![index]['cases'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              totalRecovered: snapshot.data![index]['recovered'],
                                              active: snapshot.data![index]['active'],
                                              critical: snapshot.data![index]['critical'],
                                              todayRecovered: snapshot.data![index]['todayRecovered'],
                                              test: snapshot.data![index]['tests'],

                                            )
                                        ),
                                    );

                                },

                                  child: ListTile(

                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),

                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    ),

                                  ),
                                ),

                              ],
                            );

                          }
                          else if(name.toLowerCase().contains(searchController.text.toLowerCase())){

                            return Column(
                              children: [

                                InkWell(

                                  // showing details with onPressed
                                  onTap:(){

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsScreen(

                                            // data passing
                                            name: snapshot.data![index]['country'],
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            totalCases: snapshot.data![index]['cases'],
                                            totalDeaths: snapshot.data![index]['deaths'],
                                            totalRecovered: snapshot.data![index]['recovered'],
                                            active: snapshot.data![index]['active'],
                                            critical: snapshot.data![index]['critical'],
                                            todayRecovered: snapshot.data![index]['todayRecovered'],
                                            test: snapshot.data![index]['tests'],

                                          )
                                      ),
                                    );

                                  },

                                  child: ListTile(

                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),

                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    ),

                                  ),
                                ),

                              ],
                            );

                          }else{
                            return Container();
                          }


                        });
                  }



                },

              ),
          ),


        ],
      ),



    );
  }
}
