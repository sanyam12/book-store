import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/BookCard.dart';
import '../data/book.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

//This is the Screen which displays All the Books
class _StorePageState extends State<StorePage> {

  List<Book> books = []; //List of All Books received from server

  //Fetch All Books from the server.
  void fetchData() async {
    books = [];
    var data = await http.get(Uri.parse("https://book-store-i88v.onrender.com/getBooks"));
    if(data.statusCode==200){
      final json = jsonDecode(data.body);
      for(var i in json){
        setState(() {
          books.add(
              Book.fromJson(i)
          );
        });
      }
    }else{
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something Went Wrong")));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    //Handle if No Books are received
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
            title: Text("All Books"),
          ),
          // for(var i in books)

          Expanded(
            //This Grid View displays 3 Book Cards per Row
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
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
