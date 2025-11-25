import { useEffect, useState } from "react";
import { useParams } from "react-router-dom"; // <-- import this
import ProfileCard from "@/components/ProfileCard";
import ReviewCard from "@/components/ReviewCard";
import type { Review } from "@/components/ReviewCard";
import { Separator } from "@/components/ui/separator";

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
  profilePicture: string;
};

type UnpopularReview = ProfileReview & {
  avgRating: number | null;
  deviation: number;
  direction: "above" | "below" | "equal";
};

type UserProfile = {
  userName: string;
  email: string;
  profilePicture: string | null;
  dateJoined: string;
  recentReviews: ProfileReview[] | null;
  unpopularReviews: UnpopularReview[] | null;
};

export default function Profile() {
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const { userID } = useParams<{ userID: string }>(); // <-- get userID from URL

  useEffect(() => {
    if (!userID) return;

    fetch(`${API}/profile.php?userID=${userID}`)
      .then((res) => res.json())
      .then(setProfile)
      .catch((err) => console.error(err));
  }, [userID]);

  if (!profile) return <main style={{ padding: 24 }}>Loading...</main>;

  // Adapter: convert ProfileReview to ReviewCard's Review type
  const recentReviewCards: Review[] = (
    Array.isArray(profile.recentReviews) ? profile.recentReviews : []
  ).map((r: ProfileReview) => ({
    title: r.songName,
    subtitle: r.artists,
    rating: r.rating,
    comment: r.comment || "",
    timestamp: r.timestamp,
    profilePicture: r.profilePicture,
  }));

  const unpopularReviewCards: Review[] = (
    Array.isArray(profile.unpopularReviews) ? profile.unpopularReviews : []
  ).map((r: UnpopularReview) => {
    const avg = typeof r.avgRating === "number" ? r.avgRating : null;

    return {
      title: r.songName,
      subtitle: `${r.artists} • Global avg ${avg !== null ? avg.toFixed(1) : "—"}`,
      rating: r.rating,
      comment: r.comment || "",
      timestamp: r.timestamp,
      profilePicture: r.profilePicture,
      meta: [
        { label: "Your score", value: r.rating.toFixed(1) },
        { label: "Global avg", value: avg !== null ? avg.toFixed(1) : "n/a" },
      ],
      badge:
        r.direction === "equal"
          ? undefined
          : {
              text: r.direction === "above" ? "Above consensus" : "Below consensus",
              tone: r.direction === "above" ? "positive" : "negative",
            },
    };
  });

  return (
    <main
      style={{
        padding: 24,
        maxWidth: 900,
        margin: "0 auto",
        display: "flex",
        flexDirection: "column",
        gap: 24,
      }}
    >
      {/* Profile top segment */}
      <ProfileCard
        userName={profile.userName}
        email={profile.email}
        profilePicture={profile.profilePicture}
        dateJoined={profile.dateJoined}
      />

      {/* Recent Reviews */}
      <section>
        <div className="flex items-center justify-between gap-2">
          <h2 className="text-2xl font-semibold italic">Recent Reviews</h2>
          <span className="text-xs text-muted-foreground">
            {recentReviewCards.length} review{recentReviewCards.length === 1 ? "" : "s"}
          </span>
        </div>
        <Separator className="my-4" />

        {recentReviewCards.length === 0 ? (
          <p className="text-muted-foreground">No reviews yet.</p>
        ) : (
          <div className="flex flex-col gap-4">
            {recentReviewCards.map((review, i) => (
              <ReviewCard key={i} review={review} />
            ))}
          </div>
        )}
      </section>

      {/* Unpopular Reviews */}
      <section>
        <div className="flex items-center justify-between gap-2">
          <h2 className="text-2xl font-semibold italic">Controversial Takes</h2>
          <span className="text-xs text-muted-foreground">
            {unpopularReviewCards.length} standout
            {unpopularReviewCards.length === 1 ? "" : "s"}
          </span>
        </div>
        <Separator className="my-4" />

        {unpopularReviewCards.length === 0 ? (
          <p className="text-muted-foreground">
            Once your ratings diverge from the crowd (±1.5★), they will appear here.
          </p>
        ) : (
          <div className="flex flex-col gap-4">
            {unpopularReviewCards.map((review, i) => (
              <ReviewCard key={`unpopular-${i}`} review={review} />
            ))}
          </div>
        )}
      </section>
    </main>
  );
}
