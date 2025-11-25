import { Search, Music, User, X, LogOut } from "lucide-react";
import { Input } from "./ui/input";
import { Link, useNavigate } from "react-router-dom";
import { useState } from "react";
import { useAuth } from "@/context/AuthContext";

export function Header() {
  const { userID, logout } = useAuth();
  const [searchQuery, setSearchQuery] = useState("");
  const navigate = useNavigate();

  const profileLink = userID ? `/profile/${userID}` : "/login";

  function clearSearch() {
    setSearchQuery("");
    navigate("/");
  }

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
            <Link to="/" className="hover:text-muted-foreground">
              Home
            </Link>

            <Link
              to={profileLink}
              className="hover:text-muted-foreground flex items-center gap-2"
            >
              <User className="w-5 h-5" />
              {userID ? "Profile" : "Login"}
            </Link>

            {/* Show logout button if logged in */}
            {userID && (
              <button
                onClick={logout}
                className="flex items-center gap-1 hover:text-red-500 transition-colors"
              >
                <LogOut className="w-4 h-4" />
                Logout
              </button>
            )}
          </nav>

          {/* Search */}
          <div className="flex-1 max-w-2xl">
            <form
              className="relative"
              onSubmit={(e) => {
                e.preventDefault();
                const trimmedQuery = searchQuery.trim();
                if (trimmedQuery) {
                  navigate(`/search?q=${encodeURIComponent(trimmedQuery)}`);
                } else {
                  clearSearch();
                }
              }}
            >
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input
                type="text"
                placeholder="Search songs, albums, artists..."
                className="pl-10 bg-secondary w-full"
                value={searchQuery}
                onChange={(e) => {
                  const next = e.target.value;
                  setSearchQuery(next);
                  const trimmedQuery = next.trim();
                  if (!trimmedQuery) {
                    navigate("/");
                  } else {
                    navigate(`/search?q=${encodeURIComponent(trimmedQuery)}`);
                  }
                }}
              />
              {searchQuery && (
                <button
                  type="button"
                  className="absolute right-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-muted-foreground"
                  onClick={clearSearch}
                >
                  <X className="w-4 h-4" />
                </button>
              )}
            </form>
          </div>
        </div>
      </div>
    </header>
  );
}