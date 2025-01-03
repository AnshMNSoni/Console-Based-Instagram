import 'dart:io';

class Profile {
  Map<String, dynamic> profiles = {
    "Priyank": {
      "Profile Type": "private",
      "email": "patelpriyank1602@gmail.com",
      "DOB": "16/02/2005"
    },
    "Nitish": {
      "Profile Type": "public",
      "email": "nitish_talpada@gmail.com",
      "DOB": "31/03/2005"
    },
    "Yug": {
      "Profile Type": "private",
      "email": "patelyug@gmail.com",
      "DOB": "22/07/2005"
    },
    "Prince": {
      "Profile Type": "public",
      "email": "princepatel2005@gmail.com",
      "DOB": "16/02/2005"
    }
  };

  String? profilename;
  bool found = false;
  bool onetime = true;
  bool insideprofile = true;
  bool searchprofile = false;
  String? password = null;

  Profile() {
    while (true) {
      if (!onetime) {
        print("\n1. Search Profile");
        print("2. Your Profile");
      }
      if (onetime) {
        print("0. Create Profile:");
        onetime = false;
      }

      stdout.write("\nEnter your choice: ");
      String? choice = stdin.readLineSync();

      if (choice == "") {
        onetime = true;
      }

      if (choice != null) {
        try {
          int input = int.parse(choice);

          if (input == 1) {
            // Search Profile
            stdout.write("\nEnter the profile name: ");
            String? search = stdin.readLineSync();

            dynamic check_profiles = profiles.keys.toList();

            for (var check in check_profiles) {
              if (check == search) {
                print("${search}: ${profiles[search]}");
                searchprofile = true;
              }
            }
            if (!searchprofile) {
              print("Profile Not Found!");
            }
            searchprofile = false;
          } else if (input == 2) {
            // Your Profile
            while (insideprofile) {
              print("$profilename: ${profiles[profilename]}");
              print("\n1. Update Profile");
              print("2. Delete Profile");
              print("3. Main Menu");

              stdout.write("\nEnter your choice: ");
              String? choice = stdin.readLineSync();

              if (choice != null) {
                try {
                  int input = int.parse(choice);

                  if (input == 1) {
                    // Update Profile
                    updateprofile();
                  } else if (input == 2) {
                    stdout.write(
                        "Are you sure you want to delete the profile: Type [y/n] ");

                    String? delete_profile = stdin.readLineSync();

                    if (delete_profile == "y") {
                      stdout.write("Enter your profile password: ");
                      String? pass = stdin.readLineSync();

                      if (pass == password) {
                        profiles.remove(profilename);

                        print("\nProfile Successfully Deleted...\n");
                        found = false;
                        onetime = true;
                        insideprofile = true;
                        break;
                      }
                    }
                  } else if (input == 3) {
                    // Goto Mainmenu
                    insideprofile = false;
                  }
                } catch (e) {
                  print("Enter valid Input!\n");
                }
              }
            }
            insideprofile = true;
          } else if (input == 0) {
            // Create Profile

            stdout.write("Enter your name: ");
            profilename = stdin.readLineSync();

            if (profilename == "") {
              print("Profile name cannot be null!\n");
              Profile();
            }

            dynamic check_profiles = profiles.keys.toList();

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
          }
        } catch (e) {
          print("Enter valid input!\n");
        }
      }
    }
  }

  void createprofile() {
    stdout.write("Profile Type: [public, private] ");
    String? profile_type = stdin.readLineSync();
    if (profile_type == "public" || profile_type == "private") {
      profiles[this.profilename].update("Profile Type", (value) => value,
          ifAbsent: () => profile_type);
    } else {
      print("Please enter properly!\n");
      createprofile();
    }

    stdout.write("Enter your email: ");
    String? email = stdin.readLineSync();
    profiles[this.profilename]
        .update("email", (value) => value, ifAbsent: () => email);


    stdout.write("Set your password: ");
    password = stdin.readLineSync();

    stdout.write("Enter your Year of Born: ");
    String? y_dob = stdin.readLineSync();

    stdout.write("Enter your Month of Born: ");
    String? m_dob = stdin.readLineSync();

    stdout.write("Enter your Day of Born: ");
    String? d_dob = stdin.readLineSync();

    profiles[this.profilename].update("DOB", (value) => value,
        ifAbsent: () => "$d_dob/$m_dob/$y_dob");

    print("\nProfile Successfully Created...");
  }

  void updateprofile() {
    stdout.write("Enter the name of the entity to update: ");
    String? update_entity = stdin.readLineSync();

    stdout.write("Enter the new value: ");
    dynamic new_value = stdin.readLineSync();

    profiles[profilename][update_entity] = new_value;

    print("\nProfile Successfully Updated...");
  }

  void deleteprofile() {
    stdout.write("Enter your Password: ");
    String? check_password = stdin.readLineSync();

    if (password == check_password) {
      stdout.write("Sure! Want to delete the prfoile? Type y/n: ");
      String? yesno = stdin.readLineSync();

      if (yesno == "y") {
        profiles.remove(profilename);
        print("\nProfile Successfully Deleted...");
      }
    } else {
      print("Password is incorrect!");
    }
  }
}

void main(List<String> args) {
  Profile myProfile = new Profile();
}
