import 'package:flutter/material.dart';
import '../data/book.dart';
import '../pages/BookDetails.dart';

//Used in LibraryPage and StorePage
//This is how the the Book's Card will look like in library and store page.
class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //Navigate to Book Details Page
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context){
                  return BookDetails(book: book);
                },
            ),
        );
      },
      child: Card(
        //giving a radius of 10 to the card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Using Expanded Widget to cover all of remaining space for image
            Expanded(
                child: SizedBox(
                    //Required so that Image can fill the complete width of the card
                    width:double.infinity,
                    //Book Image with fit set to BoxFit.fill
                    child: Image.network(book.link, fit: BoxFit.fill),
                ),
            ),
            //Displaying book name
            Text(" ${book.name}"),
            Text(" Price: ${book.price}")
          ],
        ),
      ),
    );
  }
}
