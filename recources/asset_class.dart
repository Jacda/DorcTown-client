import 'package:flame/components.dart';
import 'package:dorc_town/game/dorc_town.dart';

enum AssetType { coins, gems, exp, feed }

class AssetClass extends Component with HasGameRef<DorcTown> {
  int coin = 100;
  int gem = 10;
  int exp = 1;
  int feed = 5;

  void increaseRecource(int asset, AssetType assetType) {
    switch (assetType) {
      case AssetType.coins:
        {
          coin += asset;
          refreshCoins();
          break;
        }
      case AssetType.gems:
        {
          gem += asset;
          refreshGems();
          break;
        }
      case AssetType.exp:
        {
          exp += asset;
          refreshExp();
          break;
        }
      case AssetType.feed:
        {
          feed += asset;
          refreshfeed();
          break;
        }
    }
  }

  void refreshCoins() {
    game.hud.coinIcon.refreshAsset(coin);
  }

  void refreshGems() {
    game.hud.gemIcon.refreshAsset(gem);
  }

  void refreshExp() {
    game.hud.expBar.refreshAsset(exp);
  }

  void refreshfeed() {
    game.hud.feedIcon.refreshAsset(feed);
  }
}
