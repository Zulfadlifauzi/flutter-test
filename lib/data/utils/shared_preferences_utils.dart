import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract mixin class SharedPreferencesMixin {
  static SharedPreferences sharedPrefs =
      SharedPreferences.getInstance() as SharedPreferences;

  static init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  // Method to save list of maps in local storage using SharedPreferences
  static Future<void> saveListMapSharedPreferences(
      String key, List value) async {
    String jsonString = jsonEncode(value);
    await sharedPrefs.setString(key, jsonString);
  }

/*
// READ
*/

  // Method to read list of maps from local storage using SharedPreferences
  static Future<List<Map<String, dynamic>>> readListMapSharedPreferences(
      String key) async {
    try {
      // Retrieve the JSON string from SharedPreferences
      String? jsonString = sharedPrefs.getString(key);

      // Check if the JSON string is not null
      if (jsonString != null) {
        // Decode the JSON string into a list of maps
        List<dynamic> jsonList = jsonDecode(jsonString);

        // Ensure the list is of type List<Map<String, dynamic>>
        return jsonList.cast<Map<String, dynamic>>();
      } else {
        // Return an empty list if no data is found
        return [];
      }
    } catch (e) {
      // Log the error and return an empty list
      return [];
    }
  }

  /*
  // REMOVE
  */

  // Method to remove single data in list local storage using SharedPreferences
  static Future<void> removeSingleDataMapListSharedPreferences(
      String key, int index) async {
    // Retrieve the list from SharedPreferences
    String? jsonString = sharedPrefs.getString(key);
    // Decode the JSON string into a list of maps
    List<dynamic> list = jsonDecode(jsonString.toString());

    // Ensure the list is of type List<Map<String, dynamic>>
    if (list.isNotEmpty) {
      // Remove the specific map entry
      if (index >= 0 && index < list.length) {
        list.removeAt(index);
      }

      // Encode the list back to a JSON string
      String updatedJsonString = jsonEncode(list);

      // Save the updated list back to SharedPreferences
      await sharedPrefs.setString(key, updatedJsonString);
    }
  }
}
