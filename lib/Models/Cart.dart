import 'package:flutter/foundation.dart';

import 'Bundle.dart';

class Cart extends ChangeNotifier {
  List<Bundle> bundles;

  Cart({this.bundles});

  double getTotalPrice() {
    double totalPrice = 0;
    if (bundles.isNotEmpty) {
      bundles.forEach((bundle) {
        totalPrice += bundle.product.price * bundle.amount;
      });
    }
    return totalPrice;
  }

  addBundle(Bundle bundleToAdd) {
    Bundle foundBundle = this.findBundle(bundleToAdd);
    if (foundBundle != null) {
      foundBundle.amount++;
    } else {
      bundles.add(bundleToAdd);
    }
    notifyListeners();
  }

  findBundle(Bundle bundleToFind) {
    var bundleFound;
    var barcodeToFind = bundleToFind.product.barcode;

    bundles.forEach((bundle) {
      if (barcodeToFind == bundle.product.barcode) {
        bundleFound = bundle;
        return;
      }
    });
    return bundleFound;
  }

  findByBarcode(String barcode) {
    var foundBundle;
    bundles.forEach((bundle) {
      if (barcode == bundle.product.barcode) {
        foundBundle = bundle;
        return;
      }
    });
    return foundBundle;
  }

  removeBundle(Bundle bundleToRemove) {
    Bundle foundBundle = this.findBundle(bundleToRemove);
    if (foundBundle != null) {
      bundles.remove(bundleToRemove);
    } else {
      return null;
    }
    notifyListeners();
  }

  overrideBundle(Bundle bundleToOverride) {
    var barcodeToFind = bundleToOverride.product.barcode;
    for (var i = 0; i < this.bundles.length; i++) {
      if (barcodeToFind == bundles[i].product.barcode) {
        bundles[i] = bundleToOverride;
      }
    }
    notifyListeners();
    return null;
  }

  // OTHER
}
