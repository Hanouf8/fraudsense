class ListUtilities {
  static int sumUpList(List<int?>? list) {
    int totalAmount = 0;
    if (list == null) {
      return 0;
    }

    for (int i = 0; i < list.length; i++) {
      totalAmount += list[i] ?? 0;
    }
    return totalAmount;
  }

  static bool isListAllTrue(List<bool?>? list) {
    if (list == null) {
      return false;
    }

    for (int i = 0; i < list.length; i++) {
      if (list[i] == null) return false;

      if (list[i] == false) {
        return false;
      }
    }

    return true;
  }
}
