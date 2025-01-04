import 'dart:io';

class Profile {
  Map<String, dynamic> profiles = {
    "priyank_16": {
      "Profile Type": "private",
      "email": "patelpriyank1602@gmail.com",
      "DOB": "16/02/2005",
      "followers": 325,
      "following": 500
    },
    "_nitish31": {
      "Profile Type": "public",
      "email": "nitish_talpada@gmail.com",
      "DOB": "31/03/2005",
      "followers": 1125,
      "following": 700
    },
    "Yug_patel": {
      "Profile Type": "private",
      "email": "patelyug@gmail.com",
      "DOB": "22/07/2005",
      "followers": 725,
      "following": 200
    },
    "prince_6_patel": {
      "Profile Type": "public",
      "email": "princepatel2005@gmail.com",
      "DOB": "16/02/2005",
      "followers": 5625,
      "following": 3500
    }
  };

  Map<String?, dynamic> following = {};

  String? profilename;
  bool start = false;
  bool found = false;
  bool follow_found = false;
  bool onetime = true;
  bool insideprofile = true;
  bool searchprofile = false;
  String? password;

  Profile() {
    while (true) {
      if (!onetime) {
        print("\n1. Search Profile");
        print("2. Your Profile");
      }
      if (onetime) {
        print("0. Create Profile");
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
            following.update(profilename, (value) => value, ifAbsent: () => []);
            findprofile();
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
            setprofile();
            createprofile();
          }
        } catch (e) {
          onetime = true;
          print("Enter valid input!\n");
        }
      }
    }
  }

  void setprofile() {
    print(
        "\n📌 Profile Name Instructions:\nLength of Proile Name [8-20] and contains atleast one [A-Z], [a-z] and [0-9] and doesnot contains [@#%^&*\$] but contains [_]\n");

    stdout.write("Enter your name: ");
    profilename = stdin.readLineSync();

    if (profilename == "") {
      print("Profile name cannot be null!\n");
      Profile();
    }

    final String? local_profile = profilename;

    if (local_profile == null ||
        !(local_profile.length >= 8 &&
            local_profile.length <= 20 &&
            local_profile.contains(RegExp(r'[_]')) &&
            local_profile.contains(RegExp(r'[0-9]')) &&
            local_profile.contains(RegExp(r'[A-Z]')) &&
            local_profile.contains(RegExp(r'[a-z]')))) {
      print("Invalid format\n");
      setprofile();
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
      profiles.update("$profilename", (value) => value, ifAbsent: () => {});
    }
    found = false;
  }

  void setemail() {
    stdout.write("Enter your email: ");
    String? email = stdin.readLineSync();
    if (email != null && !(email.contains("@") && email.contains(".com"))) {
      print("Invalid Format!\n");
      setemail();
    }

    profiles[this.profilename]
        .update("email", (value) => email, ifAbsent: () => email);
  }

  void setpassword() {
    print(
        "\n📌 Password Instructions:\nLength of password [8-20] and contains atleast one [A-Z], [a-z], [0-9] and [@#%^&*\$]\n");
    stdout.write("Set Strong password: ");
    password = stdin.readLineSync();

    final localPassword = password;

    if (localPassword == null ||
        !(localPassword.length >= 8 &&
            localPassword.length <= 20 &&
            localPassword.contains(RegExp(r'[@#%^&*$]')) &&
            localPassword.contains(RegExp(r'[A-Z]')) &&
            localPassword.contains(RegExp(r'[0-9]')) &&
            localPassword.contains(RegExp(r'[a-z]')))) {
      print("Invalid format\n");
      setpassword();
    } else {
      print("Password Set Successfully...");
    }
  }

  void setdob() {
    stdout.write("\nEnter your Year of Born: ");
    String? y_dob = stdin.readLineSync();
    if (y_dob != null) {
      int dob_y = int.parse(y_dob);

      if (!(dob_y <= 2024 && dob_y >= 0 && y_dob.length == 4)) {
        print("Invalid Year\n");
        setdob();
      }
    }

    stdout.write("\nEnter your Month of Born: ");
    String? m_dob = stdin.readLineSync();
    if (m_dob != null) {
      int dob_m = int.parse(m_dob);

      if (!(dob_m <= 12 && dob_m >= 1)) {
        print("Invalid Month\n");
        setdob();
      }
    }

    stdout.write("\nEnter your Day of Born: ");
    String? d_dob = stdin.readLineSync();
    if (d_dob != null) {
      int dob_d = int.parse(d_dob);

      if (!(dob_d <= 31 && dob_d >= 1)) {
        print("Invalid Day\n");
        setdob();
      }
    }

    profiles[this.profilename].update("DOB", (value) => "$d_dob/$m_dob/$y_dob",
        ifAbsent: () => "$d_dob/$m_dob/$y_dob");
  }

  void settype() {
    stdout.write("Profile Type: [public, private] ");
    String? profile_type = stdin.readLineSync();
    if (profile_type == "public" || profile_type == "private") {
      profiles[this.profilename].update("Profile Type", (value) => profile_type,
          ifAbsent: () => profile_type);
    } else {
      print("Please enter properly!\n");
      settype();
    }
  }

  void createprofile() {
    // Setting Type of Profile
    settype();

    // Setting Email
    setemail();

    // Setting Password
    setpassword();

    // Setting DOB
    setdob();

    profiles[this.profilename]
        .update("followers", (value) => value, ifAbsent: () => 0);

    profiles[this.profilename]
        .update("following", (value) => value, ifAbsent: () => 0);

    print("\nProfile Successfully Created...");
  }

  void updateprofile() {
    stdout.write("Enter the name of the entity to update: ");
    String? update_entity = stdin.readLineSync();

    if (update_entity == "DOB") {
      setdob();
      print("\nProfile Successfully Updated...");
    } else if (update_entity == "password") {
      stdout.write("Enter your old Password: ");
      String? old_password = stdin.readLineSync();

      if (password == old_password) {
        setpassword();
      } else {
        print("Password is incorrect!");
      }
      print("\nProfile Successfully Updated...");
    } else if (update_entity == "Profile Type") {
      stdout.write("Enter the new value: ");
      dynamic new_value = stdin.readLineSync();

      profiles[profilename][update_entity] = new_value;

      print("\nProfile Successfully Updated...");
    } else if (update_entity == "profile") {
      print(
          "\n📌 Profile Name Instructions:\nLength of Proile Name [8-20] and contains atleast one [A-Z], [a-z] and [0-9] and doesnot contains [@#%^&*\$] but contains [_]\n");

      stdout.write("Enter your name: ");
      String? newprofile = stdin.readLineSync();

      if (newprofile == "") {
        print("Profile name cannot be null!\n");
        Profile();
      }

      if (newprofile == null ||
          !(newprofile.length >= 8 &&
              newprofile.length <= 20 &&
              newprofile.contains(RegExp(r'[_]')) &&
              newprofile.contains(RegExp(r'[0-9]')) &&
              newprofile.contains(RegExp(r'[A-Z]')) &&
              newprofile.contains(RegExp(r'[a-z]')))) {
        print("Invalid format\n");
        setprofile();
      }

      dynamic check_profiles = profiles.keys.toList();

      for (var check in check_profiles) {
        if (check == newprofile) {
          print("This Profile is already exists...");
          found = true;
          break;
        }
      }
      if (!found) {
        var value = profiles[profilename];
        profiles.remove(profilename);
        if (newprofile != null) {
          profiles[newprofile] = value;
          profilename = newprofile;
        }
      }
      found = false;
    } else if (update_entity == "email") {
      setemail();
    }
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

  void findprofile() {
    stdout.write("\nEnter the profile name: ");
    String? search = stdin.readLineSync();

    dynamic check_profiles = profiles.keys.toList();

    for (var check in check_profiles) {
      if (check == search) {
        print("${search}: ${profiles[search]}");

        follower_following(search, profiles[search]["Profile Type"]);

        searchprofile = true;
      }
    }
    if (!searchprofile) {
      print("Profile Not Found!");
    }
    searchprofile = false;
  }

  void follower_following(String? search, String account_type) {
    List<String?> already_followed = following[profilename];

    if (start) {
      for (var find in already_followed) {
        if (find == search) {
          if (account_type == "public") {
            print("You are Following $search");
            follow_found = true;
            break;
          } else {
            print("Follow Request Sent to $search");
            follow_found = true;
            break;
          }
        }
      }
    }

    start = true;
    if (!follow_found) {
      if (account_type == "public") {
        stdout.write("Want to Follow $search? Type [y/n]: ");
        String? followers = stdin.readLineSync();
        if (followers == "y") {
          already_followed.add(search);
          profiles[search]["followers"] += 1;
          profiles[profilename]["following"] += 1;
          print("You are now Following $search");
        }
      } else {
        stdout.write("Want to Follow $search? Type [y/n]: ");
        String? followers = stdin.readLineSync();
        if (followers == "y") {
          already_followed.add(search);
          print("Follow Request Sent to $search");
        }
      }
    }
  }
}

void main(List<String> args) {
  Profile myProfile = new Profile();
}
