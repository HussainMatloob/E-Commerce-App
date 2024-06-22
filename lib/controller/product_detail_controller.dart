
import 'package:get/get.dart';

import '../models/product_details.dart';

class ProductDetailsController extends GetxController {
  List<ProductDetails> details = [
    ProductDetails(
        id: "1",
        salePrice:270,
        sale: "",
        productName: "Serum & Essence",
        image:
            ['https://media.gettyimages.com/id/1299061287/photo/set-of-glass-bottles-with-colorful-oil-droplet-essentials-on-white-background.jpg?s=2048x2048&w=gi&k=20&c=3mV47FAJfWS6qu-Pf5b9cP8Vj-qJuSp3uDfc4UXGEBU='],
        price: 300,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "2",
        salePrice:350,
        sale: "",
        productName: "Accessories sidfgodis fdidsfhds hfsdk",
        image:
           [ 'https://i.pinimg.com/736x/92/a5/01/92a50128a24e5248bfb41a4fd4201cf4.jpg'],
        price: 400,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id:"3",
        salePrice:450,
        sale: "",
        productName: "Wardrobe Organisers",
        image:
            ['https://thumbs.dreamstime.com/z/womans-underwear-pajamas-socks-neatly-folded-placed-closet-organizer-drawer-divider-white-marble-table-womans-216980396.jpg?ct=jpeg'],
        price: 500,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id:" 4",
        salePrice:150,
        sale: "",
        productName: "Wall Decorator",
        image:
            ['https://img.freepik.com/free-vector/set-gallery-frames_53876-89093.jpg?w=996&t=st=1711518312~exp=1711518912~hmac=0ee5a906c6275fa72eaf175172a9c29c7717ad9862519aeac6d8bbd3f5651fcc'],
        price: 200,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "5",
        salePrice:650,
        sale: "",
        productName: "Kitchen Tools",
        image:
           [ 'https://media.istockphoto.com/id/881670884/photo/kitchen-utensils-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=NRJpUNM0wDkOl2QEPcz9o_lBCCeXD_H0hJuf7OE46MU='],
        price: 700,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id:" 6",
        salePrice:450,
        sale: "",
        productName: "Door locks",
        image:
            ['https://media.istockphoto.com/id/666832174/photo/security-system-door-locks.jpg?s=2048x2048&w=is&k=20&c=Wo-vzsXrhfy25XoSTy94Br3xgEJx08VWpDlSs35xIAI='],
        price: 500,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "7",
        salePrice:900,
        sale: "",
        productName: "SmartWatches",
        image:
           [ 'https://www.shutterstock.com/shutterstock/photos/1953584863/display_1500/stock-vector-smartwatch-collection-realistic-icons-isolated-on-white-technology-electronic-gadgets-wrist-1953584863.jpg'],
        price: 1000,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "8",
        salePrice:70,
        sale: "",
        productName: "Moisturizers",
        image:
            ['https://media.glamour.com/photos/644ac16d22d616dde0f6178e/16:9/w_1920%2Cc_limit/4-26-moisturizers%2520(1).jpg'],
        price: 100,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "9",
        salePrice:750,
        sale: "",
        productName: "Casual",
        image:
            ['https://m.media-amazon.com/images/I/61UkoHFCn8L._AC_UL480_FMwebp_QL65_.jpg'],
        price: 800,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "10",
        salePrice:1400,
        sale: "",
        productName: "HeadPhones",
        image:
            ['https://as2.ftcdn.net/v2/jpg/03/43/26/05/1000_F_343260534_rXYXB77XsL0p7eeqxBjavgM9ZHA2WmBD.jpg'],
        price: 1500,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "11",
        salePrice:500,
        sale: "",
        productName: "Clips & Pins",
        image:
            ['https://www.shutterstock.com/shutterstock/photos/91875311/display_1500/stock-photo-pins-and-paper-clips-collection-91875311.jpg'],
        price: 600,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "12",
        salePrice:2500,
        sale: "",
        productName: "Art Easels",
        image:
            ['https://thumbs.dreamstime.com/z/four-art-studio-easels-blank-white-painting-frames-four-art-studio-easels-blank-white-frames-to-add-paintings-104856227.jpg?ct=jpeg'],
        price: 3000,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "13",
        salePrice:100,
        sale: "",
        productName: "Travel Size Bottles",
        image:
            ['https://media.istockphoto.com/id/999914260/photo/set-of-traveling-cosmetics-bottles.jpg?s=2048x2048&w=is&k=20&c=hIYDxqldy8V7YA_J2mRvfc4gDjtUhLkfYF77AaxRdjo='],
        price: 150,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: "14",
        salePrice:250,
        sale: "",
        productName: "Water Dispenser",
        image:
            ['https://media.gettyimages.com/id/sb10069987d-001/photo/water-cooler-plugged-into-wall-in-office-close-up.jpg?s=2048x2048&w=gi&k=20&c=YNMX8NmChPBvqTtocpMOfHJ0SXiC4H9wneq97aEYKA0='],
        price: 300,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML')
  ];



  List<ProductDetails> categoriesItem=[
    ProductDetails(
  id: "111",
  salePrice:4199,
  sale: "",
  productName: "Chiffon Party Wear Dress ",
  image:
  ['https://www.dressyzone.com/cdn/shop/products/1_378351c3-f6f4-4847-8161-c08d7234290f_1024x1024@2x.jpg?v=1633784672'],
  price: 6500,
  quantity: 5,
  details:
  'Heavy Embroidered Chiffon Party Wear Dress 2024 (DZ14224),Replica Dress,Condition: Unstitched,Zari, Thread & Sequins Embroidery Work,Heavy Embroidered Neck,Heavy Embroidered Chiffon Front Panel Piece,Embroidered Chiffon Side Panel Piece'
    ),
  ProductDetails(
      id: "222",
      salePrice:4199,
      sale: "",
      productName: "OFF WHITE BLENDED KURTA",
      image:
      ['https://www.junaidjamshed.com/media/catalog/product/3/4/34729_1_.jpg?quality=80&bg-color=255,255,255&fit=bounds&height=&width='],
      price: 5000,
      quantity: 5,
      details:
      'This Semi-Formal Off White Blended Kurta Exudes Understated Elegance, Striking The Perfect Balance Between Traditional Charm and Contemporary Sophistication'
  ),

    ProductDetails(
        id: "333",
        salePrice:4199,
        sale: "",
        productName: "Timex Men's Expedition Scout 40mm Watch",
        image:
        ['https://m.media-amazon.com/images/I/91APJ9+qs2L._AC_SY500_.jpg'],
        price: 2199,
        quantity: 5,
        details:
        'Adjustable green 20 millimeter nylon strap fits up to 8-inch wrist circumference Dial with date window at 3 o clock; Full Arabic numerals Black 40 millimeter brass case with mineral glass crystal'
    ),

    ProductDetails(
        id: "444",
        salePrice:4199,
        sale: "",
        productName: "Shoe Moc US-RF-3102 ",
        image:
        ['https://www.urbansole.com.pk/cdn/shop/files/US-RF-3102Camello_1_66da8e1d-c811-4812-9287-54083a40b848_502x502.webp?v=1711014890'],
        price: 6199,
        quantity: 5,
        details:
        'Upgrade your footwear game with our casual shoes for men collection. Our men casual shoes collection offers comfort and style. Stay comfortable with our men casual shoes collection.'
    ),

  ];

  List<ProductDetails> salesItem=[
    ProductDetails(
        id: "1111",
        salePrice:5199,
        sale: 'Sale',
        productName: "Chiffon Party Wear Dress ",
        image:
        ['https://www.hoorclothing.pk/images/uploads/2932019005521_p.jpg'],
        price: 6500,
        quantity: 5,
        details:
        'Heavy Embroidered Chiffon Party Wear Dress 2024 (DZ14224),Replica Dress,Condition: Unstitched,Zari, Thread & Sequins Embroidery Work,Heavy Embroidered Neck,Heavy Embroidered Chiffon Front Panel Piece,Embroidered Chiffon Side Panel Piece'
    ),
    ProductDetails(
        id: "2222",
        salePrice:4490,
        sale: 'Sale',
        productName: "OFF WHITE BLENDED KURTA",
        image:
        ['https://www.junaidjamshed.com/media/catalog/product/3/2/32945_1_.jpg?quality=80&bg-color=255,255,255&fit=bounds&height=560&width=436'],
        price: 5000,
        quantity: 5,
        details:
        'This Semi-Formal Prussian Blue Blended Kurta Exudes Understated Elegance, Striking The Perfect Balance Between Traditional Charm and Contemporary Sophistication'
    ),

    ProductDetails(
        id: "3333",
        salePrice:2199,
        sale: 'Sale',
        productName: "Citizen - AU1065-58E - Eco Drive",
        image:
        ['https://nizamwatch.com/cdn/shop/products/AU1065-58E_7b40e94b-bb94-4a51-9d68-6fc6b077bb41_300x.jpg?v=1695469609'],
        price: 3199,
        quantity: 5,
        details:
        'The sleek design of this Citizen Eco-Drive offers a day-to-night fashion option for the avid trendsetter. Available in mens and womens, featuring a stainless steel black IP case and bracelet with a black dial and the intriguing feature of edge-to-edge glass and date. Powered by Eco-Drive- the revolutionary light powered movement from Citizen, this watch has the ability to continuously recharge in any light source and can run for a minimum of six months even in the dark without any charge.'
    ),

    ProductDetails(
        id: "4444",
        salePrice:5000,
        sale: 'Sale',
        productName: "DOUBLE MONK LUXE LOAFERS-COFFEE",
        image:
        ['https://www.almas.pk/cdn/shop/files/BYM164-Coffee_1.jpg?v=1715778109'],
        price: 6399,
        quantity: 5,
        details:
        'Step up your style game with our Mens Leatherette Loafer. Crafted from high-quality leatherette material, this sophisticated shoe exudes timeless elegance. Featuring two stylish buckles, this loafer adds a touch of refinement to any outfit. Whether youre heading to the office or a special occasion, this versatile shoe is the perfect choice. Comfortable and durable, our Mens Leatherette Loafer is a must-have addition to your footwear collection'
    ),

  ];


}
