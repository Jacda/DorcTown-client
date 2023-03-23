import 'package:dorc_town/recources/dorc.dart';

class DorcCatalog {
  var list = <Dorc>[];
  late bool altered;

  DorcCatalog() {
    altered = false;
  }

  void addTo(Dorc d) {
    altered = true;
    list.add(d);
  }

  void removeFrom(Dorc d) {
    list.remove(d);
  }
}
