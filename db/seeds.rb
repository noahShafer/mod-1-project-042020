trump_photo = User.fetch_dog_photo
kanye_photo = User.fetch_dog_photo
elon_photo = User.fetch_dog_photo
jaden_photo = User.fetch_dog_photo

trump = User.create(username: "realDonaldTrump", display_name: "Donald J. Trump", email: "trump@gmail.com", profile_pic: trump_photo, password: "123")
kanye = User.create(username: "KanyeWest", display_name: "Yeezy", email: "kanye@gmail.com", profile_pic: kanye_photo, password: "123")
elon = User.create(username: "ElonMusk", display_name: "Elon Musk", email: "elon@gmail.com", profile_pic: elon_photo, password: "123")
jaden = User.create(username: "JadenSmith", display_name: "Jaden", email: "jdawg@gmail.com", profile_pic: jaden_photo, password: "123")

trump.create_tweet("Sorry losers and haters, but my I.Q. is one of the highest -and you all know it! Please don't feel stupid or insecure,it's not your fault")
jaden.create_tweet("If Everyone dropped out of school we would have a much more intelligent society")
trump.create_tweet("Healthy young child goes to doctor, gets pumped with massive shot of many vaccines, doesn't felel good and changes - AUTISM, Many such cases!")
trump.create_tweet("Lowest rated Oscars in HISTORY. Problem is, we don’t have Stars anymore - except your President (just kidding, of course)!")
elon.create_tweet("I am selling almost all physical possessions. Will own no house.")
kanye.create_tweet("Have you ever thought you were in love with someone but then realized you were just staring in a mirror for 20 minutes")
kanye.create_tweet("Sometimes I push the door close button on people running towards the eleator. I just need my own elevator sometimes. My sanctuary.")
elon.create_tweet("Sew one button, doesn't make u a tailor; cook one meal, doesn't make u a chef; but f* one horse and u r a horsef*er for all of history...")
jaden.create_tweet("How Can Mirrors Be Real If Our Eyes Aren't Real")
kanye.create_tweet("I hate when I'm on a flight and I wake up with a water bottle next to me like oh great now I gotta be responsible for this water bottle")
elon.create_tweet("Tesla stock price is too high imo")
jaden.create_tweet("I Watch Twilight Every Night")

trump.follow(user: kanye)
kanye.follow(user: trump)
elon.follow(user: trump)
elon.follow(user: kanye)
jaden.follow(user: trump)
jaden.follow(user: kanye)
jaden.follow(user: trump)
