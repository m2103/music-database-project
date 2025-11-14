import { Search, Music, User } from "lucide-react";
import { Input } from "./ui/input";
import { Link } from "react-router-dom";

export function Header() {
  return (
    <header className="border-b border-border bg-background sticky top-0 z-50">
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center gap-6">
          {/* Logo */}
          <Link to="/" className="flex items-center gap-2">
            <Music className="w-8 h-8" />
            <span className="font-medium">SoundBox</span>
          </Link>

          {/* Navigation */}
          <nav className="flex items-center gap-6">
            <Link
              to="/"
              className="hover:text-muted-foreground transition-colors"
            >
              Home
            </Link>

            <Link
              to="/profile/1" // Replace with dynamic userID when logged in
              className="hover:text-muted-foreground transition-colors flex items-center gap-2"
            >
              <User className="w-5 h-5" />
              Profile
            </Link>
          </nav>

          {/* Search */}
          <div className="flex-1 max-w-2xl">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input
                type="text"
                placeholder="Search songs, albums, artists, profiles..."
                className="pl-10 bg-secondary w-full"
              />
            </div>
          </div>
        </div>
      </div>
    </header>
  );
}
