# Onze Cafe

This application is a comprehensive solution for managing a coffee shop, providing two interfaces for employees and customers. It enables efficient menu management, order processing, and customer service. The app is built using **Supabase** for backend management and **OneSignal** for notifications.



## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Database Tables](#database-tables)
- [Notifications](#notifications)
- [Installation](#installation)
- [Usage](#usage)
- [Client Specifications](#client-specifications)
- [Created By](#created-by)

## Features

### Employee Interface:
1. **Menu Management**  
   Manage drink categories, menu items, and offers. Employees can add, edit, and remove items or offers from the menu.
   
2. **Reports Dashboard**  
   Provides a dashboard with reports on sales and other metrics to track the performance of the coffee shop.
   
3. **Order Management**  
   View and manage customer orders, including order status updates and processing.

### Customer Interface:
1. **Menu Browsing**  
   Customers can browse the available drink categories and menu items.
   
2. **Cart & Payment**  
   Customers can add items to their cart and proceed with payment. Payment status is tracked, and customers can view their order history.
   
3. **Order Status**  
   Real-time updates of order status with notifications to keep customers informed.
   
4. **Profile Management**  
   Customers can manage their profile information and view order history. The app also allows for browsing as a guest (anonymous users).

### Additional Features:
- **Email Authentication**  
  Secure login system using email authentication. Customers can also browse anonymously.
  
- **Real-time Notifications**  
  Integrated with OneSignal to send notifications for order updates and promotional information.

## Tech Stack

- **Frontend**: Built using SwiftUI (iOS) and Dart/Flutter.
- **Backend**: Supabase is used for managing the database and authentication.
- **Notifications**: OneSignal for push notifications.
  
## Database Tables

The following tables were created in Supabase for data management:
1. `cart_item`: Stores information about the items in the customer's cart.
2. `menu_category`: Contains drink categories like Coffee, Tea, etc.
3. `menu_item`: Details for each item in the menu, such as name, description, price, and category.
4. `offer`: Stores promotional offers available at the shop.
5. `placed_order`: Logs customer orders with details such as items, quantities, and status.
6. `profile`: Customer profiles including their personal information and authentication details.

## Notifications

- **Employee Notifications**: Employees receive notifications when a new order is placed.
- **Customer Notifications**: Customers receive notifications when their order status is updated. Additionally, commercial promotions and offers are pushed through notifications.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/amer266030/Project-8.git
    ```

2. Install the necessary dependencies:
   ```bash
   cd onze_cafe
   flutter pub get
    ```

3. Configure environment variables for Supabase and OneSignal:
- Set up Supabase API keys and URLs in the environment file.
- Add OneSignal configuration for notifications.

4. Run the application:
    ```bash
    flutter run
    ```
## Usage

- **Employee Access**: Employees can log in to manage the menu, view reports, and process orders.

- **Customer Access**: Customers can browse the menu, add items to the cart, complete purchases, and view their order status.

- **Guest Browsing**: Guest Browsing: Users can explore the menu as an anonymous user without creating an account.

## Client Specifications

The application was developed according to client specifications, which included branding guidelines, user interface design, and application functionality. The application reflects the design identity and customer experience requirements provided by the client.

## Created By
- **Amer Alyusuf**
- **Yara Albouq**
- **Abdullah Mukhlef Al-Shammari**