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

  // Store username-password pairs for authentication
  Map<String, String> users = {
    "priyank_16": "Password123@",
    "_nitish31": "Nitish31#",
    "Yug_patel": "Yug2005!",
    "prince_6_patel": "Prince6patel&"
  };

  // Store following relationships per user
  Map<String, List<String>> following = {
    "priyank_16": [],
    "_nitish31": [],
    "Yug_patel": [],
    "prince_6_patel": []
  };

  String? currentUser; // Track the logged-in user
  bool start = false;
  bool follow_found = false;
  bool onetime = true;

  Profile() {
    while (true) {
      if (currentUser == null) {
        // Show login/create profile menu for unauthenticated users
        print("\n1. Login");
        print("2. Create Profile");
        print("3. Exit");
      } else {
        // Show main menu for authenticated users
        print("\nWelcome, $currentUser!");
        print("1. Search Profile");
        print("2. Your Profile");
        print("3. Logout");
      }

      stdout.write("\nEnter your choice: ");
      String? choice = stdin.readLineSync();

      if (choice == null || choice.isEmpty) {
        continue;
      }

      try {
        int input = int.parse(choice);

        if (currentUser == null) {
          // Unauthenticated user options
          if (input == 1) {
            login();
          } else if (input == 2) {
            setprofile();
            createprofile();
          } else if (input == 3) {
            print("Exiting...");
            break;
          } else {
            print("Invalid choice! Please select 1, 2, or 3.");
          }
        } else {
          // Authenticated user options
          if (input == 1) {
            findprofile();
          } else if (input == 2) {
            manageProfile();
          } else if (input == 3) {
            logout();
          } else {
            print("Invalid choice! Please select 1, 2, or 3.");
          }
        }
      } catch (e) {
        print("Enter valid input!");
      }
    }
  }

  void login() {
    stdout.write("\nEnter your profile name: ");
    String? username = stdin.readLineSync();
    if (username == null || !profiles.containsKey(username)) {
      print("Profile does not exist!");
      return;
    }

    stdout.write("Enter your password: ");
    String? password = stdin.readLineSync();
    if (password == users[username]) {
      currentUser = username;
      print("Login successful! Welcome, $currentUser!");
    } else {
      print("Incorrect password!");
    }
  }

  void logout() {
    print("Logged out successfully.");
    currentUser = null;
    start = false;
  }

  void setprofile() {
    print(
        "\n📌 Profile Name Instructions:\nLength of Profile Name [8-20] and contains at least one [A-Z], [a-z], [0-9], and [_], but no [@#%^&*\$]\n");

    stdout.write("Enter your profile name: ");
    String? newProfile = stdin.readLineSync();

    if (newProfile == null || newProfile.isEmpty) {
      print("Profile name cannot be empty!");
      return setprofile();
    }

    if (!(newProfile.length >= 8 &&
        newProfile.length <= 20 &&
        newProfile.contains(RegExp(r'[_]')) &&
        newProfile.contains(RegExp(r'[0-9]')) &&
        newProfile.contains(RegExp(r'[A-Z]')) &&
        newProfile.contains(RegExp(r'[a-z]')) &&
        !newProfile.contains(RegExp(r'[@#%^&*$]')))) {
      print("Invalid format!");
      return setprofile();
    }

    if (profiles.containsKey(newProfile)) {
      print("This profile already exists!");
      return;
    }

    currentUser = newProfile;
    profiles[currentUser!] = {};
    following[currentUser!] = [];
  }

  void setemail() {
    stdout.write("Enter your email: ");
    String? email = stdin.readLineSync();
    if (email == null || !(email.contains("@") && email.contains(".com"))) {
      print("Invalid email format!");
      return setemail();
    }

    profiles[currentUser!]!.update("email", (value) => email, ifAbsent: () => email);
  }

  void setpassword() {
    print(
        "\n📌 Password Instructions:\nLength of password [8-20] and contains at least one [A-Z], [a-z], [0-9], and [@#%^&*\$]\n");
    stdout.write("Set strong password: ");
    String? password = stdin.readLineSync();

    if (password == null ||
        !(password.length >= 8 &&
            password.length <= 20 &&
            password.contains(RegExp(r'[@#%^&*$]')) &&
            password.contains(RegExp(r'[A-Z]')) &&
            password.contains(RegExp(r'[0-9]')) &&
            password.contains(RegExp(r'[a-z]')))) {
      print("Invalid password format!");
      return setpassword();
    }

    users[currentUser!] = password;
    print("Password set successfully.");
  }

  int setyear() {
    stdout.write("\nEnter your Year of Birth: ");
    String? y_dob = stdin.readLineSync();
    try {
      int dob_y = int.parse(y_dob!);
      if (!(dob_y <= 2024 && dob_y >= 1900 && y_dob.length == 4)) {
        print("Invalid year!");
        return setyear();
      }
      return dob_y;
    } catch (e) {
      print("Invalid input!");
      return setyear();
    }
  }

  int setmonth() {
    stdout.write("\nEnter your Month of Birth: ");
    String? m_dob = stdin.readLineSync();
    try {
      int dob_m = int.parse(m_dob!);
      if (!(dob_m <= 12 && dob_m >= 1)) {
        print("Invalid month!");
        return setmonth();
      }
      return dob_m;
    } catch (e) {
      print("Invalid input!");
      return setmonth();
    }
  }

  int setday() {
    stdout.write("\nEnter your Day of Birth: ");
    String? d_dob = stdin.readLineSync();
    try {
      int dob_d = int.parse(d_dob!);
      if (!(dob_d <= 31 && dob_d >= 1)) {
        print("Invalid day!");
        return setday();
      }
      return dob_d;
    } catch (e) {
      print("Invalid input!");
      return setday();
    }
  }

  void setdob() {
    int year = setyear();
    int month = setmonth();
    int day = setday();
    profiles[currentUser!]!.update("DOB", (value) => "$day/$month/$year",
        ifAbsent: () => "$day/$month/$year");
  }

  void settype() {
    stdout.write("Profile Type: [public, private] ");
    String? profile_type = stdin.readLineSync();
    if (profile_type == "public" || profile_type == "private") {
      profiles[currentUser!]!.update("Profile Type", (value) => profile_type,
          ifAbsent: () => profile_type);
    } else {
      print("Please enter 'public' or 'private'!");
      settype();
    }
  }

  void createprofile() {
    settype();
    setemail();
    setpassword();
    setdob();
    profiles[currentUser!]!.update("followers", (value) => 0, ifAbsent: () => 0);
    profiles[currentUser!]!.update("following", (value) => 0, ifAbsent: () => 0);
    print("\nProfile successfully created!");
  }

  void updateprofile() {
    stdout.write("Enter the entity to update (DOB, password, Profile Type, profile, email): ");
    String? update_entity = stdin.readLineSync();

    if (update_entity == "DOB") {
      setdob();
      print("Profile successfully updated!");
    } else if (update_entity == "password") {
      stdout.write("Enter your current password: ");
      String? old_password = stdin.readLineSync();
      if (old_password == users[currentUser!]) {
        setpassword();
        print("Profile successfully updated!");
      } else {
        print("Incorrect password!");
      }
    } else if (update_entity == "Profile Type") {
      stdout.write("Enter the new profile type (public, private): ");
      String? new_value = stdin.readLineSync();
      if (new_value == "public" || new_value == "private") {
        profiles[currentUser!]!["Profile Type"] = new_value;
        print("Profile successfully updated!");
      } else {
        print("Invalid profile type!");
      }
    } else if (update_entity == "profile") {
      print(
          "\n📌 Profile Name Instructions:\nLength of Profile Name [8-20] and contains at least one [A-Z], [a-z], [0-9], and [_], but no [@#%^&*\$]\n");
      stdout.write("Enter new profile name: ");
      String? newprofile = stdin.readLineSync();

      if (newprofile == null || newprofile.isEmpty) {
        print("Profile name cannot be empty!");
        return;
      }

      if (!(newprofile.length >= 8 &&
          newprofile.length <= 20 &&
          newprofile.contains(RegExp(r'[_]')) &&
          newprofile.contains(RegExp(r'[0-9]')) &&
          newprofile.contains(RegExp(r'[A-Z]')) &&
          newprofile.contains(RegExp(r'[a-z]')) &&
          !newprofile.contains(RegExp(r'[@#%^&*$]')))) {
        print("Invalid format!");
        return;
      }

      if (profiles.containsKey(newprofile)) {
        print("This profile already exists!");
        return;
      }

      var value = profiles[currentUser!];
      profiles.remove(currentUser!);
      users[newprofile] = users[currentUser!]!;
      users.remove(currentUser!);
      following[newprofile] = following[currentUser!]!;
      following.remove(currentUser!);
      profiles[newprofile] = value!;
      currentUser = newprofile;
      print("Profile name updated successfully!");
    } else if (update_entity == "email") {
      setemail();
      print("Profile successfully updated!");
    } else {
      print("Invalid entity!");
    }
  }

  void deleteprofile() {
    stdout.write("Enter your password: ");
    String? check_password = stdin.readLineSync();
    if (check_password == users[currentUser!]) {
      stdout.write("Are you sure you want to delete your profile? [y/n]: ");
      String? yesno = stdin.readLineSync();
      if (yesno == "y") {
        profiles.remove(currentUser!);
        users.remove(currentUser!);
        following.remove(currentUser!);
        print("Profile successfully deleted!");
        currentUser = null;
      }
    } else {
      print("Incorrect password!");
    }
  }

  void manageProfile() {
    while (true) {
      print("\n$currentUser: ${profiles[currentUser!]}");
      print("1. Update Profile");
      print("2. Delete Profile");
      print("3. Back to Main Menu");

      stdout.write("\nEnter your choice: ");
      String? choice = stdin.readLineSync();
      if (choice == null) continue;

      try {
        int input = int.parse(choice);
        if (input == 1) {
          updateprofile();
        } else if (input == 2) {
          deleteprofile();
          break;
        } else if (input == 3) {
          break;
        } else {
          print("Invalid choice!");
        }
      } catch (e) {
        print("Enter valid input!");
      }
    }
  }

  void findprofile() {
    stdout.write("\nEnter the profile name to search: ");
    String? search = stdin.readLineSync();
    if (search == null || !profiles.containsKey(search)) {
      print("Profile not found!");
      return;
    }

    print("$search: ${profiles[search]}");
    follower_following(search, profiles[search]!["Profile Type"]);
  }

  void follower_following(String search, String account_type) {
    List<String> already_followed = following[currentUser!]!;

    if (start) {
      for (var find in already_followed) {
        if (find == search) {
          if (account_type == "public") {
            print("You are following $search");
            follow_found = true;
            break;
          } else {
            print("Follow request sent to $search");
            follow_found = true;
            break;
          }
        }
      }
    }

    start = true;
    if (!follow_found) {
      stdout.write("Want to follow $search? [y/n]: ");
      String? followers = stdin.readLineSync();
      if (followers == "y") {
        already_followed.add(search);
        profiles[search]!["followers"] += 1;
        profiles[currentUser!]!["following"] += 1;
        if (account_type == "public") {
          print("You are now following $search");
        } else {
          print("Follow request sent to $search");
        }
      }
    }
    follow_found = false;
  }
}

void main() {
  Profile myProfile = Profile();
}