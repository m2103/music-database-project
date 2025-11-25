import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Header } from './components/Header';
import { Toaster } from 'sonner';
import Home from './pages/Home';
import Details from './pages/Details';
import Profile from './pages/Profile';

export default function App() {
  return (
    <Router>
      <div className="min-h-screen bg-background">
        <Header />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/details/:songID" element={<Details />} />
          <Route path="/profile/:userID" element={<Profile />} />
        </Routes>
        <Toaster richColors/>
      </div>
    </Router>
  );
}
