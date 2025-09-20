import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String className = "Class 6";
  String division = "A";
  String selected = 'Daily';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>?;
    if (args != null) {
      className = args['class'] ?? className;
      division = args['division'] ?? division;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "Reports – $className $division", showSchoolName: true, schoolName: "Sunrise High School"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            ChoiceChip(label: Text('Daily'), selected: selected=='Daily', onSelected: (_) => setState(()=>selected='Daily')),
            SizedBox(width: 8),
            ChoiceChip(label: Text('Weekly'), selected: selected=='Weekly', onSelected: (_) => setState(()=>selected='Weekly')),
            SizedBox(width: 8),
            ChoiceChip(label: Text('Monthly'), selected: selected=='Monthly', onSelected: (_) => setState(()=>selected='Monthly')),
          ]),
          SizedBox(height: 14),
          if (selected == 'Daily') ...[
            ElevatedButton(onPressed: () async {
              DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2100));
              Navigator.pushNamed(context, '/report/daily', arguments: {'date': date, 'class': className, 'division': division});
            }, child: Text('Choose date & View'))
          ] else if (selected == 'Weekly') ...[
            ElevatedButton(onPressed: () {
              // open a week picker or select start date
              Navigator.pushNamed(context, '/report/weekly', arguments: {'class': className, 'division': division});
            }, child: Text('Select week & View'))
          ] else if (selected == 'Monthly') ...[
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, '/report/monthly', arguments: {'class': className, 'division': division});
            }, child: Text('Select month & View'))
          ],
          Spacer(),
          ElevatedButton.icon(onPressed: () {
            // Potential global export or back
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Use specific report export inside each view.')));
          }, icon: Icon(Icons.download), label: Text('Export All')),
        ]),
      ),
    );
  }
}
