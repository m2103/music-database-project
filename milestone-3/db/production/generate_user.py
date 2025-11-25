import pandas as pd
from faker import Faker
import random
import os

DATA_DIR = "db/data"
os.makedirs(DATA_DIR, exist_ok=True)

fake = Faker()
Faker.seed(43)
random.seed(43)

NUM_USERS = 10000

users = []
for i in range(1, NUM_USERS + 1):
    users.append({
        "username": f"user{i}",
        "name": fake.name(),
        "email": fake.email(),
        "password": "hashed_password",
        "profilePicture": f"https://picsum.photos/seed/user{i}/200",
        "dateJoined": fake.date_between(start_date='-5y', end_date='today')
    })

df = pd.DataFrame(users)
df.to_csv(f"{DATA_DIR}/user.csv", index=False)

print(f"Generated user.csv with {NUM_USERS} entries.")
