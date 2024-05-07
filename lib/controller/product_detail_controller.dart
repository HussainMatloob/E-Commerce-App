
import 'package:get/get.dart';

import '../models/product_details.dart';

class ProductDetailsController extends GetxController {
  List<ProductDetails> details = [
    ProductDetails(
        id: 1,
        productName: "Serum & Essence",
        image:
            'https://media.gettyimages.com/id/1299061287/photo/set-of-glass-bottles-with-colorful-oil-droplet-essentials-on-white-background.jpg?s=2048x2048&w=gi&k=20&c=3mV47FAJfWS6qu-Pf5b9cP8Vj-qJuSp3uDfc4UXGEBU=',
        price: 300,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 2,
        productName: "Accessories",
        image:
            'https://i.pinimg.com/736x/92/a5/01/92a50128a24e5248bfb41a4fd4201cf4.jpg',
        price: 400,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 3,
        productName: "Wardrobe Organisers",
        image:
            'https://thumbs.dreamstime.com/z/womans-underwear-pajamas-socks-neatly-folded-placed-closet-organizer-drawer-divider-white-marble-table-womans-216980396.jpg?ct=jpeg',
        price: 500,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 4,
        productName: "Wall Decorator",
        image:
            'https://img.freepik.com/free-vector/set-gallery-frames_53876-89093.jpg?w=996&t=st=1711518312~exp=1711518912~hmac=0ee5a906c6275fa72eaf175172a9c29c7717ad9862519aeac6d8bbd3f5651fcc',
        price: 200,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 5,
        productName: "Kitchen Tools",
        image:
            'https://media.istockphoto.com/id/881670884/photo/kitchen-utensils-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=NRJpUNM0wDkOl2QEPcz9o_lBCCeXD_H0hJuf7OE46MU=',
        price: 700,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 6,
        productName: "Door locks",
        image:
            'https://media.istockphoto.com/id/666832174/photo/security-system-door-locks.jpg?s=2048x2048&w=is&k=20&c=Wo-vzsXrhfy25XoSTy94Br3xgEJx08VWpDlSs35xIAI=',
        price: 500,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 7,
        productName: "SmartWatches",
        image:
            'https://www.shutterstock.com/shutterstock/photos/1953584863/display_1500/stock-vector-smartwatch-collection-realistic-icons-isolated-on-white-technology-electronic-gadgets-wrist-1953584863.jpg',
        price: 1000,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 8,
        productName: "Moisturizers",
        image:
            'https://media.glamour.com/photos/644ac16d22d616dde0f6178e/16:9/w_1920%2Cc_limit/4-26-moisturizers%2520(1).jpg',
        price: 100,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 9,
        productName: "Casual",
        image:
            'https://m.media-amazon.com/images/I/61UkoHFCn8L._AC_UL480_FMwebp_QL65_.jpg',
        price: 800,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 10,
        productName: "HeadPhones",
        image:
            'https://as2.ftcdn.net/v2/jpg/03/43/26/05/1000_F_343260534_rXYXB77XsL0p7eeqxBjavgM9ZHA2WmBD.jpg',
        price: 1500,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 11,
        productName: "Clips & Pins",
        image:
            'https://www.shutterstock.com/shutterstock/photos/91875311/display_1500/stock-photo-pins-and-paper-clips-collection-91875311.jpg',
        price: 600,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 12,
        productName: "Art Easels",
        image:
            'https://thumbs.dreamstime.com/z/four-art-studio-easels-blank-white-painting-frames-four-art-studio-easels-blank-white-frames-to-add-paintings-104856227.jpg?ct=jpeg',
        price: 3000,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 13,
        productName: "Travel Size Bottles",
        image:
            'https://media.istockphoto.com/id/999914260/photo/set-of-traveling-cosmetics-bottles.jpg?s=2048x2048&w=is&k=20&c=hIYDxqldy8V7YA_J2mRvfc4gDjtUhLkfYF77AaxRdjo=',
        price: 150,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML'),
    ProductDetails(
        id: 14,
        productName: "Water Dispenser",
        image:
            'https://media.gettyimages.com/id/sb10069987d-001/photo/water-cooler-plugged-into-wall-in-office-close-up.jpg?s=2048x2048&w=gi&k=20&c=YNMX8NmChPBvqTtocpMOfHJ0SXiC4H9wneq97aEYKA0=',
        price: 300,
        quantity: 5,
        details:
            'SCHEVIN SKIN REVITALIZER ANTI FOR ALL SKIN TYPES FOR ADVANCE FACE FRESHNESS, FRECKLES, ANTI WRINKLES, ANTI AGAINS, DARK CIRCLES 15ML')
  ];
}
