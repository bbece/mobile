import 'package:flutter/cupertino.dart';
import 'package:games_project/Game.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Game> _favouriteGames = [];
  List<Game> get favouriteGame => _favouriteGames;

  void addFavourites(Game game) {
    _favouriteGames.add(game);
    notifyListeners();
  }

  void removeFavourites(Game game) {
    _favouriteGames.remove(game);
    notifyListeners();
  }
}
