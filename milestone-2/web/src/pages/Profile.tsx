import { useEffect, useState } from "react";
import ProfileCard from "@/components/ProfileCard";
import ReviewCard from "@/components/ReviewCard";
import type { Review } from "@/components/ReviewCard";


const API = "http://127.0.0.1:8000";

type ProfileReview = {
  reviewID: number;
  rating: number;
  comment: string | null;
  timestamp: string;
  songID: number;
  songName: string;
  albumID: number;
  albumName: string;
  albumCover: string;
  artists: string;
};

type UserProfile = {
  userName: string;
  email: string;
  profilePicture: string | null;
  dateJoined: string;
  recentReviews: ProfileReview[] | null;
};

export default function Profile() {
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const userID = 1; // replace with dynamic logic later

  useEffect(() => {
    fetch(`${API}/profile.php?userID=${userID}`)
      .then((res) => res.json())
      .then(setProfile)
      .catch((err) => console.error(err));
  }, [userID]);

  if (!profile) return <main style={{ padding: 24 }}>Loading...</main>;

  // Adapter: convert ProfileReview to ReviewCard's Review type
  const reviewCards: Review[] =
    profile.recentReviews?.map((r) => ({
      userName: `${r.songName} — ${r.artists}`, // show song + artists
      rating: r.rating,
      comment: r.comment || "",
      timestamp: r.timestamp,
    })) || [];

  return (
    <main style={{ padding: 24, maxWidth: 900, margin: "0 auto", display: "flex", flexDirection: "column", gap: 24 }}>
      {/* Profile top segment */}
      <ProfileCard
        userName={profile.userName}
        email={profile.email}
        profilePicture={profile.profilePicture}
        dateJoined={profile.dateJoined}
      />

      {/* Recent Reviews */}
      <section>
        <h2 className="text-2xl font-semibold italic mb-4">Recent Reviews</h2>
        {reviewCards.length === 0 ? (
          <p className="text-muted-foreground">No reviews yet.</p>
        ) : (
          <div className="flex flex-col gap-4">
            {reviewCards.map((review, i) => (
              <ReviewCard key={i} review={review} />
            ))}
          </div>
        )}
      </section>
    </main>
  );
}