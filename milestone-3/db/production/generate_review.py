import pandas as pd
from faker import Faker
import random
import datetime
import os

DATA_DIR = "db/data"
os.makedirs(DATA_DIR, exist_ok=True)

fake = Faker()
Faker.seed(43)
random.seed(43)

NUM_REVIEWS = 100000

REVIEW_START_DATE = datetime.datetime(2020, 6, 1)
REVIEW_END_DATE = datetime.datetime.today()

def random_date(start, end):
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second = random.randrange(int_delta)
    return start + datetime.timedelta(seconds=random_second)

# Load users and songs
df_user = pd.read_csv(f"{DATA_DIR}/user.csv")
df_song = pd.read_csv(f"{DATA_DIR}/song.csv")

user_ids = df_user.index + 1  # userID auto-increment starts at 1
song_ids = df_song["songID"].tolist()

print("Generating review data aligned with actual users and songs...")
review_data = []
review_set = set()
user_join_dates = pd.to_datetime(df_user['dateJoined']).tolist()

while len(review_data) < NUM_REVIEWS:
    user_idx = random.randint(0, len(user_ids) - 1)
    user_id = user_ids[user_idx]
    song_id = random.choice(song_ids)

    if (user_id, song_id) in review_set:
        continue

    review_set.add((user_id, song_id))
    rating = random.randint(1, 5)

    user_join_date = user_join_dates[user_idx]
    earliest_review_date = max(user_join_date, REVIEW_START_DATE)
    timestamp = random_date(earliest_review_date, REVIEW_END_DATE)

    # Generate a simple comment based on rating
    comment_map = {
        5: ["Absolutely flawless!", "Instant classic.", "ON REPEAT!!"],
        4: ["Love the vibes", "Straight into my playlist", "Good but minor issues"],
        3: ["It's ok", "Average", "Could be better"],
        2: ["Disappointing", "Not my taste", "Two stars for trying."],
        1: ["Terrible", "Rip my ears", "Do people actually listen to this?"]
    }
    comment = random.choice(comment_map[rating])

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