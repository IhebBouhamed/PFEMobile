// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class listeLigneDocument extends StatefulWidget {
  int? ligneDocumentId;
  listeLigneDocument(this.ligneDocumentId);

  @override
  State<listeLigneDocument> createState() => _listeLigneDocumentState();
}

class _listeLigneDocumentState extends State<listeLigneDocument> {
  List? ligneDocuments = [];
  @override
  void initState() {
    super.initState();
    fetchLigneDocuments();
  }

  fetchLigneDocuments() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/lignedocument'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        ligneDocuments = items;
      });
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: const <DataColumn>[
      DataColumn(
          label: Flexible(
        child: Text("Référence Produit",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      )),
      DataColumn(
          label: Flexible(
        child: Text("Nom Produit",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      )),
      DataColumn(
          label: Flexible(
        child: Text("Quantité Produit",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      )),
      DataColumn(
          label: Flexible(
        child: Text("Prix Produit",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      )),
      DataColumn(
          label: Flexible(
        child: Text("Total par ligne",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      )),
    ], rows: <DataRow>[
      for (var i = 0; i < ligneDocuments!.length; i++)
        if (ligneDocuments![i]['id_doc'] == widget.ligneDocumentId)
          DataRow(cells: <DataCell>[
            DataCell(Center(
              child: Text(
                ligneDocuments![i]['refProd'].toString(),
                style: TextStyle(color: Colors.white),
              ),
            )),
            DataCell(Center(
              child: Text(ligneDocuments![i]['nomProd'].toString(),
                  style: TextStyle(color: Colors.white)),
            )),
            DataCell(Center(
              child: Text(ligneDocuments![i]['qteProd'].toString(),
                  style: TextStyle(color: Colors.white)),
            )),
            DataCell(Center(
              child: Text(ligneDocuments![i]['prixProd'].toString() + " DT",
                  style: TextStyle(color: Colors.white)),
            )),
            DataCell(Center(
              child: Text(
                  (ligneDocuments![i]['qteProd'] *
                              ligneDocuments![i]['prixProd'])
                          .toString() +
                      " DT",
                  style: TextStyle(color: Colors.white)),
            ))
          ])
    ]);
  }
}
