// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Map<String, dynamic> dataList = {};

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.post(
      Uri.parse('https://api.thenotary.app/lead/getLeads'),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: json.encode({"notaryId": "643074200605c500112e0902"}),
    );
    setState(() {
      dataList = jsonDecode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ListExample',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: dataList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dataList['leads'].length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataList['leads'][index]['firstName'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                      // Text(dataList['leads'][index]['lastName'].toString()),
                      Text(
                        dataList['leads'][index]['email'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 20),
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
