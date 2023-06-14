import 'package:e_mart/consts/consts.dart';

class FirestoreServices {
  //getUsers Data
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get product according to category

  static getProduct(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //getting cart data

  static getCartData(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

//delete item from cart

  static deleteCartItem(docId) {
    firestore.collection(cartCollection).doc(docId).delete();
  }

//getting messages from db

  static getChatMsgs(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  //getting orders from db
  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

//getting wishlist from db
  static getWishList() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }
  
  //gtting messages from db

static getAllMessages(){
  return firestore
      .collection(chatCollection)
      .where('fromId', isEqualTo: currentUser!.uid).snapshots();
}


//getting counts fro orsers, wishlist, cart for profile screen
static getCounts()async{
    var res= await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
}

//getting all products from db for home screen all products

static getAllProducts(){
    return firestore.collection(productsCollection).snapshots();
}

//getting products for subcategory for category details screen
  
  static getSubCategoryProducts(title){
    return firestore.collection(productsCollection).where('p_subcategory', isEqualTo: title).snapshots();
  }


//getting featured products from bd and display it on home screen

static getFeaturedProducts(){
  return firestore.collection(productsCollection).where('is_featured', isEqualTo: true).snapshots();

}

//getting search results

static getSearchResult(title){
    return firestore.collection(productsCollection).get();
}

}
