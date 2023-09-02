import 'dart:convert';
import 'dart:developer';

import 'package:book_store/components/BookCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/book.dart';

//This is the Screen which displays book's added to User's Library
class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<Book> books = []; //List of Books received from server

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  //Fetch Books saved in User's Library from the server.
  void fetchData() async {
    var instance = FirebaseAuth.instance;
    if (instance.currentUser != null) {
      String uid = instance.currentUser!.uid.toString();
      var res = await http.post(
          Uri.parse("http://localhost:3000/getLibrary"),
          headers: {
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "uid": uid
          })
      );

      if (res.statusCode == 200) {
        books = [];
        var json = jsonDecode(res.body);
        log(json.toString());
        for(var i in json){
          setState(() {
            books.add(
                Book.fromJson(i)
            );
          });
        }
      }
      else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Something Went Wrong"),
            ),
          );
        }
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    //Handle if No Books are Stored in Library
    if (books.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      //Display Books stored in Library
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Heading
          const ListTile(
            title: Text("Your Books"),
          ),

          Expanded(
            //This Grid View displays 3 Book Cards per Row
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                ),
                //Count of total books
                itemCount: books.length,
                itemBuilder: (context, i) {
                  //returns Books Card showing info of the Book
                  return SizedBox(
                    width: 0.3 * width,
                    height: 1000,
                    child: BookCard(book: books[i]),
                  );
                },
            ),
          )
        ],
      );
    }
  }
}
