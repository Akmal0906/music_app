import 'package:flutter/material.dart';
import 'package:music_app/presentation/view/play_list_screen.dart';
import 'package:music_app/utlis/all_colors/all_color_screen.dart';
import 'package:music_app/utlis/resources/top_music_list/music_list.dart';
import 'package:music_app/utlis/toast_message/toast_class.dart';
import 'package:music_app/utlis/toast_message/toast_message_screen.dart';
import '../../domain/models/music_model.dart';
import '../../utlis/resources/recommend_list_image.dart';
import '../widgets/search_screen_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  List<List<MusicModel>> list = List.from(topSonger);

  void updateList(String value) {
    setState(() {
      list = topSonger
          .where((element) =>
              element.first.author.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColors.backColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(children: [
          const SizedBox(
            height: 28,
          ),
          TextField(
            controller: controller,
            textAlign: TextAlign.left,
            enabled: true,
            keyboardType: TextInputType.text,
            style: const TextStyle(
                color: Colors.white70,
                fontFamily: 'textFont',
                fontSize: 18,
                fontWeight: FontWeight.w600),
            onChanged: (value) => updateList(value),
            decoration: InputDecoration(
              filled: true,
              fillColor: AllColors.textfieldColor,
              constraints: const BoxConstraints(maxHeight: 58),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'lola',
              isDense: true,
              hintStyle: const TextStyle(
                color: AllColors.searchTextColor,
                fontFamily: 'textFont',
                fontSize: 22,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.white70,
                ),
              ),
              suffix: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white70,
                ),
                onPressed: () {
                  controller.clear();
                },
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: list.isEmpty
                ? const Center(
                    child: Text(
                      'Not result found',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'textFont',
                          letterSpacing: 1),
                    ),
                  )
                : GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: list.length,
                    gridDelegate:
                         const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 4),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if(index<5){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlayListScreen(
                                  list: topSonger[index],
                                )));
                          }else{
                            toastMessage(ToastClass.enter);
                          }

                        },
                        child: SearchScreenWidget(list: list, index: index,),
                      );
                    }),
          ),
        ]),
      ),
    );
  }
}

