import 'dart:io';

class Profile {
  Map<String, dynamic> profiles = {};
  String? profilename;
  bool found = false;
  Profile() {
    while (true) {
      print("\n1. Create Profile");
      print("2. Update Profile");
      print("3. Your Profile");
      print("4. Delete Profile");
      print("5. Search Profile");
      print("6. Exist Profile");
      stdout.write("\nEnter your choice: ");
      String? choice = stdin.readLineSync();

      if (choice != null) {
        try {
          int input = int.parse(choice);

          if (input == 1) {
            // Create Profile
            stdout.write("Enter your name: ");
            profilename = stdin.readLineSync();

            dynamic check_profiles = profiles.keys.toList();

            // For Each: Type-1
            for (var check in check_profiles) {
              if (check == profilename) {
                print("This Profile is already exists...");
                found = true;
                break;
              }
            }
            if (!found) {
              profiles.update("$profilename", (value) => value,
                  ifAbsent: () => {});
              createprofile();
            }
            found = false;
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
            dynamic profile_exists = profiles.keys.toList();

            stdout.write("Search for profile: ");
            String? search = stdin.readLineSync();

            for (var check in profile_exists) {
              if (check == search) {
                print("Yes profile found!");
              }
            }
          } else if (input == 6) {
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

  void createprofile() {
    stdout.write("Enter your age: ");
    String? str_age = stdin.readLineSync();
    if (str_age != null) {
      dynamic age = int.parse(str_age);
      profiles[this.profilename]
          .update("age", (value) => value, ifAbsent: () => age);
    }

    stdout.write("Enter your email: ");
    String? email = stdin.readLineSync();
    profiles[this.profilename]
        .update("email", (value) => value, ifAbsent: () => email);

    stdout.write("Enter your height: ");
    String? str_height = stdin.readLineSync();
    if (str_height != null) {
      dynamic height = double.parse(str_height);
      profiles[this.profilename]
          .update("height", (value) => value, ifAbsent: () => height);
    }

    stdout.write("Enter your weight: ");
    String? str_weight = stdin.readLineSync();
    if (str_weight != null) {
      dynamic weight = double.parse(str_weight);
      profiles[this.profilename]
          .update("weight", (value) => value, ifAbsent: () => weight);
    }

    print("\nProfile Successfully Created...");
  }

  void updateprofile() {
    stdout.write("Enter profile name: ");
    String? update_name = stdin.readLineSync();

    stdout.write("Enter the name of the entity to update: ");
    String? update_entity = stdin.readLineSync();

    stdout.write("Enter the new value: ");
    dynamic new_value = stdin.readLineSync();

    profiles[update_name][update_entity] = new_value;

    print("\nProfile Successfully Updated...");
  }

  void readprofile() {
    print(profiles[profilename]);
  }

  void deleteprofile() {
    // password feature - pending
    stdout.write("Sure! Want to delete the prfoile? Type y/n: ");
    String? yesno = stdin.readLineSync();

    if (yesno == "y") {
      profiles.remove(profilename);
      print("\nProfile Successfully Deleted...");
    }
  }
}

void main(List<String> args) {
  Profile myProfile = new Profile();
}
