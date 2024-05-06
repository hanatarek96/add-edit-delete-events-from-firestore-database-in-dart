import 'dart:convert';

import 'package:http/http.dart' as http;
 dynamic eventId;

final String firebaseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts';
final String apiKey = 'AIzaSyDreQCNmimnvoJESFbMslPUgkdvICMPHII'; // Replace with your Firebase API key
final String firebaseAuthUrl = 'https://identitytoolkit.googleapis.com/v1/accounts';
final String firebaseFirestoreBaseUrl = 'https://firestore.googleapis.com/v1/projects/firsttrialdupli/databases/(default)/documents/users/frPZ8hsg9LMUu4TLhAIodws57ka2';
//final String firebaseFirestoreUrl = 'https://firestore.googleapis.com/v1/projects/firsttrialdupli/databases/(default)/documents/users/o17VC67mmno3HeO8jjtF/info/{USER_ID}'; // Replace with your Firestore URL
  


// Function to add an event
Future<void> addEvent(String eventName, String eventTime, String eventDescription, bool delete) async {
  final eventsCollectionUrl = '$firebaseFirestoreBaseUrl/events';

  // Create the event document with Firestore-generated document ID
  final response = await http.post(
    Uri.parse(eventsCollectionUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'fields': {
        'name': {'stringValue': eventName},
        'time': {'stringValue': eventTime},
        'description': {'stringValue': eventDescription},
        'soft-delete': {'booleanValue':delete }
      },
    }),
  );

  if (response.statusCode == 200) {
    // Parse the response to extract the document ID
    final responseData = json.decode(response.body);
    eventId = responseData['name'].split('/').last;
    
  } else {
    print('Error adding event');
    
  }
}


// Function to edit an event
Future<void> editEvent(String eventName, String newEventName, String newEventTime, String newEventDescription) async {
  final eventsCollectionUrl = '$firebaseFirestoreBaseUrl/events/iB4HLyfdRxa4YyVoDAxY';
    
    // Update the event data
  final response2 = await http.patch(
    Uri.parse(eventsCollectionUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'fields': {
        'name': {'stringValue': newEventName},
        'time': {'stringValue': newEventTime},
        'description': {'stringValue': newEventDescription},
      },
    }),
  );

    if (response2.statusCode == 200) {
      print('Event edited successfully!');
    } else {
      print('Error editing event');
    }
 
}

// Function to delete an event
Future<void> deleteEvent(dynamic eventId,String eventName, String eventTime, String eventDescription, bool delete) async {
  final eventDocUrl = '$firebaseFirestoreBaseUrl/events/$eventId';
  
final response3 = await http.patch(
    Uri.parse(eventDocUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'fields': {
         'name': {'stringValue': eventName},
        'time': {'stringValue': eventTime},
        'description': {'stringValue': eventDescription},
        'soft-delete': {'booleanValue':delete},

        
      },
    }),
  );

    if (response3.statusCode == 200) {
      print('Event deleted successfully!');
    } else {
      print('Error deleting event');
    }
}

void main() {
  // Usage examples:
  
  // Add an event
  //addEvent( 'working again', '2024-05-10 10:00', 'too much work to do', false);
  
  // Edit an eventz
  //editEvent('working again', 'tired', '2024-05-10 11:00', 'Updated description');
  
  // Delete an event
  deleteEvent('iB4HLyfdRxa4YyVoDAxY','work work', '2024-05-10 10:00', 'Updated description',true);
}