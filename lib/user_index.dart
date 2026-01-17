import 'package:flutter/material.dart';
import 'package:flutter_user/user_detail.dart';

class UserIndexPage extends StatefulWidget {
  UserIndexPage({Key? key}) : super(key: key);

  @override
  State<UserIndexPage> createState() => _UserIndexPageState();
}

class _UserIndexPageState extends State<UserIndexPage> {
  final List<Map<String, String>> users = [
    {
      'name': 'Budi Santoso',
      'email': 'budi@email.com',
      'username': 'budisantoso09',
      'telp': '0811111111',
      'alamat': 'Jakarta, Indonesia',
    },
    {
      'name': 'Siti Nurhaliza',
      'email': 'siti@email.com',
      'username': 'siti01',
      'telp': '0811111111',
      'alamat': 'Jakarta, Indonesia',
    },
    {
      'name': 'Ahmad Dhani',
      'email': 'ahmad@email.com',
      'username': 'ahmdDan1',
      'telp': '0811111111',
      'alamat': 'Jakarta, Indonesia',
    },
    {
      'name': 'Rina Wijaya',
      'email': 'rina@email.com',
      'username': 'rinawijayaa',
      'telp': '0811111111',
      'alamat': 'Jakarta, Indonesia',
    },
    {
      'name': 'Joko Widodo',
      'email': 'joko@email.com',
      'username': 'widod0',
      'telp': '0811111111',
      'alamat': 'Jakarta, Indonesia',
    },
    {
      'name': 'Dewi Lestari',
      'email': 'dewi@email.com',
      'username': 'delestari',
      'telp': '0811111111',
      'alamat': 'Jakarta, Indonesia',
    },
    {
      'name': 'Andi Pratama',
      'email': 'andi@email.com',
      'username': 'prtamandi',
      'telp': '0811111111',
      'alamat': 'Jakarta, Indonesia',
    },
    {
      'name': 'Maya Sari',
      'email': 'maya@email.com',
      'username': 'mayaa123',
      'telp': '0811111111',
      'alamat': 'Jakarta, Indonesia',
    },
  ];

  // List yang sudah difilter
  List<Map<String, String>> filteredUsers = [];

  // Controller untuk TextField
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Tampilkan semua user di awal
    filteredUsers = users;
  }

  // Fungsi untuk filter data
  void filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = users;
      } else {
        filteredUsers = users.where((user) {
          final name = user['name']!.toLowerCase();
          final email = user['email']!.toLowerCase();
          final searchLower = query.toLowerCase();

          return name.contains(searchLower) || email.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 120, 183, 236),
                  Color.fromARGB(255, 169, 114, 179)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'User Profile Page',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),

                // SearchBar
                TextField(
                  controller: searchController,
                  onChanged: filterUsers,
                  decoration: InputDecoration(
                    hintText: 'Search by name or email...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              filterUsers('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),

                SizedBox(height: 20),

                // Jumlah hasil pencarian
                Text(
                  'Found ${filteredUsers.length} user(s)',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Expanded(
                  child: filteredUsers.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.search_off,
                                  size: 64, color: Colors.grey),
                              const SizedBox(height: 16),
                              Text(
                                'No users found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: Image.asset(
                                  'lib/assets/user.png',
                                  width: 100,
                                ),
                              ),
                              title: Text(
                                filteredUsers[index]['name']!,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(filteredUsers[index]['email']!),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDetailPage(
                                              user: filteredUsers[index],
                                            )));
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey[300],
                            );
                          },
                          itemCount: filteredUsers.length),
                )
              ],
            )),
      ),
    );
  }
}
