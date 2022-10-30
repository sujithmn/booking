
import 'package:booking/model/address.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
   AddressPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
 // LoginBloc _loginBloc = LoginBloc();
  Address address=Address();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
            ),

            const Text(
              "User Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            TextFormField(
                style: const TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Name",
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  fillColor: const Color(
                    0xfff3f3f4,
                  ),
                  filled: true,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                onChanged: (newText) { address.name = newText; }
            ),

            const SizedBox(
              height: 10,
            ),
            const Text(
              "Mobile Number",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            TextFormField(
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Mobile Number",
                  suffixIcon: const Icon(
                    Icons.phone,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  fillColor: const Color(
                    0xfff3f3f4,
                  ),
                  filled: true,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Mobile Number';
                  }
                  return null;
                },
                onChanged: (newText) { address.mobile = newText; }
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Email id",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            TextFormField(
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Email",
                  suffixIcon: const Icon(
                    Icons.email,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  fillColor: const Color(
                    0xfff3f3f4,
                  ),
                  filled: true,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
                onChanged: (newText) { address.email = newText; }
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              "Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            TextFormField(
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Address",
                  suffixIcon: const Icon(
                    Icons.visibility,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  fillColor: const Color(
                    0xfff3f3f4,
                  ),
                  filled: true,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onChanged: (newText) { address.address = newText; }
            ),

            const SizedBox(
              height: 10,
            ),
            const Text(
              "State",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            TextFormField(
              style: const TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.start,
              obscureText: false,
              decoration: InputDecoration(
                hintText: "State",
                suffixIcon: const Icon(
                  Icons.visibility,
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                fillColor: const Color(
                  0xfff3f3f4,
                ),
                filled: true,
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter State';
                }
                return null;
              },
               onChanged: (newText) { address.state = newText; }
            ),
            //--
            const SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfff48020)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //_loginBloc.makeGetRequest(user);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(height: 5.0),//
              ],
            ),
          ],
        ),
      ),

    );
  }


}
