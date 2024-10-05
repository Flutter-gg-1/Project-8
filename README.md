<p>
  <img src="https://github.com/user-attachments/assets/ebe0f62d-bd66-4b49-9456-4e4e2fcd91cd" alt="Onze Logo" width="220"/>
  <img src="https://github.com/user-attachments/assets/44b8dd39-09e6-47dc-a57e-5e3278c17233" alt="Logo-H" width="680"/>
</p>


# Onze Cafe Mobile Application

## Overview
Onze Cafe is a mobile application that provides a seamless experience for customers and employees at a cafe. Customers can browse items, place orders, and track them, while employees can manage the orders, mark them as complete, and interact with the backend. The app uses a combination of `Flutter`, `Bloc` for state management, `Supabase` as a backend, and `OneSignal` for push notifications.

## Libraries and Technologies Used

1. **Flutter**: The framework used to build the mobile application.
2. **Bloc**: Used for state management to separate the business logic from the UI.
3. **Supabase**: Used as the backend for database operations, user authentication, and real-time data sync.
4. **OneSignal**: Integrated for push notifications to notify users when their orders are ready.
5. **GetStorage**: Local storage for managing authentication tokens and user data.
6. **ImagePicker**: For uploading user profile pictures.
7. **CarouselSlider**: For displaying sliding banners and product images.
8. **Moyasar**: Integrated for handling payments in the app.
9. **font_awesome_flutter: ^10.7.0**: A package providing popular FontAwesome icons for Flutter apps.
10. **flutter_bloc: ^8.1.6**: Flutter’s official implementation of the BLoC (Business Logic Component) pattern for state management.
11. **flutter_dotenv: ^5.1.0**: Used to load environment variables from a `.env` file into the Flutter project.
12. **supabase_flutter: ^2.6.0**: The official Supabase package for Flutter applications, providing seamless integration with Supabase services.
13. **get_it: ^8.0.0**: A service locator used to manage dependency injection and improve code structure.
14. **sizer: ^2.0.15**: A Flutter package that makes it easy to create responsive designs across different screen sizes.
15. **pinput: ^5.0.0**: A customizable PIN code input field for Flutter applications.
16. **url_launcher: ^6.3.0**: Used for launching URLs in the app (e.g., open websites or send emails).
18. **http: ^1.2.2**: Used for making HTTP requests and managing API calls in the app.
19. **icons_plus: ^5.0.0**: Provides a wide variety of icons, including material design, for use in the application.


## Application Features

### User Roles

1. **Customer**:
   - **Browse Items**: Customers can browse various coffee, drinks, and desserts, which are fetched from the database using Supabase.
   - **Order Items**: Customers can add items to the cart, view the total price, and proceed to checkout using the Moyasar payment gateway.
   - **Order Tracking**: After placing an order, customers can track their orders in real time, receive notifications when the order is ready, and see the total price.
   - **Profile Management**: Customers can update their profile details, including uploading a profile picture and editing their name and phone number.
   
2. **Employee**:
   - **Manage Orders**: Employees can view a list of incoming orders and mark them as ready.
   - **Cancel Orders**: Employees can also cancel orders if needed.
   - **Push Notifications**: Employees can send notifications to customers when their orders are marked as ready, using OneSignal.
   - **Order Management**: Employees interact with the backend to fetch and update orders in real-time using Supabase.

## Application Structure

### Bloc Architecture
The app follows the Bloc pattern for state management, with separate Blocs for each screen.

- **AuthBloc**: Handles authentication, including login, register, and OTP verification.
- **HomeBloc**: Manages the data loading for the home screen, including fetching products by type.
- **CartBloc**: Manages the shopping cart functionality, including adding/removing items and checking out.
- **ProfileBloc**: Handles profile-related operations like updating user details and changing profile pictures.
- **EmployeeBloc**: Manages employee-specific functionality, including marking orders as ready or canceled.

### Database
The app uses **Supabase** for database management. Key database tables:

1. **Users (app_user)**: Stores user information, including user ID, name, email, phone, role (customer/employee), and profile image.
2. **Orders (orders)**: Stores order information, including user ID, order status (incomplete/complete), total price, and timestamps.
3. **Order Items (order_item)**: Stores details of items in an order, including item ID, order ID, quantity, price, and status (complete/incomplete).
4. **Items (item)**: Stores product information such as name, description, size, price, preparation time, item type (e.g., coffee, tea), and image URL.

### Logic and Workflow
- **Authentication**: Users can log in or register using their email and password. Upon successful registration, they receive an OTP code via email for verification. Auth tokens and user details are stored locally using `GetStorage`.
  
- **Product Loading**: The app fetches products based on type (e.g., coffee, tea, dessert) using Supabase queries. These products are displayed on the home screen in a grid format.

- **Cart Management**: Users can add products to their cart. The `CartBloc` tracks the cart items, quantity, and total price. Users can proceed to checkout, where the app integrates with `Moyasar` for payment.

- **Order Tracking**: After placing an order, users can track it in real time. The order status is updated based on employee actions (e.g., marking an order as ready).

- **Employee Management**: Employees can view a list of active orders and manage them by marking items as ready or canceling them. Employees also send push notifications to customers when their orders are marked ready using `OneSignal`.

### Notifications
- **OneSignal** is used to send push notifications to users. When an order is marked as ready by an employee, a notification is sent to the respective customer via their external user ID, stored in the database.

## GIF

**Auth**

![ScreenRecording1446-04-02at10 17 11PM-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/a51a4409-7a7f-4a21-ae45-324a1acc70e5)



![ScreenRecording1446-04-02at10 35 34PM-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/46e852a0-eb2d-4ade-bf7c-fc634d6c3c60)



**Home**


![ScreenRecording1446-04-02at10 42 26PM-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/74f46575-0fdf-468f-a0e9-18b546b7f716)



**Product details and adding to cart**


![ScreenRecording1446-04-02at10 49 07PM-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/48e1691c-6546-4844-b0bc-1c14d8f5df29)


**Payment & employee accepting order**



![2024-10-0600-35-49-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/4383b3e8-91d4-4799-84fa-0de646f9acc6)



**About us**


![Screenshot 1446-04-03 at 12 59 51 AM](https://github.com/user-attachments/assets/5d8427fe-f065-449c-98ad-00494dbd2a16)


**Profile**


![Screenshot 1446-04-03 at 1 01 12 AM](https://github.com/user-attachments/assets/df81662a-bef4-4101-945e-c22a9def6446)


## Team members:
1. Abdulaziz Alamri (Leader)
2. Rwan Riyad
3. Muhannad Althaher
