import { createContext, useContext, useState, ReactNode } from "react";
import { useNavigate } from "react-router-dom";

type AuthContextType = {
  userID: number | null;
  login: (userID: number) => void;
  logout: () => void;
};

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [userID, setUserID] = useState<number | null>(
    () => Number(localStorage.getItem("userID")) || null
  );
  const navigate = useNavigate();

  function login(id: number) {
    setUserID(id);
    localStorage.setItem("userID", id.toString());
    navigate(`/profile/${id}`);
  }

  function logout() {
    setUserID(null);
    localStorage.removeItem("userID");
    navigate("/login");
  }

  return (
    <AuthContext.Provider value={{ userID, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error("useAuth must be used within an AuthProvider");
  return context;
};