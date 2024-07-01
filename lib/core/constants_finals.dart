import 'package:flutter/material.dart';

import '../features/invoice/domain/entities/service_entity.dart';

// API
const String url = 'https://bengkel-pak-bowo-services.vercel.app/';
// const String url = 'http://10.0.2.2:3001/';

final Map<String, String> endpoint = {
  'invoice': 'invoice',
  'login': 'login',
  'register': 'register',
  'queue': 'queue',
  'queueNum': 'queueNum',
  'queueMe': 'queueMe',
  'income': 'income',
  'expense': 'expense',
};
final Map<String, String> headers = {
  'Content-Type': 'application/json',
};

// route name
const String initialRoute = '/';
const String registerPage = '${initialRoute}register/';
const String loginPage = '${initialRoute}login/';
const String invoicePage = '${initialRoute}invoice/';
const String makeInvoicePage = '${invoicePage}make/';
const String detailInvoicePage = '${invoicePage}detail/';
const String previewInvoicePage = '${invoicePage}preview/';
const String homePage = '${initialRoute}home/';
const String queuePage = '${initialRoute}detailAntrian/';

final List<Service> items = [
  Service(name: 'Cat Full Body', price: 12000000),
  Service(name: 'Cat Per Panel', price: 700000),
  Service(name: 'Poles Cat Body', price: 800000),
  Service(name: 'Servis AC', price: 1100000),
  Service(name: 'Tune Up', price: 600000),
  Service(name: 'Modif Body Full Cat', price: 15000000),
  Service(name: 'Ganti Kapas Kopling', price: 500000),
];

const List<BoxShadow> doubleBoxShadow = [
  BoxShadow(
      blurRadius: 3,
      spreadRadius: 0,
      offset: Offset(0, 1),
      color: Color.fromRGBO(0, 0, 0, 0.1)),
  BoxShadow(
      blurRadius: 5,
      spreadRadius: 0,
      offset: Offset(0, 5),
      color: Color.fromRGBO(0, 0, 0, .09)),
];

const List<BoxShadow> singleBoxShadow = [
  BoxShadow(
    blurRadius: 4,
    spreadRadius: 1,
    color: Color.fromRGBO(0, 0, 0, .25),
  ),
];
