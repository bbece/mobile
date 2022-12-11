import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:games_project/favouriteProvider.dart';
import 'package:provider/provider.dart';
import 'favourites.dart';
import 'Game.dart';
import 'gameList.dart';
import "package:url_launcher/url_launcher.dart";

class GamePage extends StatefulWidget {
  Game game;
  GamePage({required this.game});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Game> games = List.from(gameList);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    List<Game> favouriteGame = provider.favouriteGame;
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.white,
            title: const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Games",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    letterSpacing: -0.41,
                    color: Color.fromRGBO(0, 122, 255, 1)),
              ),
            ),
            leading: IconButton(
              padding: const EdgeInsets.only(bottom: 10.0),
              icon: const Icon(
                Icons.arrow_back,
                size: 20.5,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: (() {
                  if (favouriteGame.contains(widget.game)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Are you sure?"),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    provider.removeFavourites(widget.game);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    provider.addFavourites(widget.game);
                  }
                }),
                child: Text(
                  favouriteGame.contains(widget.game)
                      ? "Remove Favourite"
                      : "Add Favourite",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      //height: 22,
                      letterSpacing: -0.41,
                      color: Color.fromRGBO(0, 122, 255, 1)),
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            ExpansionPanelList(
              children: [
                ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Text("${widget.game.name}");
                    },
                    body: Text("${widget.game.description}"),
                    isExpanded: true,
                    canTapOnHeader: true,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0.92))
              ],
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "View Reddit",
                style: const TextStyle(color: Colors.black),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    Uri url = Uri.https("${widget.game.redditUrlAuthority}",
                        "${widget.game.redditUrlUnencodedPath}");
                    var urllaunchable = await canLaunchUrl(
                        url); //canLaunch is from url_launcher package
                    if (urllaunchable) {
                      await launchUrl(
                          url); //launch is from url_launcher package to launch URL
                    } else {
                      print("URL can't be launched.");
                    }
                  },
              ),
              TextSpan(
                  text: "View website",
                  style: const TextStyle(color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      Uri url = Uri.https("${widget.game.websiteUrlAuthority}",
                          "${widget.game.websiteUrlUnencodedPath}");
                      var urllaunchable = await canLaunchUrl(
                          url); //canLaunch is from url_launcher package
                      if (urllaunchable) {
                        await launchUrl(Uri.https(
                            "${widget.game.websiteUrlAuthority}",
                            "${widget.game.websiteUrlUnencodedPath}")); //launch is from url_launcher package to launch URL
                      } else {
                        print("URL can't be launched.");
                      }
                    })
            ]))
          ],
        ),
      ),
    );
  }
}
