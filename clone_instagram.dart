import 'dart:io';

Map<String, dynamic> profiles = {};
bool found = false;
bool update_found = false;
bool delete_found = false;

void main(List<String> args) {
  while (true) {
    print("\n1. Create Profile");
    print("2. Update Profile");
    print("3. Visit Profile");
    print("4. Delete Profile");
    print("5. Exist Profile");
    stdout.write("\nEnter your choice: ");
    String? choice = stdin.readLineSync();

    if (choice != null) {
      try {
        int input = int.parse(choice);

        if (input == 1) {
          // Create Profile
          stdout.write("Enter your name: ");
          String? name = stdin.readLineSync();

          dynamic check_profiles = profiles.keys.toList();

          // For Each: Type-1
          for (var check in check_profiles) {
            if (check == name) {
              print("This Profile is already exists...");
              found = true;
              break;
            }
          }
          if (!found) {
            profiles.update("$name", (value) => value, ifAbsent: () => {});
            createprofile(name);
          }
        } else if (input == 2) {
          // Update Profile
          updateprofile();
        } else if (input == 3) {
          // Read Profile
          readprofile();
        } else if (input == 4) {
          // Delete Profile
          deleteprofile();
        } else if (input == 5) {
          // Exisitng
          break;
        } else {
          print("Enter valid Input!");
        }
      } catch (e) {
        print("Enter valid input!");
      }
    }
  }
}

void createprofile(String? name) {
  stdout.write("Enter your age: ");
  String? str_age = stdin.readLineSync();
  if (str_age != null) {
    dynamic age = int.parse(str_age);
    profiles[name].update("age", (value) => value, ifAbsent: () => age);
  }

  stdout.write("Enter your email: ");
  String? email = stdin.readLineSync();
  profiles[name].update("email", (value) => value, ifAbsent: () => email);

  stdout.write("Enter your height: ");
  String? str_height = stdin.readLineSync();
  if (str_height != null) {
    dynamic height = double.parse(str_height);
    profiles[name].update("height", (value) => value, ifAbsent: () => height);
  }

  stdout.write("Enter your weight: ");
  String? str_weight = stdin.readLineSync();
  if (str_weight != null) {
    dynamic weight = double.parse(str_weight);
    profiles[name].update("weight", (value) => value, ifAbsent: () => weight);
  }

  print("\nProfile Successfully Created...");
}

void updateprofile() {
  stdout.write("Enter profile name: ");
  String? update_name = stdin.readLineSync();

  dynamic check_profiles = profiles.keys.toList();

  // For Each: Type-1
  for (var check in check_profiles) {
    if (check == update_name) {
      update_found = true;
      break;
    }
  }

  if (update_found) {
    stdout.write("Enter the name of the entity to update: ");
    String? update_entity = stdin.readLineSync();

    stdout.write("Enter the new value: ");
    dynamic new_value = stdin.readLineSync();

    profiles[update_name][update_entity] = new_value;

    print("\nProfile Successfully Updated...");
  } else {
    print("\nProfile not found!\n");
    stdout.write("Want to create profile with this name? Type y/n: ");
    String? yesno = stdin.readLineSync();

    if (yesno == "y") {
      profiles.update("$update_name", (value) => value, ifAbsent: () => {});
      createprofile(update_name);
    }
  }
}

void readprofile() {
  stdout.write("Enter profile name: ");
  String? profile_name = stdin.readLineSync();

  dynamic check_profiles = profiles.keys.toList();

  // For Each: Type-1
  for (var check in check_profiles) {
    if (check == profile_name) {
      found = true;
      break;
    }
  }
  if (!found) {
    print("\nProfile doesnot exists...\n");
    stdout.write("Want to create profile with this name? Type y/n: ");
    String? yesno = stdin.readLineSync();

    if (yesno == "y") {
      profiles.update("$profile_name", (value) => value, ifAbsent: () => {});
      createprofile(profile_name);
    }
  } else {
    print(profiles[profile_name]);
  }
}

void deleteprofile() {
  stdout.write("Enter profile name: ");
  String? delete_profile = stdin.readLineSync();

  dynamic check_profiles = profiles.keys.toList();

  // For Each: Type-1
  for (var check in check_profiles) {
    if (check == delete_profile) {
      delete_found = true;
      break;
    }
  }
  if (delete_found) {
    profiles.remove(delete_profile);
    delete_found = false;
    print("\nProfile Successfully Deleted...");
  } else {
    print("\nProfile doesnot exists...\n");
    stdout.write("Want to create profile with this name? Type y/n: ");
    String? yesno = stdin.readLineSync();

    if (yesno == "y") {
      profiles.update("$delete_profile", (value) => value, ifAbsent: () => {});
      createprofile(delete_profile);
    }
  }
}