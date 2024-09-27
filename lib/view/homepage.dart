import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/model/comments_provider.dart';
import 'package:lingopanda/res/color.dart';
import 'package:lingopanda/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Comments',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: size.width * 0.05,
                  color: AppColors.frontColor,
                  fontWeight: FontWeight.bold,
                )),
            actions: [
              IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, RoutesName.login_screen);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            ],
            backgroundColor: AppColors.buttonColor,
          ),
        ),
        body: Consumer<CommentsProvider>(
          builder: (context, provider, child) {
            return provider.comments.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: provider.comments.length,
                    itemBuilder: (context, index) {
                      final comment = provider.comments[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        
                        child: Card(
                          color: AppColors.frontColor,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.bgColor,
                              radius: size.width * 0.08,
                              child: Text(
                                comment.name != null && comment.name!.isNotEmpty
                                    ? comment.name![0].toUpperCase()
                                    : 'A',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * 0.06,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: RichText(
                              text: TextSpan(
                                text: "Name: ",
                                style: Theme.of(context).textTheme.displayLarge,
                                children: [
                                  TextSpan(
                                    text: comment.name ?? 'No Name',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                text: "Email: ",
                                style: Theme.of(context).textTheme.displayLarge,
                                children: [
                                  
                                  TextSpan(
                                    
                                    text: provider
                                        .getMaskedEmail(comment.email ?? ''),
                                        
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  TextSpan(
                                    text: '\n${comment.body}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
