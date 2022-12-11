import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      home: SliverAppBar_(),

    );
  }
}

class SliverAppBar_ extends StatefulWidget {
  const SliverAppBar_({super.key});

  @override
  State<SliverAppBar_> createState() => _SliverAppBarState();
}

class _SliverAppBarState extends State<SliverAppBar_> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;


  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(

        body: CustomScrollView(
        slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Color.fromRGBO(248, 248, 248, 0.92),
          pinned: _pinned,
          snap: _snap,
          floating: _floating,
          expandedHeight: 140.0,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text("Favourites", style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize:34,
                  letterSpacing:0.41,
                  fontFamily: "SP",
                  //yazıyı köşeye sabitleme yapılmadı!!


          )  ,),), ),

      SliverList(
        delegate: SliverChildBuilderDelegate(childCount: 7,
                (BuildContext context, int index) {
              return  Container(


                color: Color.fromRGBO(224, 224, 224, 1.0),
                height: 136.0,
                width: 375.0,

                child: Center( child:Text("$index"),

                 
                ),
              );
            },),)










        ]),



    ),);}}
