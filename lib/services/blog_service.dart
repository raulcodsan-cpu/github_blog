import 'dart:convert';
import 'package:github_blog/data/entry_data.dart';
import 'package:http/http.dart' as http;

class BlogService {
  BlogService({
    // Instead of GET, we use client so mock clients are accepted for test.
    http.Client? client,
    this.baseUrl = 'shoppinglist-81ab6-default-rtdb.firebaseio.com',
    // Init. list
  }) : _client = client ?? http.Client();
  // Private variable for network req.
  final http.Client _client;
  final String baseUrl;

  Future<List<BlogPost>> fetchPosts() async {
    final uri = Uri.https(baseUrl, 'blog_entries.json');

    try {
      final response = await _client.get(uri);
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);

        if (data == null) {
          return [];
        }

        if (data is Map<String, dynamic>) {
          // .entries: Open the 1st dict layer for  post data.
          // .map: Loop through entries
          return data.entries.map((entry) {
            // entry.value has post details (title etc.), but is seen as Object or dynamic
            final postData = Map<String, dynamic>.from(
              entry.value as Map,
            ); // ---> entry. value as Map for dict. conversion
            // Using factory constructor and separating docID with blog data.
            return BlogPost.fromJson(postData, docID: entry.key);
            // The func. must return a list, so after the iterable is transformed to list.
          }).toList();
        } else if (data is List) {
          // if the blogs are saved as an JSON Array (List)
          return data
              // Filter any empty elements
              .where((element) => element != null)
              // Iterate over the left items and returns an iterable of the created BlogPosts
              .map(
                (item) =>
                    // Create w/ fact. const.
                    BlogPost.fromJson(Map<String, dynamic>.from(item as Map)),
              ) // trans. to list for return.
              .toList();
        }

        return [];
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error on fetch: $e');
    }
  }

  Future<BlogPost?> fetchPostById(String id) async {
    final uri = Uri.https(baseUrl, 'blog_entries/$id.json');
    try {
      final response = await _client.get(uri);
      print(response);
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        print(data);
        if (data == null) {
          return null;
        }
        return BlogPost.fromJson(
          Map<String, dynamic>.from(data as Map),
          docID: id,
        );
      }
      return null;
    } catch (e) {
      throw Exception('Network error on fetch: $e');
    }
  }
}
