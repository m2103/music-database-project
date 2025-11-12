import { useEffect, useState } from "react";
import { SongCard } from "../components/SongCard.tsx";

type Song = { 
  songID: number;
  title: string; 
  artist_name: string; 
  avg_rating: number; 
  ratings_count: number; 
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
      <h1 style={{marginTop:0}}>Discover music</h1>

      <Section title={`Highest Rated Songs This Week`}>
        {topAvg.map(x =>
          <SongCard key={x.songID}
            title={x.title}
            artist={x.artist_name}
            averageRating={x.avg_rating}
            reviewCount={x.ratings_count} />)}
      </Section>

      <Section title="Most Rated Songs This Week">
        {mostRated.map(x =>
          <SongCard key={x.songID}
            title={x.title}
            artist={x.artist_name}
            averageRating={x.avg_rating}
            reviewCount={x.ratings_count} />)}
      </Section>
    </main>
  );
}

function Section({title, subtitle, children}:{title:string; subtitle?:string; children:React.ReactNode}) {
  return (
    <section style={{marginTop:24}}>
      <div style={{display:"flex", gap:12, alignItems:"baseline"}}>
        <h2 style={{margin:0}}>{title}</h2>
        {subtitle && <small style={{opacity:.75}}>{subtitle}</small>}
      </div>
      <div style={{display:"grid", gridTemplateColumns:"repeat(auto-fit, minmax(180px,1fr))", gap:12, marginTop:12}}>
        {children}
      </div>
    </section>
  );
}