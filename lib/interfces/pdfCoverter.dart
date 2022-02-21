import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

class pdfConverter extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<pdfConverter> {
  final picker = ImagePicker();
  final pdf = pw.Document();

  TextEditingController pdfName = new TextEditingController();

  // ignore: prefer_final_fields
  List<File> _image = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          title: Text("PDF Converter"),
          actions: [
            IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: () {
                  createPDF();
                  savePDF();
                })
          ],
        ),
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.green[300],
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            //Images
            SpeedDialChild(
              child: Icon(Icons.image),
              label: 'Insert Image',
              backgroundColor: Colors.green[300],
              onTap: () => getImageFromGallery(),
            ),
            //Camera
            SpeedDialChild(
              child: Icon(Icons.camera),
              label: 'Capture Image',
              backgroundColor: Colors.green[300],
              onTap: () => getImageFromCamera(),
            )
          ],
        ),
        body: Center(
            child: new Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: TextField(
                  controller: pdfName,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'PLEASE ENTER THE PDF NAME',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 400.0,
              width: 400.0,
              child: _image != null
                  ? ListView.builder(
                      itemCount: _image.length,
                      itemBuilder: (context, index) => Container(
                          height: 400,
                          width: double.infinity,
                          margin: EdgeInsets.all(8),
                          child: Image.file(
                            _image[index],
                            fit: BoxFit.cover,
                          )),
                    )
                  : Container(),
            ),
          ],
        )));
  }

//get Image from gallery
  getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      } else {
        print('No image selected');
      }
    });
  }

//Get Image from Camera
  Future getImageFromCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
      } else {
        print('No Camera image selected');
      }
    });
  }

//Create PDF
  createPDF() async {
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  }

//SavePDF
  savePDF() async {
    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/${pdfName.text}.pdf');
    await file.writeAsBytes(await pdf.save());

    firebase_storage.UploadTask task = await uploadFile(file, pdfName.text);
    showPrintedMessage('success', 'saved to documents');
  }

  Future<firebase_storage.UploadTask> uploadFile(File file, String name) async {
    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child('$name.pdf');
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes());

    print("done..!");
    return Future.value(uploadTask);
  }

//For the messages that pops up
  showPrintedMessage(String title, String msg) {
    // ignore: avoid_single_cascade_in_expression_statements
    Flushbar(
      title: title,
      message: msg,
      // ignore: prefer_const_constructors
      duration: Duration(seconds: 3),
      icon: const Icon(
        Icons.info,
        color: Colors.green,
      ),
    )..show(context);
  }
}
