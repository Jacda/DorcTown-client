import "package:flutter/services.dart" as s;
import "package:yaml/yaml.dart";

/*Fragile file! much manual labor.
Print each data[x] field to see null... if misnamed
Should ensure that backedn integiry is soldi before implementing fully
here.

*/

// Generic item components
class Item {
  final String name;
  final int shopcost;
  final int shopcosttype;
  final int completiontime;
  final int exponcompletion;
  final int itemcategory;
  final bool sellableflag;
  final int itemId;

  const Item(this.name, this.shopcost, this.shopcosttype, this.completiontime,
      this.exponcompletion, this.itemcategory, this.sellableflag, this.itemId);

  factory Item.fromYaml(YamlMap data) {
    return Item(
        data['name'] as String,
        data['shopcost'] as int,
        data['shopcosttype'] as int,
        data['completiontime'] as int,
        data['exponcompletion'] as int,
        data['itemcategory'] as int,
        data['sellableflag'] as bool,
        data['item_id'] as int);
  }

  @override
  String toString() {
    return "$name $itemId";
  }
}

// Used to check item pointer/render merchandise mommy
class DorcBlueprint {
  final int baseincome;
  final int lvlincomebonus;
  final int element;
  final int rarity;
  final int collecttype;
  final Item generics;

  const DorcBlueprint(this.generics, this.baseincome, this.lvlincomebonus,
      this.element, this.rarity, this.collecttype);

  factory DorcBlueprint.fromYamlEntry(YamlMap data) {
    return DorcBlueprint(
        Item.fromYaml(data["generics"]),
        data['baseincome'] as int,
        data['lvlincomebonus'] as int,
        data['element'] as int,
        data['rarity'] as int,
        data['collecttype'] as int);
  }

  @override
  String toString() {
    return generics.toString() + " rarity type $rarity";
  }
}

Future<List<DorcBlueprint>> LoadDorcs() async {
  final data = await s.rootBundle.loadString('assets/blueprints/dorcs.yaml');
  final mapData = loadYaml(data);
  //print(mapData);

  List<DorcBlueprint> dorcList = [];

  for (var entry in mapData["dorcs"]) {
    var res = DorcBlueprint.fromYamlEntry(entry);
    dorcList.add(res);
    //print(res.toString());
    //print(item.runtimeType);
  }

  // panic if fails
  return dorcList;
}


/*
class BuildingBlueprint {
  final int size;
  final int collecttype; // asset enum 0,1,2,3 - coins,gems,exp,NaN
  final int collectcap;
  final int element; // int32 bit masks
  final int xsize;
  final int ysize;
  final int buildingtype; // enum habitat etc.
  final int itemcategory; // enum building category

  final Item generics;
}
*/