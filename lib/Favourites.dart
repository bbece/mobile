import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:games_project/favouriteProvider.dart';
import 'package:provider/provider.dart';

import 'Game.dart';
import 'gamePage.dart';
import 'gameList.dart';

void main() => runApp(const Favourites());

class Favourites extends StatelessWidget {
  const Favourites({super.key});

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

  List<Game> games = List.from(gameList);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    List<Game> favouriteGames = provider.favouriteGame;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color.fromRGBO(248, 248, 248, 0.92),
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 140.0,
            flexibleSpace: const FlexibleSpaceBar(
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.only(left: 16),
              title: Text(
                "Favourites",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 40,
                  letterSpacing: 0.41,
                  fontFamily: "SP",
                  //yazıyı köşeye sabitleme yapılmadı!!
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: favouriteGames.length,
              (BuildContext context, int index) {
                return Container(
                  color: Color.fromRGBO(224, 224, 224, 1.0),
                  height: 136.0,
                  width: 375.0,
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GamePage(game: favouriteGames[index]),
                          ),
                        );
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero)),
                      child: Container(
                        height: 120,
                        color: index % 2 == 0
                            ? const Color.fromARGB(255, 230, 230, 230)
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Container(
                                height: 100,
                                padding: const EdgeInsets.only(right: 16),
                                child: favouriteGames[index].image),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 65,
                                    child: Text(
                                      '${favouriteGames[index].name}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'metacritic: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            '${favouriteGames[index].metacritic}',
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '${favouriteGames[index].genre}',
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
