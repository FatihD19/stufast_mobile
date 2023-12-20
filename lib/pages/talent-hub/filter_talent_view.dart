// import 'package:flutter/material.dart';
// import 'package:stufast_mobile/theme.dart';

// class TalentFilterView extends StatefulWidget {
//   const TalentFilterView({super.key});

//   @override
//   State<TalentFilterView> createState() => _TalentFilterViewState();
// }

// class _TalentFilterViewState extends State<TalentFilterView> {
//    TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   String _sortBy = '';
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 257,
//       padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Urutkan berdasarkan',
//                   style: primaryTextStyle.copyWith(
//                       fontWeight: bold, fontSize: 18)),
//               InkWell(
//                   onTap: () {
//                     setState(() {
//                       _searchController.text = '';
//                       _searchQuery = '';
//                       _sortBy = '';
//                       _currentPage = 1;
//                     });
//                     talentHubProvider.resetTalent();
//                     Provider.of<TalentHubProvider>(context, listen: false)
//                         .getTalentHub(
//                             index: _currentPage,
//                             sort: _sortBy,
//                             searchQuery: _searchQuery);
//                     Navigator.pop(context);
//                   },
//                   child: Text('Reset',
//                       style: thirdTextStyle.copyWith(fontSize: 14)))
//             ],
//           ),
//           SizedBox(height: 24),
//           Container(
//             child: Column(
//               children: [
//                 RadioListTile(
//                     title: Text('Nilai Tertinggi',
//                         style: _sortBy == 'average_score'
//                             ? thirdTextStyle.copyWith(fontSize: 18)
//                             : secondaryTextStyle.copyWith(fontSize: 18)),
//                     value: 'average_score',
//                     groupValue: _sortBy,
//                     onChanged: (value) {
//                       setState(() {
//                         _sortBy = value.toString();
//                         _currentPage = 1;
//                       });
//                     }),
//                 RadioListTile(
//                     title: Text('Jumlah Sertifikat',
//                         style: _sortBy == 'total_course'
//                             ? thirdTextStyle.copyWith(fontSize: 18)
//                             : secondaryTextStyle.copyWith(fontSize: 18)),
//                     value: 'total_course',
//                     groupValue: _sortBy,
//                     onChanged: (value) {
//                       setState(() {
//                         _sortBy = value.toString();
//                         _currentPage = 1;
//                       });
//                     }),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       _sortBy = 'average_score';
//                       _currentPage = 1;
//                     });

//                     talentHubProvider.resetTalent();
//                     Provider.of<TalentHubProvider>(context, listen: false)
//                         .getTalentHub(
//                             index: _currentPage,
//                             sort: _sortBy,
//                             searchQuery: _searchQuery);

//                     Navigator.pop(context);

//                     // Tutup bottom sheet setelah dipilih
//                   },
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Nilai Tertinggi',
//                           style: _sortBy == 'average_score'
//                               ? thirdTextStyle.copyWith(fontSize: 18)
//                               : secondaryTextStyle.copyWith(fontSize: 18)),
//                       Divider(
//                         height: 20,
//                         thickness: 1,
//                         indent: 3,
//                         endIndent: 3,
//                         color: _sortBy == 'average_score'
//                             ? primaryColor
//                             : secondaryColor,
//                       ),
//                     ],
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       _sortBy = 'total_course';
//                       _currentPage = 1;
//                     });

//                     talentHubProvider.resetTalent();
//                     Provider.of<TalentHubProvider>(context, listen: false)
//                         .getTalentHub(
//                             index: _currentPage,
//                             sort: _sortBy,
//                             searchQuery: _searchQuery);

//                     Navigator.pop(context);
//                   },
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Jumlah Course',
//                           style: _sortBy == 'total_course'
//                               ? thirdTextStyle.copyWith(fontSize: 18)
//                               : secondaryTextStyle.copyWith(fontSize: 18)),
//                       Divider(
//                         height: 20,
//                         thickness: 1,
//                         indent: 3,
//                         endIndent: 3,
//                         color: _sortBy == 'total_course'
//                             ? primaryColor
//                             : secondaryColor,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }