import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";
import { Star} from "lucide-react";

export type Review = {
  title: string;
  subtitle: string;
  rating: number;
  comment: string;
  timestamp: string;
  profilePicture: string;
};

export default function ReviewCard({ review }: { review: Review }) {
  const initials =
    review.title
      .split(" ")
      .map((part) => part[0])
      .join("")
      .slice(0, 2) || "U";

  return (
    <Card className="border border-border/60 rounded-2xl">
      <CardContent>
        <div className="flex justify-between gap-3">
          <div className="flex gap-3">
            <Avatar className="w-9 h-9">
              <AvatarImage src={review.profilePicture} alt={review.title} />
              <AvatarFallback className="text-xs">{initials}</AvatarFallback>
            </Avatar>
            <div className="space-y-0.5">
              <p className="text-sm font-medium flex items-center gap-1">
                {review.title}
              </p>
              <p className="text-xs text-muted-foreground mb-3">{review.subtitle}</p>
              <div className="flex items-center gap-3 text-xs text-muted-foreground">
                <div className="flex items-center gap-1 text-sm">
                    {Array.from({ length: 5 }).map((_, i) => (
                    <Star
                        key={i}
                        className={
                        "w-3.5 h-3.5 " +
                        (i < review.rating
                            ? "text-yellow-400 fill-yellow-400"
                            : "text-muted-foreground")
                        }
                    />
                    ))}
                </div>
                <p className="text-xs text-muted-foreground">
                    {new Date(review.timestamp).toISOString().slice(0, 10)}
                </p>
              </div>
              <p className="pt-2 text-sm leading-relaxed text-foreground">
                {review.comment}
                </p>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}