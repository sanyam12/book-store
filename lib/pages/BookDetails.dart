import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/book.dart';
import 'BookRead.dart';

//This Widget displays all the various details of the selected book
class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.book});

  final Book book;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {

  //Business Logic to save book to user's library
  void saveToLibrary() async {

    var instance = FirebaseAuth.instance;
    if(instance.currentUser!=null){
      var uid = instance.currentUser!.uid.toString();
      var res = await http.post(
          Uri.parse("https://book-store-i88v.onrender.com/saveToLibrary"),
          headers: {
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "uid": uid,
            "book": widget.book.toJson()
          })
      );

      //Display the Response from backend(could be success or failure)
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.body)));
      }
    }else{
      //Handling case where user isn't logged in
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User not Logged In")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.black,
                child: Image.network(
                  widget.book.link,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 10, 0, 0),
                child: Text(
                  "Title: ${widget.book.name}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 0),
                child: Text(
                  "Price: ${widget.book.price}",
                  style: const TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 0),
                child: Text(
                  "Description:\n${widget.book.description}",
                  style: const TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: saveToLibrary,
                      child: const Text("Save to my Library")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return BookRead(book: widget.book);
                      }));
                    },
                    child: const Text("Read the Book"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
