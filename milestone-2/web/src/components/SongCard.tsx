import { Star } from 'lucide-react';
import { Card, CardContent } from './ui/card';

type Props = {
    title: string;
    artist: string;
    averageRating: number;
    reviewCount: number;
}

export function SongCard({ title, artist, averageRating, reviewCount }: Props) {
  return (
    <Card className="group overflow-hidden border-border/40 hover:border-border transition-all hover:shadow-lg cursor-pointer">
      <CardContent className="p-0">
        <div className="relative aspect-square overflow-hidden bg-muted">
          
          <div className="absolute top-2 right-2 bg-black/80 backdrop-blur-sm rounded-full px-2.5 py-1 flex items-center gap-1">
            <Star className="w-3.5 h-3.5 fill-yellow-500 text-yellow-500" />
            <span className="text-white font-semibold text-xs">{averageRating}</span>
          </div>
        </div>

        {/* Song Info */}
        <div className="p-3 space-y-1">
          <div>
            <h3 className="font-semibold text-sm line-clamp-1 text-balance">{title}</h3>
            <p className="text-xs text-muted-foreground line-clamp-1">{artist}</p>
          </div>

          <p className="text-xs text-muted-foreground">{reviewCount} ratings</p>
        </div>
      </CardContent>
    </Card>
  );
}