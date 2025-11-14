import pandas as pd
from faker import Faker
import random
import datetime
import os

DATA_DIR = "../data"
os.makedirs(DATA_DIR, exist_ok=True)

fake = Faker()
Faker.seed(43)
random.seed(43)

NUM_USERS = 3500
NUM_REVIEWS = 100000
MAX_SONG_ID = 10000

USER_START_DATE = datetime.datetime(2020, 1, 1, 0, 0, 0)
USER_END_DATE = datetime.datetime(2025, 1, 1, 0, 0, 0)
REVIEW_START_DATE = datetime.datetime(2020, 6, 1, 0, 0, 0)
REVIEW_END_DATE = datetime.datetime(2025, 11, 1, 0, 0, 0)

def random_date(start, end):
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second = random.randrange(int_delta)
    return start + datetime.timedelta(seconds=random_second)

print("Generating user data")
user_data = []

for _ in range(NUM_USERS):
    username = fake.user_name() + "_" + str(random.randint(1, 9999))
    email = f"{username}@example.com"
    password = f"hashed_pass_{random.randint(1000, 9999)}"
    profile_picture = f"https://picsum.photos/id/{random.randint(100, 999)}/200/300"
    date_joined = random_date(USER_START_DATE, USER_END_DATE)
    user_data.append({
        'username': username,
        'email': email,
        'password': password,
        'profilePicture': profile_picture,
        'dateJoined': date_joined.strftime('%Y-%m-%d %H:%M:%S')
    })

df_user = pd.DataFrame(user_data)
df_user = df_user.sort_values(by='dateJoined').reset_index(drop=True)
df_user.to_csv(f'{DATA_DIR}/user.csv', index=False)
print(f"Successfully created user.csv with {len(df_user)} entries.")

print("Generating review data")
review_data = []
review_set = set()
user_join_dates = pd.to_datetime(df_user['dateJoined']).tolist()

while len(review_data) < NUM_REVIEWS:
    user_id = random.randint(1, NUM_USERS)
    song_id = random.randint(1, MAX_SONG_ID)

    if (user_id, song_id) not in review_set:
        review_set.add((user_id, song_id))
        rating = random.randint(1, 5)
        user_join_date = user_join_dates[user_id - 1]
        earliest_review_date = max(user_join_date, REVIEW_START_DATE)
        timestamp = random_date(earliest_review_date, REVIEW_END_DATE)

        if rating == 5:
            comment = random.choice([
                "Absolutely flawless!",
                "My new favorite song. Instant classic.",
                "The production is incredible, five stars!",
                "ON REPEAT!!"
            ])
        elif rating == 4:
            comment = random.choice([
                "Vocals are crazyyy, but the beats throwing me off a bit. Still love it though",
                "Love the vibes",
                "Instant classic.",
                "straight into my playlist"
            ])
        elif rating == 3:
            comment = random.choice([
                "Lowkey mid, but maybe it'll grow on me",
                "It's ok, but I know there's more potential.",
                "I liked the beat, but the lyrics were weak."
            ])
        elif rating == 2:
            comment = random.choice([
                "a disappointing effort.",
                "the idea was good but the execution was not there",
                "I really wish I could like this",
                "Two stars for trying."
            ])
        else:
            comment = random.choice([
                "who approved this??",
                "do people actually listen to stuff like this",
                "A genuine failure, unfortunately.",
                "rip my ears"
            ])

        review_data.append({
            'userID': user_id,
            'songID': song_id,
            'rating': rating,
            'comment': comment,
            'timestamp': timestamp.strftime('%Y-%m-%d %H:%M:%S')
        })

df_review = pd.DataFrame(review_data)
df_review.to_csv(f'{DATA_DIR}/review.csv', index=False)
print(f"Successfully created review.csv with {len(df_review)} entries.")
print("Generation complete.")
