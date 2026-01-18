import 'package:flutter/material.dart';
import 'package:flutter_user/user_create.dart';
import 'package:flutter_user/user_detail.dart';
import 'package:flutter_user/user_info.dart';

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
  ];

  // Navigasi ke form dan terima data baru
  void goToAddUserForm() async {
    // Kirim list users ke form, tunggu hasil
    final newUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserCreatePage(),
      ),
    );

    // Jika ada data baru yang dikembalikan, tambahkan ke list
    if (newUser != null) {
      setState(() {
        users.add(newUser);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New User "${newUser['name']}" added successfuly!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void deleteUser(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete confirmation'),
        content: Text('Delete user ${users[index]['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                users.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('User deleted successfuly!')),
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 120, 183, 236),
                    Color.fromARGB(255, 169, 114, 179),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'User Profile Page',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UserInfoPage(),
                                  ));
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 20),

                      // SearchBar
                      TextField(
                        controller: searchController,
                        onChanged: filterUsers,
                        decoration: InputDecoration(
                          hintText: 'Search by name or email...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    searchController.clear();
                                    filterUsers('');
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Found ${filteredUsers.length} user(s)',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 10),

                      filteredUsers.isEmpty
                          ? const Center(
                              child: Column(
                                children: [
                                  Icon(Icons.search_off,
                                      size: 64, color: Colors.black),
                                  SizedBox(height: 16),
                                  Text(
                                    'No users found',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredUsers.length,
                              separatorBuilder: (_, __) => Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey[300],
                              ),
                              itemBuilder: (context, index) {
                                final user = filteredUsers[index];
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child:
                                        Icon(Icons.person, color: Colors.white),
                                  ),
                                  title: Text(
                                    user['name']!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(user['email']!),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.visibility,
                                            color: Colors.grey[800]),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => UserDetailPage(
                                              user: user,
                                            ),
                                          ),
                                        ),
                                        tooltip: 'Detail',
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.grey[800]),
                                        onPressed: () => deleteUser(index),
                                        tooltip: 'Delete',
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UserDetailPage(
                                          user: user,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: goToAddUserForm,
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow[100],
        ),
      ),
    );
  }
}
