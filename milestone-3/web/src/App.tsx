import { Routes, Route } from 'react-router-dom';
import { Toaster } from 'sonner';
import { AuthProvider } from "@/context/AuthContext";

import { Header } from './components/Header';
import Home from './pages/Home';
import Details from './pages/Details';
import Profile from './pages/Profile';
import Search from './pages/Search';
import Login from "./pages/Login";

export default function App() {
  return (
    <AuthProvider>
      <div className="min-h-screen bg-background">
        <Header />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/details/:songID" element={<Details />} />
          <Route path="/profile/:userID" element={<Profile />} />
          <Route path="/search" element={<Search />} />
          <Route path="/login" element={<Login />} />
        </Routes>
        <Toaster richColors />
      </div>
    </AuthProvider>
  );
}