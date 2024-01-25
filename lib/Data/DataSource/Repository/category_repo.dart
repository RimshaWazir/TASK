import 'package:dummy/Domain/Model/category_model.dart';

class CategoryRepository {
  final List<Map<String, dynamic>> _dummy_list = [
    {
      "_id": "6593d11d52c2d9c77d954e2c",
      "title": "Electronics",
      "icon": "electronics.png",
      "subCategories": [
        {
          "_id": "6593d6eddde9799b22d3ac93",
          "title": "Phones",
          "icon": "phone.png",
          "category": "6593d11d52c2d9c77d954e2c",
          "childSubCategories": [
            {
              "_id": "6593d7dd5ec9e21764bd55d9",
              "title": "Keypad Phones",
              "icon": "smartphone_icon.png",
              "category": "6593d11d52c2d9c77d954e2c",
              "deepChildSubCategory": [
                {
                  "_id": "6593d7dd5ec9e21764bd55d9",
                  "title": "Keypad Phones",
                  "icon": "smartphone_icon.png",
                  "category": "6593d11d52c2d9c77d954e2c",
                  "subCategory": "73982783023023-2",
                  "childSubCategory": "6593d6eddde9799b22d3ac93",
                  "createdAt": "2024-01-02T09:31:09.950Z",
                  "updatedAt": "2024-01-02T09:31:09.950Z",
                  "data": "abc",
                  "s": "a",
                  "products": [
                    {
                      "productId": "product_1",
                      "productName": "Phone Model 1",
                      "price": 499.99,
                      "availability": " True"
                    },
                    {
                      "productId": "product_2",
                      "productName": "Phone Model 2",
                      "price": 699.99,
                      "availability": " False"
                    }
                  ]
                }
              ],
              "subCategory": "6593d6eddde9799b22d3ac93",
              "createdAt": "2024-01-02T09:31:09.950Z",
              "updatedAt": "2024-01-02T09:31:09.950Z",
              "data": "abc",
              "s": "a"
            }
          ],
          "createdAt": "2024-01-02T09:27:09.321Z",
          "updatedAt": "2024-01-02T09:31:09.976Z"
        }
      ],
      "createdAt": "2024-01-02T09:02:21.551Z",
      "updatedAt": "2024-01-02T09:27:09.345Z"
    },
    {
      "_id": "another_category_id",
      "title": "Another Category",
      "icon": "another_category.png",
      "subCategories": [
        {
          "_id": "sub_category_id",
          "title": "Subcategory",
          "icon": "subcategory.png",
          "category": "another_category_id",
          "childSubCategories": [
            {
              "_id": "child_subcategory_id",
              "title": "Child Subcategory",
              "icon": "child_subcategory.png",
              "category": "another_category_id",
              "createdAt": "2024-01-02T09:45:00.000Z",
              "updatedAt": "2024-01-02T09:45:00.000Z",
              "data": "xyz",
              "s": "b",
              "products": [
                {
                  "productId": "product_3",
                  "productName": "Product X",
                  "price": 299.99,
                  "availability": " True"
                },
                {
                  "productId": "product_4",
                  "productName": "Product Y",
                  "price": 199.99,
                  "availability": " True"
                }
              ]
            }
          ],
          "createdAt": "2024-01-02T09:40:00.000Z",
          "updatedAt": "2024-01-02T09:45:00.000Z"
        }
      ],
      "createdAt": "2024-01-02T09:35:00.000Z",
      "updatedAt": "2024-01-02T09:40:00.000Z"
    },
    {
      "_id": "new_category_id_1",
      "title": "New Category 1",
      "icon": "new_category_1.png",
      "subCategories": [
        {
          "_id": "new_sub_category_id_1",
          "title": "New Subcategory 1",
          "icon": "new_subcategory_1.png",
          "category": "new_category_id_1",
          "childSubCategories": [
            {
              "_id": "new_child_subcategory_id_1",
              "title": "New Child Subcategory 1",
              "icon": "new_child_subcategory_1.png",
              "category": "new_category_id_1",
              "createdAt": "2024-01-02T10:00:00.000Z",
              "updatedAt": "2024-01-02T10:00:00.000Z",
              "data": "123",
              "s": "c",
              "products": [
                {
                  "productId": "product_5",
                  "productName": "Product Z",
                  "price": 399.99,
                  "availability": " False"
                },
                {
                  "productId": "product_6",
                  "productName": "Product W",
                  "price": 599.99,
                  "availability": " True"
                }
              ]
            }
          ],
          "createdAt": "2024-01-02T09:55:00.000Z",
          "updatedAt": "2024-01-02T10:00:00.000Z"
        }
      ],
      "createdAt": "2024-01-02T09:50:00.000Z",
      "updatedAt": "2024-01-02T09:55:00.000Z"
    },
    {
      "_id": "new_category_id_2",
      "title": "New Category 2",
      "icon": "new_category_2.png",
      "subCategories": [
        {
          "_id": "new_sub_category_id_2",
          "title": "New Subcategory 2",
          "icon": "new_subcategory_2.png",
          "category": "new_category_id_2",
          "childSubCategories": [
            {
              "_id": "new_child_subcategory_id_2",
              "title": "New Child Subcategory 2",
              "icon": "new_child_subcategory_2.png",
              "category": "new_category_id_2",
              "createdAt": "2024-01-02T10:15:00.000Z",
              "updatedAt": "2024-01-02T10:15:00.000Z",
              "data": "456",
              "s": "d",
              "products": [
                {
                  "productId": "product_7",
                  "productName": "Product M",
                  "price": 499.99,
                  "availability": " True"
                },
                {
                  "productId": "product_8",
                  "productName": "Product N",
                  "price": 699.99,
                  "availability": " False"
                }
              ]
            }
          ],
          "createdAt": "2024-01-02T10:10:00.000Z",
          "updatedAt": "2024-01-02T10:15:00.000Z"
        }
      ],
      "createdAt": "2024-01-02T10:05:00.000Z",
      "updatedAt": "2024-01-02T10:10:00.000Z"
    },
    {
      "_id": "new_category_id_3",
      "title": "New Category 3",
      "icon": "new_category_3.png",
      "subCategories": [
        {
          "_id": "new_sub_category_id_3",
          "title": "New Subcategory 3",
          "icon": "new_subcategory_3.png",
          "category": "new_category_id_3",
          "childSubCategories": [
            {
              "_id": "new_child_subcategory_id_3",
              "title": "New Child Subcategory 3",
              "icon": "new_child_subcategory_3.png",
              "category": "new_category_id_3",
              "createdAt": "2024-01-02T10:30:00.000Z",
              "updatedAt": "2024-01-02T10:30:00.000Z",
              "data": "789",
              "s": "e",
              "products": [
                {
                  "productId": "product_9",
                  "productName": "Product P",
                  "price": 899.99,
                  "availability": "True"
                },
                {
                  "productId": "product_10",
                  "productName": "Product Q",
                  "price": 1099.99,
                  "availability": "True"
                }
              ]
            }
          ],
          "createdAt": "2024-01-02T10:25:00.000Z",
          "updatedAt": "2024-01-02T10:30:00.000Z"
        }
      ],
      "createdAt": "2024-01-02T10:20:00.000Z",
      "updatedAt": "2024-01-02T10:25:00.000Z"
    }
  ];

  Future<List<CategoryModel>> fetchData() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return _dummy_list.map((item) => CategoryModel.fromJson(item)).toList();
    });
  }
}
