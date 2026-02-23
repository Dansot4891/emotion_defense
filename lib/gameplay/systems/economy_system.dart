import '../../core/game_state.dart';

/// 경제 시스템 - 골드 소비/획득/판매 래퍼
class EconomySystem {
  final GameState gameState;

  EconomySystem({required this.gameState});

  /// 골드 소비 시도
  bool spend(int amount) => gameState.spendGold(amount);

  /// 골드 획득
  void earn(int amount) => gameState.addGold(amount);

  /// 현재 골드
  int get currentGold => gameState.gold;
}
