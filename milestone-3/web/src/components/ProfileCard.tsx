import { Card, CardContent } from "@/components/ui/card";

export type ProfileCardProps = {
  name: string;
  userName: string;
  email: string;
  profilePicture: string | null;
  dateJoined: string;
};

export default function ProfileCard({ name, userName, email, profilePicture, dateJoined }: ProfileCardProps) {
  return (
    <Card className="rounded-2xl border border-border/60">
      <CardContent className="flex items-center gap-6">
        <img
          src={profilePicture || "/default-avatar.png"}
          alt="Profile"
          className="w-24 h-24 rounded-full object-cover"
        />
        <div>
          <h2 className="text-2xl font-semibold">{name}</h2>
          <p className="text-lg text-muted-foreground">@{userName}</p>
          <p className="text-sm text-muted-foreground">{email}</p>
          <small className="text-xs text-muted-foreground">Joined {dateJoined}</small>
        </div>
      </CardContent>
    </Card>
  );
}
