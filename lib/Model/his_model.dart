class HistoryModel {
  int id;
  String winner;

  dataMap() {
    var mapData = Map<String, dynamic>();
    mapData['id'] = id;
    mapData['winner'] = winner;

    return mapData;
  }
}
