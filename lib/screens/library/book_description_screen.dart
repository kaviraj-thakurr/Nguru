import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/custom_alert_dialog.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/library/reserve_book/reserve_book_cubit.dart';
import 'package:nguru/logic/library/reserve_book/reserve_book_state.dart';
import 'package:nguru/models/library_book_search_model.dart';
import 'package:nguru/models/library_history_model.dart';
import 'package:nguru/models/library_issued_book_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class BookDescriptionScreen extends StatefulWidget {

final LibrarySearch? librarySearch;
final LibraryHistory? libraryHistory;
final LibraryIssued? libraryIssued;


  const BookDescriptionScreen({super.key, this.librarySearch, this.libraryHistory, this.libraryIssued});

  @override
  State<BookDescriptionScreen> createState() => _BookDescriptionScreenState();
}

class _BookDescriptionScreenState extends State<BookDescriptionScreen> {
 final TextEditingController _searchController =TextEditingController();
   @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(MyAssets.background_2),
      Column(children: [
        10.heightBox,
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: dashboardAppBar(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: CustomSearchBar(controller: _searchController),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: screenTitleHeader(MyStrings.changeSession,
              onPressed: () => Navigator.pop(context)),
        ),
        Expanded(
          child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  widget.libraryIssued !=null ?  SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Book Name: ${widget.libraryIssued?.bookName}"),
                          20.heightBox,
                         Text("Book ID: ${widget.libraryIssued?.bookId}"),
                          20.heightBox,
                          Text("Acession No: ${widget.libraryIssued?.accessionNo}"),
                          20.heightBox,
                          Text("IssueReturn ID: ${widget.libraryIssued?.issueReturnId}"),
                          20.heightBox,
                          Text("Issue Date: ${widget.libraryIssued?.issueDate}"),
                          20.heightBox,
                          Text("Total records: ${widget.libraryIssued?.totalRecords}"),
                          20.heightBox,
                      
                        ],
                      ),
                    )
                    : 
                    widget.librarySearch !=null ?  SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Book Name: ${widget.librarySearch?.bookName}"),
                          20.heightBox,
                         Text("Author Name: ${widget.librarySearch?.authorName}"),
                          20.heightBox,
                          Text("Publisher Name: ${widget.librarySearch?.publisherName}"),
                          20.heightBox,
                         Text("Book ID: ${widget.librarySearch?.bookId}"),
                          20.heightBox,
                          Text("Acession No: ${widget.librarySearch?.accessionNo}"),
                          20.heightBox,
                          Text("IssueReturn ID: ${widget.librarySearch?.issueReturnId}"),
                          20.heightBox,
                          Text("Issue Date: ${widget.librarySearch?.issueDate}"),
                          20.heightBox,
                          Text("Return Date: ${widget.librarySearch?.returnDate}"),
                          20.heightBox,
                          Text("Total records: ${widget.librarySearch?.totalRecords}"),
                          20.heightBox,
                      
                        ],
                      ),
                    )
                    :
                    widget.libraryHistory !=null ?  SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Book Name: ${widget.libraryHistory?.bookName}"),
                          20.heightBox,
                         Text("Book ID: ${widget.libraryHistory?.bookId}"),
                          20.heightBox,
                          Text("Acession No: ${widget.libraryHistory?.accessionNo}"),
                          20.heightBox,
                          Text("IssueReturn ID: ${widget.libraryHistory?.issueReturnId}"),
                          20.heightBox,
                          Text("Issue Date: ${widget.libraryHistory?.issueDate}"),
                          20.heightBox,
                          Text("Return Date: ${widget.libraryHistory?.returnDate}"),
                          20.heightBox,
                          Text("Total records: ${widget.libraryHistory?.totalRecords}"),
                          20.heightBox,
                      
                        ],
                      ),
                    ):
                    SizedBox()

                    ,
                 widget.librarySearch != null 
                 ?   PrimaryButton(
                      title: "Reserve",
                       onPressed: (){
                        customAlertDiaog(
                "Reserve Book",
                "Want to reserve ${widget.librarySearch?.bookName ?? ""} !",
                "Cancel",
                "Reserve",
                context: context,
                onSubmit: () => context.read<ReserveBookCubit>().reserveBook(
                    widget. librarySearch?.bookId,
                   widget.  librarySearch?.accessionNo,
                   widget.  librarySearch?.issueReturnId)
                  .then((value) => Navigator.pop(context)).then((value) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              BlocBuilder<ReserveBookCubit, ReserveBookState>(
                                  builder: (context, state) {
                        if (state is ReserveBookLoadingState) {
                          return const Text("");
                        }
                        if (state is ReserveBookSuccessState) {
                          return Text(
                              "Reserve ${widget.librarySearch?.bookName ?? ""} Successfully");
                        } else if (state is ReserveBookErrorState) {
                          return Text("${state.message}");
                        } else {
                          return const SizedBox();
                        }
                      })))).then((value) =>{} ),
                onCancel: () {
                
                  Navigator.pop(context);} );
                       }) : SizedBox()
                  ],
                ),
        )
           
      ])
    ]));
  }
}