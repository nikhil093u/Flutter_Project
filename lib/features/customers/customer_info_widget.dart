// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'customer_details.dart';
import 'customerprovider.dart';

class CustomerInfoWidget extends StatelessWidget {
  final Customer customer;

  const CustomerInfoWidget({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final updatedCustomer = await Navigator.push<Customer>(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerDetails(initialCustomer: customer),
          ),
        );

        if (updatedCustomer != null) {
          if (context.mounted) {
            Provider.of<CustomerProvider>(context, listen: false)
                .updateCustomer(customer, updatedCustomer);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(customer.profileImageUrl),
              backgroundColor: Colors.grey[300],
              onBackgroundImageError: (exception, stackTrace) {
                Text("Profile");
              },
              child: customer.profileImageUrl.isEmpty
                  ? Text(
                      customer.name.isNotEmpty ? customer.name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    customer.email,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    customer.phoneNumber,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}