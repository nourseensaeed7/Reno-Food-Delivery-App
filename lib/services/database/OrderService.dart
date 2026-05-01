import 'package:connectivity_plus/connectivity_plus.dart';
import 'LocalDB.dart';
import 'FireStore.dart';

class OrderService {
  final FireStoreService _firestore = FireStoreService();

  Future<void> saveOrder(String receipt) async {
    // Always save locally first
    await LocalDB.saveOrder(receipt);

    // Check internet connectivity
    final result = await Connectivity().checkConnectivity();
    final hasInternet = result != ConnectivityResult.none;

    if (hasInternet) {
      // If online: also send to Firebase and sync any previously unsynced orders
      await _syncPendingOrders();
    }
    // If offline: order stays in local DB until next time app is online
  }

  // Try to send all unsynced local orders to Firebase
  Future<void> _syncPendingOrders() async {
    final unsynced = await LocalDB.getUnsyncedOrders();
    for (final order in unsynced) {
      try {
        await _firestore.saveOrderToDatabase(order['receipt']);
        await LocalDB.markSynced(order['id']); // mark as done
      } catch (e) {
        // If Firebase fails, leave it unsynced and try again next time
        break;
      }
    }
  }
}