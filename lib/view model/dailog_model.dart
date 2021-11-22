import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:provider/provider.dart';

List<String> newsTypeLst = [
  "business",
  "entertainment",
  "science",
  "health",
  "sports",
];
List<String> newsLabel = [
  "Business",
  "Entertainment",
  "Science",
  "Health",
  "Sports",
];

class MyCustomDialog extends StatefulWidget {
  const MyCustomDialog({Key? key}) : super(key: key);

  @override
  _MyCustomDialogState createState() => _MyCustomDialogState();
}

class _MyCustomDialogState extends State<MyCustomDialog> {
  String finalValue = "business";
  String finalType = "Business";
  int indexValue = 0;

  @override
  Widget build(BuildContext context) {
    NewsProvider newsInfoProvider = Provider.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Filter Your News",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                ),
              ),
              Text(
                "Choose Your News Category",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: GoogleFonts.poppins().fontFamily),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: DropdownButtonFormField(
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 14),
                  isExpanded: true,
                  items:
                      newsTypeLst.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text("Choose Category"),
                  onChanged: (String? currentValue) {
                    setState(() {
                      finalValue = currentValue.toString();
                      indexValue = newsTypeLst.indexOf(finalValue);
                      finalType = newsLabel[indexValue];
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      newsInfoProvider.updateWholeNews(finalType, finalType);
                      newsInfoProvider.getmyNews(finalValue);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.filter_list_outlined,
                        color: Colors.white),
                    label: Text(
                      "Filter",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
