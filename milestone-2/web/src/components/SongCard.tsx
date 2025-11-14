import { Star } from 'lucide-react';
import { Card, CardContent } from './ui/card';
import { useNavigate } from 'react-router-dom';

type Props = {
    songID: number;
    songName: string;
    artists: string;
    albumName: string;
    albumCover: string;
    avgRating: number;
    reviewCount: number;
}

export function SongCard({ songID, songName, artists, albumName, albumCover, avgRating, reviewCount }: Props) {
  const navigate = useNavigate();
  
  return (
    <Card 
      className="group overflow-hidden pt-0 border-border/40 hover:border-border transition-all hover:shadow-lg cursor-pointer"
      onClick={() => navigate(`/details/${songID}`)}
    >
      <CardContent className="p-0">
        <div className="relative aspect-square overflow-hidden bg-muted">
          <img src={albumCover} alt={`${albumName} cover`} onError={(e) => { e.currentTarget.src = "image.png"; }} className="object-cover w-full h-full" />
          <div className="absolute top-2 right-2 bg-black/80 backdrop-blur-sm rounded-full px-2.5 py-1 flex items-center gap-1">
            <Star className="w-3.5 h-3.5 fill-yellow-500 text-yellow-500" />
            <span className="text-white font-semibold text-xs">{avgRating}</span>
          </div>
        </div>

        {/* Song Info */}
        <div className="p-3 pt-5 space-y-1">
          <div>
            <h3 className="font-semibold line-clamp-1 text-balance">{songName}</h3>
            <p className="text-xs text-muted-foreground line-clamp-1">{artists}</p>
          </div>
          <p className="text-xs italic text-muted-foreground float-left line-clamp-1">{albumName}</p>
          <p className="text-xs text-muted-foreground float-right">{reviewCount} ratings</p>
        </div>
      </CardContent>
    </Card>
  );
}