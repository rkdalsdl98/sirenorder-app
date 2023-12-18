import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/store/event/close_detail_event.dart';
import 'package:sirenorder_app/bloc/store/event/get_store_detail_event.dart';
import 'package:sirenorder_app/bloc/store/store_bloc.dart';
import 'package:sirenorder_app/bloc/store/store_bloc_state.dart';
import 'package:sirenorder_app/model/store_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/store/store_detail.dart';

class StoreItem extends StatelessWidget {
  final StoreModel store;
  void Function(StoreModel store) onSelStore;
  StoreItem({
    super.key,
    required this.store,
    required this.onSelStore,
  });

  showDetail(
    BuildContext context, {
    required String thumbnail,
    required String storename,
    required String address,
    required StoreDetailModel detail,
  }) {
    showModalBottomSheet<bool>(
      context: context,
      builder: (builderContext) => StoreDetail(
        thumbnail: thumbnail,
        storename: storename,
        address: address,
        detail: detail,
      ),
      isScrollControlled: true,
    ).then((isSel) {
      if (isSel != null && isSel) {
        onSelStore(store);
      }
      context.read<StoreBloc>().add(CloseDetailEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = (store.thumbnail == null || store.thumbnail == "")
        ? "https://firebasestorage.googleapis.com/v0/b/mocatmall.appspot.com/o/exception%2Fnotfound.PNG?alt=media&token=1af683ff-9a2b-4ca2-aea4-98c742c22235"
        : store.thumbnail!;
    return BlocBuilder<StoreBloc, StoreBlocState>(
        builder: (blocContext, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state is StoreBlocShowDetailState && state.storeDetail != null) {
          showDetail(
            blocContext,
            thumbnail: thumbnail,
            storename: store.storename,
            address: store.address,
            detail: state.storeDetail!,
          );
        } else if (state is StoreBlocErrorState) {
          var err = state;
          print(err.exception.type);
          showSnackBarMessage(context, err.exception.message);
        }
      });

      return Stack(
        children: [
          InkWell(
            onTap: () => context
                .read<StoreBloc>()
                .add(GetStoreDetailEvent(store.detailId)),
            child: Container(
              height: 100 * getScaleHeight(context),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100 * getScaleWidth(context),
                    height: 100 * getScaleHeight(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(thumbnail),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store.storename,
                          style: TextStyles.defaultStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          store.address,
                          style: TextStyles.defaultStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (store.isOpen)
            Container(
              decoration: const BoxDecoration(
                color: Colors.black26,
              ),
              width: double.maxFinite,
              height: 100 * getScaleHeight(context),
              child: Center(
                child: Text(
                  "현재 영엽준비중인 가게입니다.",
                  style: TextStyles.titleStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
