import { useEffect, useState } from "react";
import { SongCard } from "../components/SongCard.tsx";

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
    // TO USE FOR MILESTONE 3
    // fetch(`${API}/homepage.php?mode=avg&k=${k}`).then(r=>r.json()).then(setTopAvg);
    // fetch(`${API}/homepage.php?mode=count&k=${k}`).then(r=>r.json()).then(setMostRated);
    fetch(`${API}/homepage.php`).then(r=>r.json()).then(setTopAvg);
    fetch(`${API}/homepage.php`).then(r=>r.json()).then(setMostRated);
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

function Section({title, subtitle, children}:{title:string; subtitle?:string; children:React.ReactNode}) {
  return (
    <section style={{marginTop:24}}>
      <div style={{display:"flex", gap:12, alignItems:"baseline"}}>
        <h2 className="text-2xl font-semibold italic" style={{margin:0}}>{title}</h2>
        {subtitle && <small style={{opacity:.75}}>{subtitle}</small>}
      </div>
      <div style={{display:"grid", gridTemplateColumns:"repeat(auto-fit, minmax(180px,1fr))", gap:12, marginTop:12}}>
        {children}
      </div>
    </section>
  );
}