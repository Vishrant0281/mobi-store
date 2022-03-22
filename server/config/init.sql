CREATE TABLE public.cart
(
    id SERIAL NOT NULL,
    user_id integer UNIQUE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.cart_item
(
    id SERIAL NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (id),
    UNIQUE (cart_id, product_id)
);

CREATE TABLE public.order_item
(
    id SERIAL NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TYPE "payment" AS ENUM (
  'PAYSTACK',
  'STRIPE'
);

CREATE TABLE public.orders
(
    order_id SERIAL NOT NULL,
    user_id integer NOT NULL,
    status character varying(20) NOT NULL,
    date timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    amount real,
    total integer,
    ref character varying(100),
    payment_method payment,
    PRIMARY KEY (order_id)
);

CREATE TABLE public.products
(
    product_id SERIAL NOT NULL,
    name character varying(50) NOT NULL,
    price real NOT NULL,
    brandname character varying(15) NOT Null,
    ram character varying(20) NOT NULL,
    camera character varying(50) NOT NULL,
    battery character varying(12) NOT NULL,
    storage character varying(20) NOT NULL,
    description text NOT NULL,
    image_url character varying,
    PRIMARY KEY (product_id)
);

CREATE TABLE public."resetTokens"
(
    id SERIAL NOT NULL,
    email character varying NOT NULL,
    token character varying NOT NULL,
    used boolean DEFAULT false NOT NULL,
    expiration timestamp without time zone,
    PRIMARY KEY (id)
);

CREATE TABLE public.reviews
(
    user_id integer NOT NULL,
    content text NOT NULL,
    rating integer NOT NULL,
    product_id integer NOT NULL,
    date date NOT NULL,
    id integer NOT NULL,
    PRIMARY KEY (user_id, product_id)
);

CREATE TABLE public.users
(
    user_id SERIAL NOT NULL,
    password character varying(200),
    email character varying(100) UNIQUE NOT NULL,
    fullname character varying(100) NOT NULL,
    username character varying(50) UNIQUE NOT NULL,
    google_id character varying(100) UNIQUE,
    roles character varying(10)[] DEFAULT '{customer}'::character varying[] NOT NULL,
    address character varying(200),
    city character varying(100),
    state character varying(100),
    country character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);

ALTER TABLE public.cart
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id)
    ON DELETE SET NULL
    NOT VALID;


ALTER TABLE public.cart_item
    ADD FOREIGN KEY (cart_id)
    REFERENCES public.cart (id)
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE public.cart_item
    ADD FOREIGN KEY (product_id)
    REFERENCES public.products (product_id)
    ON DELETE SET NULL
    NOT VALID;


ALTER TABLE public.order_item
    ADD FOREIGN KEY (order_id)
    REFERENCES public.orders (order_id)
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE public.order_item
    ADD FOREIGN KEY (product_id)
    REFERENCES public.products (product_id)
    ON DELETE SET NULL
    NOT VALID;


ALTER TABLE public.orders
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id)
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE public.reviews
    ADD FOREIGN KEY (product_id)
    REFERENCES public.products (product_id)
    ON DELETE SET NULL
    NOT VALID;


ALTER TABLE public.reviews
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id)
    ON DELETE SET NULL
    NOT VALID;

CREATE UNIQUE INDEX users_unique_lower_email_idx
    ON public.users (lower(email));

CREATE UNIQUE INDEX users_unique_lower_username_idx
    ON public.users (lower(username));

    -- ================= Seed data for products table ================= --
INSERT INTO public.products (product_id, name, price, brandname, ram, camera, battery, storage, description, image_url) VALUES 
(1, 'Galaxy A32 Black', 23500.0, 'Samsung', '6/8 GB', '64MP+8MP+5MP+5MP Quad camera', '5000 mAH', '128 GB',
'The Samsung Galaxy A32 is going to be your new travel companion, thanks to its multi-lens camera system, you can capture stunning images of various sceneries, people, and more when you go from place to place. Thanks to its 5 MP macro camera, minute details in the pictures that you take will stand out. You can make use of the Bokeh effect while taking photos so that your subject is the center of attention. And, the 5000 mAh battery gives you enough power to stream content, game, and much more for a long time. ',
'https://i.postimg.cc/HW45DsCS/Galaxy-A32-Black.png'),

(2, 'Galaxy A32 Blue', 23500.0, 'Samsung', '6/8 GB', '64MP+8MP+5MP+5MP Quad camera', '5000 mAH', '128 GB',
'The Samsung Galaxy A32 is going to be your new travel companion, thanks to its multi-lens camera system, you can capture stunning images of various sceneries, people, and more when you go from place to place. Thanks to its 5 MP macro camera, minute details in the pictures that you take will stand out. You can make use of the Bokeh effect while taking photos so that your subject is the center of attention. And, the 5000 mAh battery gives you enough power to stream content, game, and much more for a long time. ',
'https://i.postimg.cc/pXWj2bWP/Galaxy-A32-Blue.png'),

(3, 'Galaxy A32 Purple', 23500.0, 'Samsung', '6/8 GB', '64MP+8MP+5MP+5MP Quad camera', '5000 mAH', '128 GB',
'The Samsung Galaxy A32 is going to be your new travel companion, thanks to its multi-lens camera system, you can capture stunning images of various sceneries, people, and more when you go from place to place. Thanks to its 5 MP macro camera, minute details in the pictures that you take will stand out. You can make use of the Bokeh effect while taking photos so that your subject is the center of attention. And, the 5000 mAh battery gives you enough power to stream content, game, and much more for a long time. ',
'https://i.postimg.cc/0jxwMh7d/Galaxy-A32-Purple.png'),

(4, 'Galaxy S21 Black', 59999.0, 'Samsung', '8 GB', '12MP+12MP+64MP', '5000 mAH', '128 GB',
'Take your love for capturing photos and recording videos (up to 8K resolution) to the next level with the Samsung Galaxy S21 Smartphone as it comes with a 64 MP camera setup. The 8K Video Snap feature helps you capture high-quality photos up to 33 MP resolution even from the 8K videos. This phone is 5G ready, helping you browse and stream data from the Internet with minimal lag.',
'https://i.postimg.cc/CLKFdHdq/Galaxy-S21-Black.png'),

(5, 'Galaxy S21 Ultra White', 105999.0, 'Samsung', '12/16 GB', '108MP+10MP+10MP+12MP', '5000 mAH', '128/256/512 GB',
'Say hello to the powerful and stylish Samsung Galaxy S20 Ultra smartphone. Featuring a 108 MP high-resolution camera with 100X Zoom, you can capture stunning photos like never before on this smartphone. It also comes with a long-lasting 5000 mAh battery so you can stay entertained for a long time. Thats not all, the Samsung Galaxy S20 Ultra comes with the Infinity-O display and a seamless design, which makes it a must-have for all the gadget-enthusiasts.',
'https://i.postimg.cc/dV0G9Mp5/Galaxy-S21-Ultra-White.png'),

(6, 'Galaxy S22 Ultra Green', 55000.0, 'Samsung', '8/12 GB', '108MP+10MP+10MP+12MP', '5000 mAH', '128/256/512 GB',
'Say hello to the powerful and stylish Samsung Galaxy S20 Ultra smartphone. Featuring a 108 MP high-resolution camera with 100X Zoom, you can capture stunning photos like never before on this smartphone. It also comes with a long-lasting 5000 mAh battery so you can stay entertained for a long time. Thats not all, the Samsung Galaxy S20 Ultra comes with the Infinity-O display and a seamless design, which makes it a must-have for all the gadget-enthusiasts.',
'https://i.postimg.cc/Ssc9KmYx/Galaxy-S22-Ultra-Green.png'),

(7, 'Galaxy S22 Ultra Burgundy', 55000.0, 'Samsung', '8/12 GB', '108MP+10MP+10MP+12MP', '5000 mAH', '128/256/512 GB',
'Say hello to the powerful and stylish Samsung Galaxy S20 Ultra smartphone. Featuring a 108 MP high-resolution camera with 100X Zoom, you can capture stunning photos like never before on this smartphone. It also comes with a long-lasting 5000 mAh battery so you can stay entertained for a long time. Thats not all, the Samsung Galaxy S20 Ultra comes with the Infinity-O display and a seamless design, which makes it a must-have for all the gadget-enthusiasts.',
'https://i.postimg.cc/NF4r1b4h/Galaxy-S22-Ultra-Rose-Gold.png'),

(8, 'Iphone 11 Black', 49999.0, 'Apple', '4 GB', '12MP+12MP', '3110 mAH', '64/128/256 GB',
'6.1-inch (15.4 cm diagonal) Liquid Retina HD LCD display',
'https://i.postimg.cc/ZYHbTDYm/Iphone-11-Black.png'),

(9, 'Iphone 12 Purple', 60500.0, 'Apple', '4 GB', '12MP+12MP', '2815 mAH', '64/128/256 GB',
'Dive into a world of crystal-clear visuals with the Super Retina XDR Display of this Apple iPhone 12. This beast of a smartphone packs the A14 Bionic chip to make for blazing-fast performance speeds. On top of that, its Dual-camera System, along with Night Mode, helps you click amazing pictures and selfies even when the lighting isn’t as good as you’d want it to be.',
'https://i.postimg.cc/QM95RQX5/Iphone-12-Purple.png'),

(10, 'Iphone 12 Red', 60500, 'Apple', '4 GB', '12MP+12MP', '2815 mAH', '64/128/256 GB',
'Dive into a world of crystal-clear visuals with the Super Retina XDR Display of this Apple iPhone 12. This beast of a smartphone packs the A14 Bionic chip to make for blazing-fast performance speeds. On top of that, its Dual-camera System, along with Night Mode, helps you click amazing pictures and selfies even when the lighting isn’t as good as you’d want it to be.',
'https://i.postimg.cc/PqgZhCx7/Iphone-12-Red.png'),

(11, 'Iphone 12 White', 60500.0, 'Apple', '4 GB', '12MP+12MP', '2815 mAH', '64/128/256 GB',
'Dive into a world of crystal-clear visuals with the Super Retina XDR Display of this Apple iPhone 12. This beast of a smartphone packs the A14 Bionic chip to make for blazing-fast performance speeds. On top of that, its Dual-camera System, along with Night Mode, helps you click amazing pictures and selfies even when the lighting isn’t as good as you’d want it to be.',
'https://i.postimg.cc/6qMtYTbq/Iphone-12-White.png'),

(12, 'Iphone 13 Blue', 79900.0, 'Apple', '4 GB', '12MP+12MP', '3240 mAH', '64/128/256 GB',
'15 cm (6.1-inch) Super Retina XDR display',
'https://i.postimg.cc/L59mtjTG/Iphone-13-Blue.png'),


(13, 'Iphone 13 Pro Max Black', 129999.0, 'Apple', '6 GB', '12MP+12MP+12MP', '4352 mAH', '128/256/512 GB',
'15 cm (6.1-inch) Super Retina XDR display
    Cinematic mode adds shallow depth of field and shifts focus automatically in your videos
    Advanced dual-camera system with 12MP Wide and Ultra Wide cameras; Photographic Styles, Smart HDR 4, Night mode, 4K Dolby Vision HDR recording
    12MP TrueDepth front camera with Night mode, 4K Dolby Vision HDR recording
    A15 Bionic chip for lightning-fast performance
    Up to 19 hours of video playback
    Durable design with Ceramic Shield',
'https://i.postimg.cc/Hkj7yw8K/Iphone-13-Pro-Max-Black.png'),

(14, 'Iphone 13 White', 79900.0, 'Apple', '4 GB', '12MP+12MP', '3240 mAH', '64/128/256 GB',
'15 cm (6.1-inch) Super Retina XDR display',
'https://i.postimg.cc/fRFSjVxb/Iphone-13-White.png'),

(15, 'Iphone 7 Plus Black', 27999.0, 'Apple', '3 GB', '12MP+12MP', '2900 mAH', '32/128/256 GB',
'The iPhone 7 Plus brings to you a heady combination of style and performance to enhance your smartphone experience. With its impressive internal storage, powerful camera system, fast processor and long battery life, therell never be a dull moment again.',
'https://i.postimg.cc/rmLVpBtV/Iphone-7-Plus-Black.png'),

(16, 'Iphone X Black', 90000.0, 'Apple', '3 GB', '12MP+12MP', '2716 mAH', '64/256 GB',
'Meet the iPhone X - the device thats so smart that it responds to a tap, your voice, and even a glance. Elegantly designed with a large 14.73 cm (5.8) Super Retina screen and a durable front-and-back glass, this smartphone is designed to impress. Whats more, you can charge this iPhone wirelessly.',
'https://i.postimg.cc/QtkXKfpp/Iphone-X-Black.png'),

(17, 'Mi 11 Blue', 69999.0, 'Xiaomi', '6/8/12 GB', '108MP+13MP+5MP', '4600 mAH', '128/256/512 GB',
'The phone comes with a 6.81-inch touchscreen display with a resolution of 1440x3200 pixels at a pixel density of 515 pixels per inch (ppi) and an aspect ratio of 20:9. Xiaomi Mi 11 is powered by an octa-core Qualcomm Snapdragon 888 processor. It comes with 8GB of RAM. The Xiaomi Mi 11 runs Android 11 and is powered by a 4,600mAh non-removable battery. The Xiaomi Mi 11 supports wireless charging, as well as proprietary fast charging.',
'https://i.postimg.cc/XvCG2n8k/Mi-11-Blue.png'),

(18, 'Mi 11 Purple', 69999.0, 'Xiaomi', '6/8/12 GB', '108MP+13MP+5MP', '4600 mAH', '128/256/512 GB',
'The phone comes with a 6.81-inch touchscreen display with a resolution of 1440x3200 pixels at a pixel density of 515 pixels per inch (ppi) and an aspect ratio of 20:9. Xiaomi Mi 11 is powered by an octa-core Qualcomm Snapdragon 888 processor. It comes with 8GB of RAM. The Xiaomi Mi 11 runs Android 11 and is powered by a 4,600mAh non-removable battery. The Xiaomi Mi 11 supports wireless charging, as well as proprietary fast charging.',
'https://i.postimg.cc/nhjpGF4V/Mi-11-Purple.png'),

(19, 'Mi 11 White', 69999.0, 'Xiaomi', '6/8/12 GB', '48MP+8MP+5MP', '4600 mAH', '128 GB',
'The phone comes with a 6.81-inch touchscreen display with a resolution of 1440x3200 pixels at a pixel density of 515 pixels per inch (ppi) and an aspect ratio of 20:9. Xiaomi Mi 11 is powered by an octa-core Qualcomm Snapdragon 888 processor. It comes with 8GB of RAM. The Xiaomi Mi 11 runs Android 11 and is powered by a 4,600mAh non-removable battery. The Xiaomi Mi 11 supports wireless charging, as well as proprietary fast charging.',
'https://i.postimg.cc/Qxnj79Wn/Mi-11-White.png'),

(20, 'Mi 11X White', 26500.0, 'Xiaomi', '6/8/12 GB', '48MP+8MP+5MP', '4600 mAH', '128 GB',
'Processor: Qualcomm Snapdragon 870 5G with Kryo 585 Octa-core; 7nm process; Up to 3.2GHz clock speed; Liquidcool technology.
Camera: 48 MP Triple Rear camera with 8MP Ultra-wide and 5MP Super macro | 20 MP Front camera.
Display: 120Hz high refresh rate FHD+ (1080x2400) AMOLED Dot display; 16.9 centimeters (6.67 inch); 2.76mm ultra tiny punch hole; HDR 10+ support; 360Hz touch sampling, MEMC technology.
Battery: 4520 mAH large battery with 33W fast charger in-box and Type-C connectivity.
Hands-Free access to Alexa: Alexa on your phone lets you make phone calls, open apps, control smart home devices, access the library of Alexa skills, and more using just your voice while on-the-go. Download the Alexa app and complete hands-free setup to get started. Just ask - and Alexa will respond instantly.',
'https://i.postimg.cc/yxVDYczL/Mi-11-X-White.png'),

(21, 'OnePlus 9 Blue', 49999.0, 'OnePlus', '8/12 GB', '48MP+50MP+2MP', '4500 mAH', '128/256 GB',
'Rear Triple Camera Co-Developed by Hasselblad, 48 MP Main camera, 50 MP Ultra Wide Angle Camera with Free Form Lens, 2 MP Monochorme Lens. Also comes with a 16 MP Front Camera
    
    Qualcomm Snapdragon 888 Processor with Adreno 660 GPU
    6.55 Inches Fluid AMOLED Display with 120Hz refresh rate
    OnePlus Oxygen OS based on Andriod 11
    Comes with 4500 mAh Battery with 65W Wired Charging
    Hands-Free access to Alexa: Alexa on your phone lets you make phone calls, open apps, control smart home devices, access the library of Alexa skills, and more using just your voice while on-the-go. Download the Alexa app and complete hands-free setup to get started. Just ask - and Alexa will respond instantly',

'https://i.postimg.cc/zBYL642Z/One-Plus-9-Blue.png'),

(22, 'OnePlus 9 Pro Green', 64999.0, 'OnePlus', '8/12 GB', '48MP+8MP+50MP+2MP', '4500 mAH', '128/256 GB',
'Rear Quad Camera Co-Developed by Hasselblad, 48 MP Main camera, 50 MP Ultra Wide Angle Camera with Sensor size of 1/1.56'', 8 MP Telepoto Lens, 2 MP Monochorme Lens,16 MP Front Camera
    Qualcomm Snapdragon 888 Processor
    with Adreno 660 GPU 6.7 Inches Fluid AMOLED Display with 120Hz refresh rate with Latest LTPO technology
    OnePlus Oxygen OS based on Andriod 11
    Comes with 4500 mAh Battery with 65W Wired Charging and 50W Wireless Charging capability',
'https://i.postimg.cc/dQB7NH8p/One-Plus-9-Pro-Green.png'),

(23, 'OnePlus Nord 2 Black', 29999.0, 'OnePlus', '6/8/12 GB', '50MP+8MP+2MP', '4500 mAH', '128/256 GB',
'Camera: Sony IMX 766 50MP+8MP+2MP AI Triple Camera with 4K@30FPS|1080p video at 30/60 fps | 32MP Front camera with 1080p video at 30/60 fps | Super Slow Motion: 1080p video at 120 fps, 720p video at 240 fps | Time-Lapse: 1080p 120fps;720p 240fps',
'https://i.postimg.cc/cJfWPFkV/One-Plus-Nord-2-Black.png'),

(24, 'OnePlus Nord 2 Blue', 29999.0, 'OnePlus', '6/8/12 GB', '50MP+8MP+2MP', '4500 mAH', '128/256 GB',
'Camera: Sony IMX 766 50MP+8MP+2MP AI Triple Camera with 4K@30FPS|1080p video at 30/60 fps | 32MP Front camera with 1080p video at 30/60 fps | Super Slow Motion: 1080p video at 120 fps, 720p video at 240 fps | Time-Lapse: 1080p 120fps;720p 240fps',
'https://i.postimg.cc/QtsDDcRV/One-Plus-Nord-2-Blue.png'),

(25, 'Realme 8 Black', 16000.0, 'Realme', '4/6/8 GB', '64MP+8MP+2MP+2MP', '5000 mAH', '64/128 GB',
'The realme 8 features a Super AMOLED Display so that you can enjoy vivid and eye-catching visuals that will enhance your viewing experience while streaming content, gaming, and so on. The Tilt-shift mode of the mobile phone can be used to play around with the perspective so that your pictures are out of the ordinary and mesmerising. And, thanks to the 16 MP Selfie Camera enables you to take delightful selfies with your loved ones and you can make them unique with features such as Selfie Nightscape and the AI Portrait mode. ',
'https://i.postimg.cc/pTQ9Hk39/Realme-8-Black.png'),

(26, 'Realme 8 Silver', 16000.0, 'Realme', '4/6/8 GB', '64MP+8MP+2MP+2MP', '5000 mAH', '64/128 GB',
'The realme 8 features a Super AMOLED Display so that you can enjoy vivid and eye-catching visuals that will enhance your viewing experience while streaming content, gaming, and so on. The Tilt-shift mode of the mobile phone can be used to play around with the perspective so that your pictures are out of the ordinary and mesmerising. And, thanks to the 16 MP Selfie Camera enables you to take delightful selfies with your loved ones and you can make them unique with features such as Selfie Nightscape and the AI Portrait mode. ',
'https://i.postimg.cc/nr0CsrFp/Realme-8-Silver.png'),

(27, 'Realme 9i Black', 15999.0, 'Realme', '4/6 GB', '50MP+2MP+2MP', '5000 mAH', '64/128 GB',
'6 GB RAM | 128 GB ROM | Expandable Upto 1 TB',
'https://i.postimg.cc/Y93HChHR/Realme-9i-Black.png'),

(28, 'Realme 9i Blue', 15999.0, 'Realme', '4/6 GB', '50MP+2MP+2MP', '5000 mAH', '64/128 GB',
'6 GB RAM | 128 GB ROM | Expandable Upto 1 TB',
'https://i.postimg.cc/hvZRV6h7/Realme-9i-Blue.png'),

(29, 'Realme C21 Black', 9500.0, 'Realme', '3/4 GB', '13MP+2MP+2MP', '5000 mAH', '32/64 GB',
'The realme C21 features a 5000 mAh powerful battery to enable you to use it for movie streaming, reading, gaming, and more for long hours without low-battery interruptions. With its Chroma Boost feature, your pictures will look breathtaking as their colours will be more vibrant and enhanced. And, this mobile phone has undergone stringent testing measures and also features the TUV Rheinland Smartphone High Credibility Certification to ensure that you get to enjoy a high-quality experience while using your smartphone. ',
'https://i.postimg.cc/NfJZ9Gtb/Realme-C21-Black.png'),

(30, 'Realme C21 Blue', 9500.0, 'Realme', '3/4 GB', '13MP+2MP+2MP', '5000 mAH', '32/64 GB',
'The realme C21 features a 5000 mAh powerful battery to enable you to use it for movie streaming, reading, gaming, and more for long hours without low-battery interruptions. With its Chroma Boost feature, your pictures will look breathtaking as their colours will be more vibrant and enhanced. And, this mobile phone has undergone stringent testing measures and also features the TUV Rheinland Smartphone High Credibility Certification to ensure that you get to enjoy a high-quality experience while using your smartphone. ',
'https://i.postimg.cc/tCYsvMpN/Realme-C21-Blue.png'),

(31, 'Realme X7 Silver', 20000.0, 'Realme', '6/8 GB', '64MP+8MP+2MP', '4300 mAH', '128 GB',
'With the realme X7, boredom will become a word you hardly use, thanks to this mobile phone’s innovative features. It has a Super AMOLED 16.3 cm (6.4) Display that gives you an expansive and immersive view of your favourite content and games. With 50 W SuperDart Charge and the Powerful Battery, your device will be quickly charged in a matter of minutes. And, its slim and lightweight design will make it easy for you to hold and use the device. ',
'https://i.postimg.cc/ZKsW4WsL/Realme-X7-Silver.png'),

(32, 'Redmi 9A Blue', 7300.0, 'Redmi', '2/3/4/6 GB', '13MP', '5000 mAH', '32/64/128 GB',
'Processor: MediaTek Helio G25 Octa-core; Up to 2.0GHz clock speed
    Camera: 13 MP Rear camera with AI portrait| 5 MP front camera
    Display: 16.58 centimeters (6.53-inch) HD+ display with 720x1600 pixels and 20:9 aspect ratio
    Battery: 5000 mAH large battery with 10W wired charger in-box
    Memory, Storage & SIM: 2GB RAM | 32GB storage | Dual SIM (nano+nano) + Dedicated SD card slot',
'https://i.postimg.cc/X7YrRfLJ/Redmi-9-A-Blue.png'),

(33, 'Redmi Note 10 Pro Max Black', 21999.0, 'Redmi', '6/8 GB', '108MP+8MP+5MP+2MP', '5020 mAH', '64/128 GB',
'Processor: Qualcomm Snapdragon 732G with Kryo 470 Octa-core; 8nm process; Up to 2.3GHz clock speed',
'https://i.postimg.cc/7hZyGwPk/Redmi-Note-10-Pro-Max-Black.png'),

(34, 'Redmi Note 10 Pro Max White', 21999.0, 'Redmi', '6/8 GB', '108MP+8MP+5MP+2MP', '5020 mAH', '64/128 GB',
'Processor: Qualcomm Snapdragon 732G with Kryo 470 Octa-core; 8nm process; Up to 2.3GHz clock speed',
'https://i.postimg.cc/VsKwyr4L/Redmi-Note-10-Pro-Max-Blue.png'),

(35, 'Redmi Note 9 Pro White', 19000.0, 'Redmi', '6/8 GB', '64MP+8MP+5MP+2MP', '5020 mAH', '64/128 GB',
'48MP rear camera with ultra-wide, super macro, portrait, night mode, 960fps slowmotion, AI scene recognition, pro color, HDR, pro mode | 13MP facing camera 16.9418 centimeters (6.67-inch) FHD+ full screen dot display LCD multi-touch capacitive touchscreen with 2400 x 1080 pixels resolution, 400 ppi pixel density and 20:9 aspect ratio | 2.5D curved glass Android v10 operating system with 2.3GHz Qualcomm Snapdragon 720G with 8nm octa core processor Memory, Storage & SIM: 4GB RAM | 64GB internal memory expandable up to 512GB with dedicated SD card slot | Dual SIM (nano+nano) dual-standby (4G+4G) 5020mAH lithium-polymer large battery providing talk-time of 29 hours and standby time of 492 hours | 18W fast charger in-box and Type-C connectivity',
'https://i.postimg.cc/sgBvX3tC/Redmi-note-9-Pro-White.png');