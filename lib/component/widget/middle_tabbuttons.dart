import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/block/tab_block/tabblock_bloc.dart';

class TabButtons extends StatelessWidget {
  final String caption;
  final Function() onTab;
  final int index;

  const TabButtons({
    Key? key,
    required this.caption,
    required this.onTab,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: BlocBuilder<TabblockBloc, TabblockState>(
        builder: (context, state) {
          return Container(
             // padding: const EdgeInsets.all(4),
               padding: EdgeInsets.only(left: 4,right: 4,top: 6,bottom: 0),
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color:
                    index != state.index ? Colors.grey[200] : Color.fromARGB(255, 247, 245, 245),
                border: Border.all(color: Colors.black, width: 0.1),
              ),
              child: Text(
                caption,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: index == state.index
                        ? const Color.fromARGB(174, 25, 0, 250)
                        : Colors.black),
              ));
        },
      ),
    );
  }
}
