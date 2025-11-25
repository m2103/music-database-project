import { SongCard } from "@/components/SongCard";
import { Section } from "@/components/Section";
import { useEffect, useState } from "react";
import { useSearchParams, Link, useNavigate } from "react-router-dom";

const API = "http://127.0.0.1:8000"; // same as other pages

type SearchResult = {
  songID: number;
  songName: string;
  artists: string;
  albumName: string;
  albumCover: string;
  avgRating: number | null;
  reviewCount: number;
};

export default function Search() {
  const [params] = useSearchParams();
  const q = params.get("q") || "";
  const [results, setResults] = useState<SearchResult[]>([]);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    if (!q) return;
    setLoading(true);
    fetch(`${API}/search.php?q=${encodeURIComponent(q)}`)
      .then((r) => r.json())
      .then((json) => setResults(Array.isArray(json) ? json : []))
      .finally(() => setLoading(false));
  }, [q]);

  if (!q) {
    navigate("/");
    return null;
  }

  return (
    <main style={{ padding: 24, maxWidth: 1100, margin: "0 auto" }}>
        <Section title={`Results for "${q}"`}>
            {loading ? (
            <p>Loading...</p>
            ) : results.length === 0 ? (
            <p>No results found for "{q}"</p>
            ) : (
            results.map((x) => (
                <SongCard
                    key={x.songID}
                    songID={x.songID}
                    songName={x.songName}
                    artists={x.artists}
                    albumName={x.albumName}
                    albumCover={x.albumCover}
                    avgRating={x.avgRating || 0}
                    reviewCount={x.reviewCount}
                />
            ))
            )}
        </Section>
    </main>
  );
}