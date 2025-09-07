# InNova Store

## Project Description
InNova Store is a simple e-commerce mobile application developed using **Flutter**. The app allows users to view products, search for them, see product details, and add products to the shopping cart. It also includes a **Profile Page** to store basic user information locally.

---

## Key Features
- **Multiple Pages:**
  - **Product List Page:** Displays a grid of products with a search bar.
  - **Product Details Page:** Shows product image, description, price, and allows adding to cart.
  - **Cart Page:** Displays the cart contents and total price.
  - **Profile Page:** Collects and saves user information, shown only on first launch.

- **State Management:**
  Uses `Provider` with `ChangeNotifier` to manage the cart state and update UI dynamically when products are added or removed.

- **API Integration:**
  Fetches products from the [FakeStoreAPI](https://fakestoreapi.com/products) using the `http` package.

- **Local Storage:**
  Utilizes `SharedPreferences` to save profile data so the profile page is displayed only once.

- **Interactive UI:**
  - Grid layout for products.
  - Search functionality for products.
  - Snackbar notifications for adding/removing items.

- **Enhanced User Experience:**
  - Loading indicator while fetching products.
  - Error message if product fetch fails.
  - Profile page is protected after creation to prevent returning to it.

---

## Project Structure

```text
lib/
│
├── main.dart # App entry point, routing, and Provider setup
├── models/
│   └── product.dart # Product model with JSON serialization
├── providers/
│   └── cart_provider.dart # Cart management with notifyListeners()
├── pages/
│   ├── product_list_page.dart # Product list with search bar
│   ├── product_details_page.dart # Product details page
│   ├── cart_page.dart # Shopping cart page
│   └── profile_page.dart # User profile input page
└── services/
    └── api_service.dart # Fetching data from FakeStoreAPI
```



---

## Technologies Used
- **Flutter:** Cross-platform mobile development framework.
- **Provider:** State management for dynamic UI updates.
- **HTTP:** Fetching data from external API.
- **SharedPreferences:** Local storage for user data.
- **Material Design:** Modern UI components and styling.

---
## Additional Notes

- The **Profile Page** appears only once at the first launch, storing the state locally.
- All **cart interactions** (add/remove) update the UI instantly.
- **FakeStoreAPI** is used to provide ready-made product data without the need for a custom backend.
- The app includes a **search bar** to filter products dynamically.

## How to Run
1. Clone or download the project.
2. Install dependencies:  
   ```bash
   flutter pub get
3. Run the app:
   ```bash
   flutter run
