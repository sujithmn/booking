import 'package:flutter/material.dart';

enum BookingOption { Pickup, Dropoff, None }

class BookingOptions extends StatelessWidget {


  //final TextEditingController textController;
  //final String hintText;

    BookingOption? _bookingOption = BookingOption.None;

  @override
  Widget build(BuildContext context) {
    return  Column(
        children:  [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Radio<BookingOption>(
                      value: BookingOption.Pickup,
                      groupValue: _bookingOption,
                      onChanged: (BookingOption? value) {
                        _bookingOption  = value;
                       /* setState(() {
                          _shipmentCharges = value;
                        });*/
                      },
                    ),
                    Text('Pickup')
                  ],
                ),
              ),

              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Text('Pickup Charges Rs.100')
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Radio<BookingOption>(
                      value: BookingOption.Dropoff,
                      groupValue: _bookingOption,
                      onChanged: (BookingOption? value) {
                        _bookingOption  = value;
                      /*  setState(() {
                          _shipmentCharges = value;
                        });*/
                      },
                    ),
                    const Text('Drop off')
                  ],
                ),
              ),

              Flexible(
                flex: 1,
                child: Row(
                  children: const [
                    Text('Dop at preferred outlet.')
                  ],
                ),
              ),
            ],
          ),

          ]
    );
  }
}