const List<Map<String, dynamic>> dummyTransactions = [
  {
    'id': 1,
    'created_at': '2024-05-01 12:00:00',
    'transaction_number': 'TXN7890122',
    'transaction_type': 'deposit',
    'status': 'pending',
    'amount': '8000',
    'fee': '8.88',
    'net_amount': '7991.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description': null,
    'approval_date': null,
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  },
  {
    'id': 2,
    'created_at': '2024-05-01 11:00:00',
    'transaction_number': 'TXN7890123',
    'transaction_type': 'withdrawal',
    'status': 'success',
    'amount': '1000',
    'fee': '8.88',
    'net_amount': '991.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'approval_date': '2024-05-04 08:00:00',
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  },
  {
    'id': 3,
    'created_at': '2024-05-01 08:00:00',
    'transaction_number': 'TXN7890124',
    'transaction_type': 'deposit',
    'status': 'success',
    'amount': '500',
    'fee': '8.88',
    'net_amount': '491.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'approval_date': '2024-05-04 11:00:00',
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  },
  {
    'id': 4,
    'created_at': '2024-04-30 12:00:00',
    'transaction_number': 'TXN7890125',
    'transaction_type': 'deposit',
    'status': 'success',
    'amount': '20000',
    'fee': '8.88',
    'net_amount': '19991.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'approval_date': '2024-05-02 08:00:00',
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  },
  {
    'id': 5,
    'created_at': '2024-04-30 10:00:00',
    'transaction_number': 'TXN7890126',
    'transaction_type': 'withdrawal',
    'status': 'rejected',
    'amount': '2000',
    'fee': '8.88',
    'net_amount': '1991.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'approval_date': '2024-05-02 11:00:00',
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  },
  {
    'id': 6,
    'created_at': '2024-04-30 09:00:00',
    'transaction_number': 'TXN7890127',
    'transaction_type': 'deposit',
    'status': 'success',
    'amount': '2000',
    'fee': '8.88',
    'net_amount': '1991.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'approval_date': '2024-05-02 13:00:00',
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  },
  {
    'id': 7,
    'created_at': '2024-04-29 15:00:00',
    'transaction_number': 'TXN7890128',
    'transaction_type': 'withdrawal',
    'status': 'freezing',
    'amount': '100',
    'fee': '8.88',
    'net_amount': '91.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'approval_date': '2024-05-03 12:00:00',
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  },
  {
    'id': 8,
    'created_at': '2024-04-29 11:00:00',
    'transaction_number': 'TXN7890128',
    'transaction_type': 'withdrawal',
    'status': 'success',
    'amount': '100',
    'fee': '8.88',
    'net_amount': '91.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'approval_date': '2024-05-03 14:00:00',
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  },
  {
    'id': 9,
    'created_at': '2024-04-29 02:00:00',
    'transaction_number': 'TXN7890128',
    'transaction_type': 'deposit',
    'status': 'success',
    'amount': '1000',
    'fee': '8.88',
    'net_amount': '991.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'approval_date': '2024-05-03 15:00:00',
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  },
  {
    'id': 10,
    'created_at': '2024-04-28 12:00:00',
    'transaction_number': 'TXN7890128',
    'transaction_type': 'withdrawal',
    'status': 'success',
    'amount': '3000',
    'fee': '8.88',
    'net_amount': '2991.12',
    'txID': '93970278970797',
    'sent_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'receiving_address': 'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'approval_date': '2024-05-01 08:00:00',
    'user': {
      'id': 345,
      'name': 'Law Zai Yee',
      'email': 'lawzaiyee@gmail.com',
      'profile_photo': null,
      'profile_id': 'ID334673423',
      'phone_number': '012334343'
    }
  }
];
