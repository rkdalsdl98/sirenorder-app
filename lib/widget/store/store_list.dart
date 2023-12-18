import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/store_model.dart';
import 'package:sirenorder_app/widget/store/sort_store_list_buttons.dart';
import 'package:sirenorder_app/widget/store/store_item.dart';

class StoreList extends StatefulWidget {
  void Function(StoreModel store) onSelStore;
  List<StoreModel> stores;
  StoreList({
    super.key,
    required this.stores,
    required this.onSelStore,
  });

  @override
  State<StoreList> createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  late List<StoreModel> showList;

  sortList(bool isAll) {
    setState(() {
      if (!isAll) {
        showList = [];
        for (var store in widget.stores) {
          if (store.isOpen) showList.add(store);
        }
      } else {
        showList = widget.stores;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    showList = widget.stores;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SortStoreListButtons(onChangeList: sortList),
          SingleChildScrollView(
            child: Column(
              children: showList
                  .map<StoreItem>((store) => StoreItem(
                        store: store,
                        onSelStore: widget.onSelStore,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
