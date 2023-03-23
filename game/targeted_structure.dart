import 'package:dorc_town/game/dorc_town.dart';
import 'package:dorc_town/structures/buildings/breeding_cave.dart';
import 'package:dorc_town/structures/habitats/habitat.dart';
import 'package:dorc_town/structures/structure_component.dart';
import 'package:flame/components.dart';

class TargetedStructure extends Component with HasGameRef<DorcTown> {
  late Vector2 lastPosition;
  late StructureComponent current;
  late bool placementReady;
  late bool movementReady;
  late bool isTargeted;
  late bool breedingCave;
  late bool canBePlaced;

  TargetedStructure() {
    setAllFalse();
    canBePlaced = true;
  }

  void setAllFalse() {
    placementReady = false;
    movementReady = false;
    isTargeted = false;
    breedingCave = false;
  }

  void setPurchaseReady() {
    if (breedingCave) {
      current = BreedingCave(game.psz.structure);
    } else {
      current = Habitat(
        game.psz.structure,
      );
    }
    game.add(current);
    current.setPostition(game.psz.sleeping);
    breedingCave = false;
    placementReady = true;
  }

  void setMovementReady() {
    isTargeted = false;
    movementReady = true;
    lastPosition = current.position.clone();
    current.setPostition(game.psz.sleeping);
  }
}
