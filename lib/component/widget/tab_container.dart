import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/block/tab_block/tabblock_bloc.dart';

import 'middle_tabbuttons.dart';

// ignore: must_be_immutable
class TabContainer extends StatelessWidget {
  
  const TabContainer({
    Key? key,
     
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabblockBloc, TabblockState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 36,
          child: Container(
            margin: const EdgeInsets.only(top: 4, bottom: 0),
            padding: const EdgeInsets.only(
              left: 8,
              top: 4,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 218, 216, 216),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabButtons(
                  caption: 'Patient List',
                  onTab: () {
                     
                     
                    context.read<TabblockBloc>().add(addTabIndex(index: 0));
                   //  print(state.index.toString());
                  },
                  index: 0,
                  
                ),
                TabButtons(
                  caption: 'Chief Complaint',
                  onTab: () {
                    context.read<TabblockBloc>().add(addTabIndex(index: 1));
                    
                   // print(state.index.toString());
                  },
                  index: 1,
                  
                ),
                TabButtons(
                  caption: 'Relevant History',
                  onTab: () {
                    
                    context.read<TabblockBloc>().add(addTabIndex(index: 2));
                  },
                  index: 2,
                  
                ),
                TabButtons(
                  caption: 'Clinical Findingss',
                  onTab: () {
                   
                    context.read<TabblockBloc>().add(addTabIndex(index: 3));
                  },
                  index: 3,
                  
                ),
                TabButtons(
                  caption: 'Clinical Impression',
                  onTab: () {
                    
                    context.read<TabblockBloc>().add(addTabIndex(index: 4));
                  },
                  index: 4,
                  
                ),
                TabButtons(
                  caption: 'Investigations',
                  onTab: () {
                    context.read<TabblockBloc>().add(addTabIndex(index: 5));
                    
                  },
                  index: 5,
                  
                ),
                TabButtons(
                  caption: 'Medications',
                  onTab: () {
                    context.read<TabblockBloc>().add(addTabIndex(index: 6));
                   
                  },
                  index: 6,
                  
                ),
                TabButtons(
                  caption: 'Advices',
                  onTab: () {
                    context.read<TabblockBloc>().add(addTabIndex(index: 7));
                   
                  },
                  index: 7,
                 
                ),
                TabButtons(
                  caption: 'Management Plan',
                  onTab: () {
                    context.read<TabblockBloc>().add(addTabIndex(index: 8));
                    
                  },
                  index: 8,
                  
                ),
                TabButtons(
                  caption: 'Unit Wise Feature',
                  onTab: () {
                    context.read<TabblockBloc>().add(addTabIndex(index: 9));
                    
                  },
                  index: 9,
                   
                ),
                TabButtons(
                  caption: 'Preview',
                  onTab: () {
                    context.read<TabblockBloc>().add(addTabIndex(index: 10));
                    
                  },
                  index: 10,
                  
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
