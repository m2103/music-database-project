import { useEffect, useState } from "react";
import { SongCard } from "@/components/SongCard.tsx";
import { Section } from "@/components/Section.tsx";

type Song = { 
  songID: number;
  songName: string; 
  artists: string; 
  albumName: string;
  albumCover: string;
  avgRating: number; 
  reviewCount: number;
};
const API = "http://127.0.0.1:8000";

export default function Home() {
  const [topAvg, setTopAvg] = useState<Song[]>([]);
  const [mostRated, setMostRated] = useState<Song[]>([]);
  const k = 1;

  useEffect(() => {
    fetch(`${API}/homepage.php?mode=avg&k=${k}`).then(r=>r.json()).then(setTopAvg);
    fetch(`${API}/homepage.php?mode=count&k=${k}`).then(r=>r.json()).then(setMostRated);
  }, []);

  return (
    <main style={{padding:24, maxWidth:1100, margin:"0 auto"}}>
      <h1 className="text-4xl font-bold" style={{marginTop:0}}>Discover music</h1>
      <p className="text-muted-foreground text-lg">Explore and rate your favorite songs</p>

      <br />

      <Section title={`Highest Rated Songs This Week`}>
        {topAvg.map(x =>
          <SongCard key={x.songID}
            songID={x.songID}
            songName={x.songName}
            artists={x.artists}
            albumName={x.albumName}
            albumCover={x.albumCover}
            avgRating={x.avgRating}
            reviewCount={x.reviewCount} />)}
      </Section>

      <br />

      <Section title="Most Rated Songs This Week">
        {mostRated.map(x =>
          <SongCard key={x.songID}
            songID={x.songID}
            songName={x.songName}
            artists={x.artists}
            albumName={x.albumName}
            albumCover={x.albumCover}
            avgRating={x.avgRating}
            reviewCount={x.reviewCount} />)}
      </Section>
    </main>
  );
}