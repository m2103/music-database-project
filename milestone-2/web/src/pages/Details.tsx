import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { Star, ArrowLeft } from "lucide-react";

import {
  Card,
  CardContent,
  CardTitle,
  CardDescription,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";

import ReviewCard, { type Review } from "@/components/ReviewCard";

const API = "http://127.0.0.1:8000";

type Song = {
  songID: number;
  songName: string;
  artists: string;
  releaseDate: string;
  spotifyURL: string;
  albumName: string;
  albumCover: string;
  avgRating: number;
  reviewCount: number;
};

type SongResponse = {
  song: Song;
  reviews: Review[];
};

export default function Details() {
  const { songID } = useParams<{ songID: string }>();
  const [data, setData] = useState<SongResponse | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!songID) return;
    setLoading(true);
    fetch(`${API}/song.php?songID=${songID}`)
      .then((r) => r.json())
      .then((json) => setData(json))
      .finally(() => setLoading(false));
  }, [songID]);

  if (loading) {
    return (
      <main className="max-w-5xl mx-auto px-4 sm:px-6 py-8">
        <p className="text-sm text-muted-foreground">Loading song…</p>
      </main>
    );
  }

  if (!data || !data.song) {
    return (
      <main className="max-w-5xl mx-auto px-4 sm:px-6 py-8">
        <p className="text-sm text-red-500">Song not found.</p>
      </main>
    );
  }

  const { song, reviews } = data;

  return (
    <main className="max-w-5xl mx-auto px-4 sm:px-6 py-8 space-y-10">
      {/* Back link */}
      <div className="flex items-center gap-2 text-sm text-muted-foreground">
        <Link to="/" className="inline-flex items-center gap-1 hover:underline">
          <ArrowLeft className="w-4 h-4" />
          Back to home
        </Link>
      </div>

      {/* cover + meta + stats */}
      <section className="space-y-6">
        <Card className="overflow-hidden pt-0 rounded-2xl shadow-sm">
          {/* Big cover */}
          <div className="aspect-[4/3] w-full bg-muted overflow-hidden">
            <img
              src={song.albumCover}
              alt={`${song.albumName} cover`}
              onError={(e) => {
                e.currentTarget.src = "../image.png";
              }}
              className="w-full h-full object-cover"
            />
          </div>

          {/* Text + stats + listen on spotify */}
          <CardContent className="px-6 py-5 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
            {/* Left: title / artist / album */}
            <div className="space-y-1">
              <CardTitle className="text-2xl sm:text-3xl">
                {song.songName}
              </CardTitle>
              <CardDescription className="text-base text-muted-foreground">
                {song.artists}
              </CardDescription>
              <p className="text-sm text-muted-foreground">
                {song.albumName} &#8226; {song.releaseDate.slice(0, 4)}
              </p>

              <p>
                <a
                  href={song.spotifyURL}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-sm text-blue-600 italic hover:underline"
                >
                  Listen on Spotify
                </a>
              </p>
            </div>

            {/* Right: rating */}
            <div className="flex items-center justify-between mb-4 pr-4">
                <div>
                  <div className="flex items-center gap-2 mb-1">
                    <Star className="w-6 h-6 fill-yellow-500 text-yellow-500" />
                    <span className="text-3xl font-bold">{
                      song.avgRating?.toFixed ? song.avgRating.toFixed(1) : song.avgRating
                    }</span>
                    <span className="text-muted-foreground">/ 5</span>
                  </div>
                  <p className="text-sm text-muted-foreground text-end">
                    {song.reviewCount.toLocaleString()} ratings
                  </p>
                </div>
              </div>
          </CardContent>
        </Card>

        {/* Quick actions row */}
        <div className="flex flex-wrap items-center gap-3 justify-between">
          <div className="flex items-center gap-2 text-sm text-muted-foreground">
            <span>Rate this song</span>
            <div className="flex items-center gap-1">
              {Array.from({ length: 5 }).map((_, i) => (
                <Star key={i} className="w-4 h-4 text-muted-foreground" />
              ))}
            </div>
          </div>

          <Button size="sm" variant="secondary">
            Write a Review
          </Button>
        </div>
      </section>

      {/* Reviews list */}
      <section className="space-y-4">
        <div className="flex items-center justify-between gap-2">
          <h2 className="text-xl font-semibold">Reviews</h2>
          <span className="text-xs text-muted-foreground">
            {reviews.length} review{reviews.length === 1 ? "" : "s"}
          </span>
        </div>
        <Separator />

        {reviews.length === 0 ? (
          <p className="text-sm text-muted-foreground">
            No reviews yet. Be the first to write one!
          </p>
        ) : (
          <div className="space-y-4">
            {reviews.map((review, idx) => (
              <ReviewCard key={idx} review={review} />
            ))}
          </div>
        )}
      </section>
    </main>
  );
}