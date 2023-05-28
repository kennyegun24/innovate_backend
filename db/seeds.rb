# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create(name:'Kenny Elias', user_name:'Kenzo',image:'https://res.cloudinary.com/drfqge33t/image/upload/v1684952624/kenny-removebg-preview_1_kurz3x.png', email:'Kenzo@gmail.com', password: '12345678')
user2 = User.create(name:'Donald Trump', user_name:'donald',image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685238916/R_pnfvsr.jpg', email:'donald@gmail.com', password: '12345678')
user3 = User.create(name:'Kim Jong Un', user_name:'kim',image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685238862/download_y2qsxf.jpg', email:'kim@gmail.com', password: '12345678')
user4 = User.create(name:'Elon Musk', user_name:'elonMusk',image:'https://res.cloudinary.com/drfqge33t/image/upload/v1685238676/R_al8xvl.jpg', email:'elonMusk@gmail.com', password: '12345678')
user5 = User.create(name:'Bill Gates', user_name:'gates',image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685238516/R_tbzp6p.jpg', email:'gates@gmail.com', password: '12345678')
user6 = User.create(name:'Warren Buffett', user_name:'warren',image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685238537/R_sdigwb.jpg', email:'warren@gmail.com', password: '12345678')
user7 = User.create(name:'Kota The Friend', user_name:'goata',image:'https://res.cloudinary.com/drfqge33t/image/upload/v1685238280/R_lsmved.jpg', email:'goata@gmail.com', password: '12345678')
user8 = User.create(name:'J.Cole', user_name:'cole',image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685238311/OIP_s3uu7e.jpg', email:'cole@gmail.com', password: '12345678')
user9 = User.create(name:'Nf', user_name:'nfRealmusic',image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685238466/R_ykrx21.jpg', email:'nfRealmusic@gmail.com', password: '12345678')
user10 = User.create(name:'Nasty', user_name:'nasty_cSA',image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685238340/R_c0adfg.jpg', email:'nasty_cSA@gmail.com', password: '12345678')
user11 = User.create(name:'Shane Eagle', user_name:'shane_eagle',image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685238435/R_h3eza8.jpg', email:'shane_eagle@gmail.com', password: '12345678')

post1 = Post.create(text: 'Nothing is quite as inspiring as the friendship and love of our best friends. They are the people that fill our lives up with joy and make our bad days feel a little more bearable', image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685239478/R_i7pdxo.jpg', author: user1)
post2 = Post.create(text: "They say that friends are the family that you choose, and this couldn't be more true. More important than the things that we have in our lives are the people that we have in our lives. True friendship makes us feel full of love and happiness, and that is a feeling that you can't put a price on.", image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685239478/R_i7pdxo.jpg', author: user1)
post3 = Post.create(author: user2, text: 'We will make America strong again. We will make America safe again. And we will make America great again, greater than ever before.', image:'https://res.cloudinary.com/drfqge33t/image/upload/v1685239400/R_llcyci.jpg')
post4 = Post.create(author: user3, text: "If the American imperialists provoke us a bit, we will not hesitate to slap them with a pre-emptive nuclear strike. The United States must choose! It's up to you whether the nation called the United States exists on this planet or not.", image:'https://res.cloudinary.com/drfqge33t/image/upload/v1685238916/R_pnfvsr.jpg')
post5 = Post.create(text: "Most people aren't certain about what they want... What I want... a beautiful family of mine... wifey who is loyal, cos I can't share who I love... I want a life where I and my future spouse will coexist in peace, love and in truth. No hiding of things, we let it all out whenever anything isn't right... Till then, my love. .", image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685239536/wp6974896_k1ojtk.jpg', author: user1)
post6 = Post.create(author: user2, text: "The worst things in history have happened when people stop thinking for themselves, especially when they allow themselves to be influenced by negative people. That's what gives rise to dictators. Avoid that at all costs...")
post7 = Post.create(author: user3, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685239373/OIP_c2fpip.jpg', text:"It is a proud tradition and fighting trait of our army and people to rise up like mountains and go through fire and water to unfailingly carry through the party's orders and instructions")
post8 = Post.create(author: user10, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685240005/P13-nasty-C-shwashwi-1364x2048_li9kla.jpg', text: "What a fvckin turn out it wass from the fans!!!! Couldn't believe it got sold out and the crowd was really massive!!!!! Beautiful people!!")


post9 = Post.create(author: user9, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685239185/R_uzwocw.jpg', text: "It was a memorable show in Melbourne Australia. Passionate humans, thanks for turning up!! Netherlands up next!!.")
post10 = Post.create(author: user5, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685240180/download_xciff7.jpg', text: "If you are born poor, it is not your mistake. But if you die poor, it is your mistake")
post11 = Post.create(author: user6, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685240247/download_qrynlt.jpg', text: "If you don't find a way to make money while you sleep, you will work till you die")
post12 = Post.create(author: user8, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685240508/download_k1prih.jpg', text: "Girls with natural bodies and normal jobs are still winning, don't let this social media shit fool you.")
post13 = Post.create(author: user11, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685239232/download_fo9zwa.jpg', text: "Beautiful turnup in JoBurg!!!!")
post14 = Post.create(author: user4, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685239344/img_ajoxpm.webp', text: "This is the future of the world... Where we live in a distant planet.")
post15 = Post.create(author: user9, image: '', text: "Just love yourself and let go of the hurt. Be a better version of yourself.")
post16 = Post.create(author: user7, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685240621/R_nhhl9p.jpg', text: "I hope you find peace and love in what you do.")
post17 = Post.create(author: user8, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685240406/05_J_Cole_Quotes_Id_rather_be_happy_nghz0i.webp', text: "I'd rather be happy being myself, than sad being someone else.")
post20 = Post.create(author: user7, image: 'https://res.cloudinary.com/drfqge33t/image/upload/v1685239051/kotathefriend-e1591917483261_ru2aq2.webp', text: "I hope you just be you and tell the rest to f**k off")