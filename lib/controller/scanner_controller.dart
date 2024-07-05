import 'package:FindMySpot/constants/colors.dart';
import 'package:FindMySpot/controller/sighnUpController.dart';
import 'package:FindMySpot/model/card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nfc_manager/nfc_manager.dart';

class ScannerController {
  final _firebaseFirestore = FirebaseFirestore.instance;
  // static String cardId = '4058';

  static Set<NfcPollingOption> nfcPollingOption = {
    NfcPollingOption.iso14443,
  };

  static Future<void> onError(NfcError error) async {
    print('Error: ');
  }

  static void checkIfCardIsNotNDEF(Ndef? ndef) {
    if (ndef == null) {
      print('Tag does not contain NDEF data');
      NfcManager.instance.stopSession();
      return;
    }
  }

  static void checkIfCardIsEmpty(NdefMessage? message) {
    if (message == null || message.records.isEmpty) {
      print('NDEF message is empty');
      NfcManager.instance.stopSession();
      return;
    }
  }

  static void restartNFCService() {
    stopNFCService();
    Future.delayed(const Duration(seconds: 5), () => {startNFCService()});
  }

  static void stopNFCService() {
    NfcManager.instance.stopSession();
  }

  Future<void> clientWalletDeduction(String clientId, String vehicleType, DocumentSnapshot<Map<String, dynamic>> feesData) async {
     CollectionReference<Map<String, dynamic>> wallet = await _firebaseFirestore
        .collection('Client')
        .doc(clientId)
        .collection('Wallet');
        if(vehicleType == 'Bike'){
        wallet.doc('Balance').update({'balance': FieldValue.increment(-double.parse(feesData['Bike'].toString()))});
        }
        else {
        wallet.doc('Balance').update({'balance': FieldValue.increment(-double.parse(feesData['Car']))});
        }
        wallet.doc('Transections').collection('fees').doc().set({'amount': 50, 'Deposit Method': 'NFC Card' ,  'Transection Id': 'TID1'});
  }

  Future<void> managerWalletTopUp(String vehicleType, DocumentSnapshot<Map<String, dynamic>> feesData) async {
    CollectionReference<Map<String, dynamic>> wallet =  await _firebaseFirestore
        .collection('Parking Manager')
        .doc(signUpController().getCurrentUserUid())
        .collection('Wallet');
        if(vehicleType == 'Bike'){
        wallet.doc('Balance').update({'balance': FieldValue.increment(double.parse(feesData['Bike'].toString()))});
        }
        else {
        wallet.doc('Balance').update({'balance': FieldValue.increment(double.parse(feesData['Car']))});
        }
        wallet.doc('Transections').collection('fees').doc().set({'amount': 50, 'Deposit Method': 'NFC Card' ,  'Transection Id': 'TID1'});
  }

  static void startNFCService() async {
    print('Scanning started...');

    await NfcManager.instance.startSession(
      pollingOptions: nfcPollingOption,
      onError: (err) => onError(err),
      onDiscovered: (NfcTag tag) async {
        print('Tag Detected!');
        try {
          var ndef = Ndef.from(tag);
          checkIfCardIsNotNDEF(ndef!);
          NdefMessage message = await ndef.read();
          checkIfCardIsEmpty(message);
          NdefRecord record = message.records[0];
          List<int> payload = record.payload.sublist(3);
          String text = String.fromCharCodes(payload);
          print('Card data: $text');
          ScannerController.postParkingData(text);
          // restartNFCService();
        } catch (e) {
          print('Something went Wrong!');
        }
      },
    );
  }

  Future<CardModel?> getCardDetails(String cardId) async {
    try {
      final snapshot = await _firebaseFirestore.collection('Card Orders').doc(cardId).get();
      final card = CardModel.fromSnapshot(snapshot);
      return card;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> changeCardStaus(CardModel card) async {
    if (card.cardStatus == 'In') {
      _firebaseFirestore.collection('Card Orders').doc(card.cardId).update({
        'orderData.card_status': 'Out',
      });
    } else {
      _firebaseFirestore.collection('Card Orders').doc(card.cardId).update({
        'orderData.card_status': 'In',
      });
      Get.snackbar("Success", "Access Granted",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: PrimaryColor, colorText: Colors.white);
    }
  }

  Future<void> postDetailForManager(CardModel card, DocumentSnapshot<Map<String, dynamic>> feesData) async {
    if (card.cardStatus == 'In') {
      try {
        DateTime now = DateTime.now();
        _firebaseFirestore
            .collection('Parking Manager')
            .doc(signUpController().getCurrentUserUid())
            .collection('${card.vehicleType}s')
            .where('userId', isEqualTo: card.uuid)
            .where('Time Out', isEqualTo: '')
            .limit(1)
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            querySnapshot.docs[0].reference.update({'Time Out': DateFormat('hh:mm a').format(now)});
          }
        });
        await managerWalletTopUp(card.vehicleType, feesData);
      } catch (e) {
        print(e);
      }
    } else {
      try {
        DateTime now = DateTime.now();
        await _firebaseFirestore
            .collection('Parking Manager')
            .doc(signUpController().getCurrentUserUid())
            .collection('${card.vehicleType}s')
            .add({
          'Date': now,
          'Fees': feesData[card.vehicleType].toString(),
          'Name': card.name,
          'Vehicle No': card.vehicleNo,
          'Time In': DateFormat('hh:mm a').format(now),
          'Time Out': '',
          'userId': card.uuid
        });

      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> postDetailForClient(CardModel card, DocumentSnapshot<Map<String, dynamic>> feesData) async {
    if (card.cardStatus == 'In') {
      try {
        DateTime now = DateTime.now();
        _firebaseFirestore
            .collection('Client')
            .doc(card.uuid)
            .collection('cards')
            .doc(card.cardId)
            .collection('parkingDetails')
            .where('userId', isEqualTo: card.uuid)
            .where('Time Out', isEqualTo: '')
            .limit(1)
            .get()
            .then((QuerySnapshot querySnapshot) {
          print(querySnapshot.docs.length);
          if (querySnapshot.docs.isNotEmpty) {
            if (querySnapshot.docs[0]['Time In'] != null) {
              print(querySnapshot.docs[0]['Time In']);
              querySnapshot.docs[0].reference.update({'Time Out': DateFormat('hh:mm a').format(now)});
            }
          }
        });
        await clientWalletDeduction(card.uuid, card.vehicleType, feesData);
        Get.snackbar("Success", "Access Granted",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: PrimaryColor, colorText: Colors.white);
      } catch (e) {
        print(e);
      }
    } else {
      try {
        DateTime now = DateTime.now();
        await _firebaseFirestore
            .collection('Client')
            .doc(card.uuid)
            .collection('cards')
            .doc(card.cardId)
            .collection('parkingDetails')
            .add({
          'Fees': "50",
          'Location': card.address,
          'Time In': DateFormat('hh:mm a').format(now),
          'Time Out': '',
          'Total Time': '',
          'userId': card.uuid
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> isAmountAvailable(String userId) async {
   DocumentSnapshot<Map<String, dynamic>> balance = await _firebaseFirestore.collection('Client').doc(userId).collection('Wallet').doc('Balance').get();
   if(balance['balance'] != null && double.parse(balance['balance'].toString()) > 0 ){
   return true;
   }
   return false;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getFees() async {
   DocumentSnapshot<Map<String, dynamic>> feesData = await _firebaseFirestore.collection('Parking Manager').doc(signUpController().getCurrentUserUid()).collection('VehicleFee').doc('UpdateFee').get();
   return feesData;
  }

  static void postParkingData(String cardId) async {
    final ScannerController scannerController = ScannerController();
    CardModel? card = await scannerController.getCardDetails(cardId);
    bool amount = await scannerController.isAmountAvailable(card!.uuid);
    if (amount) {
      print('Card is Valid');
      DocumentSnapshot<Map<String, dynamic>> feesData = await scannerController.getFees();
      await scannerController.changeCardStaus(card);
      await scannerController.postDetailForManager(card, feesData);
      await scannerController.postDetailForClient(card, feesData);
    } else {
      print('Card is Invalid or balance is 0');
      Get.snackbar("Failed", "Card is Invalid or balance is 0",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: PrimaryColor, colorText: Colors.white);
    }
  }
}
