import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'dart:math';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Map<String, dynamic>> posts = [
    {
      'username': 'FitFoodie',
      'time': '1 hr. ago',
      'question': 'What are Healthier Snack Options?',
      'description':
          "Hey everyone, I'm looking for snack ideas that are both nutritious and easy to prepare. I usually find myself reaching for chips or sweets around mid-afternoon.",
      'upvotes': 10,
      'downvotes': 30,
      'comments': 10,
    },
    {
      'username': 'GreenGuru',
      'time': '4 hr. ago',
      'question': 'Quick Breakfast Recipes for Early Mornings?',
      'description':
          "Does anyone have recommendations for quick and healthy breakfast options? I’m always in a rush in the mornings and end up skipping breakfast more often than I’d like.",
      'upvotes': 13,
      'downvotes': 5,
      'comments': 13,
    },
    {
      'username': 'SweetToothSam',
      'time': '4 hr. ago',
      'question': 'Best Way To Dealing with Sugar Cravings?',
      'description':
          "Struggling hard with sugar cravings especially late at night. Does anyone have tips or healthy alternatives that help curb the sweet tooth without reaching for candy or cookies?",
      'upvotes': 53,
      'downvotes': 20,
      'comments': 37,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Community Section",
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              DefaultTabController(
                length: 3,
                child: Expanded(
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: 'Overview'),
                          Tab(text: 'Posts'),
                          Tab(text: 'Live Cooking'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildPostsTab(),
                            _buildPostsTab(),
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 200, // Specify your desired height
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(
                                        20), // Adjust the radius as needed
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Stream starting soon...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        20, // Arbitrary number of comments
                                    itemBuilder: (context, index) => ListTile(
                                      leading: const Icon(Icons.person),
                                      title: Text('User $index'),
                                      subtitle: Text(
                                          'Hello! This is comment number $index.'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddPostDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildPostsTab() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        var post = posts[index];
        return _buildPostCard(
          username: post['username'],
          time: post['time'],
          question: post['question'],
          description: post['description'],
          upvotes: post['upvotes'],
          downvotes: post['downvotes'],
          comments: post['comments'],
          index: index, // Pass index to _buildPostCard
        );
      },
    );
  }

  Widget _buildPostCard({
    required String username,
    required String time,
    required String question,
    required String description,
    required int upvotes,
    required int downvotes,
    required int comments,
    required int index, // Added index parameter to use in the comments button
  }) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
            color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(username[0]),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    username,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                question,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 230, 230, 230),
                          width: 2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.arrow_upward),
                              onPressed: () {}),
                          Text('$upvotes'),
                          IconButton(
                              icon: const Icon(Icons.arrow_downward),
                              onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                  Material(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 230, 230, 230),
                          width: 2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 142, 142, 142),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () => _showCommentsDialog(index),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.comment),
                            const SizedBox(
                                width: 4), // Space between icon and text
                            Text('$comments'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 230, 230, 230),
                          width: 2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 142, 142, 142),
                          padding: const EdgeInsets.all(4.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () {
                          // Define what action to perform when the button is pressed
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share),
                            SizedBox(width: 4), // Space between icon and text
                            Text("Share"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _questionController,
              decoration:
                  const InputDecoration(hintText: 'Enter your question here'),
            ),
            TextField(
              controller: _descriptionController,
              decoration:
                  const InputDecoration(hintText: 'Explanation of question'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _addNewPost();
              Navigator.of(context).pop();
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  void _addNewPost() {
    final newPost = {
      'username': 'NewUser${Random().nextInt(100)}',
      'time': 'Just now',
      'question': _questionController.text,
      'description': _descriptionController.text,
      'upvotes': 0,
      'downvotes': 0,
      'comments': 0,
    };
    setState(() {
      posts.insert(0, newPost);
      _questionController.clear();
      _descriptionController.clear();
    });
  }

  void _showCommentsDialog(int index) {
    // Local list to simulate comments storage, now with realistic dummy comments
    List<String> comments = List.from(posts[index]['commentsData'] ??
        [
          'I’ve tried using Greek yogurt instead of sour cream, and it’s fantastic!',
          'Anyone else love snacking on hummus with sliced cucumbers?',
          'These are great tips! Thanks for sharing, everyone.'
        ]);

    // Controller for the text input
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Comments'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    // Dynamic list of realistic comments with numbers
                    for (int i = 0; i < comments.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${i + 1}. ${comments[i]}', // Numbered comments
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'Write a comment...',
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Add Comment'),
                  onPressed: () {
                    // Add comment to the list and update the state
                    String value = commentController.text;
                    if (value.trim().isNotEmpty) {
                      setState(() {
                        comments.add(value);
                        // Optionally update the main data structure
                        posts[index]['commentsData'] = List.from(comments);
                      });
                      commentController.clear();
                    }
                  },
                ),
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
