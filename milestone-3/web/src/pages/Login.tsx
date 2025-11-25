import { useState } from "react";
import { useAuth } from "@/context/AuthContext";

const API = "http://127.0.0.1:8000";

export default function Login() {
  const { login } = useAuth();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError("");

    try {
      const res = await fetch(`${API}/login.php`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password }),
      });

      // Parse JSON safely
      const data = await res.json();

      if (res.ok && data.userID) {
        // Successful login
        login(data.userID);
      } else if (data.error) {
        // Display server-provided error
        setError(data.error);
      } else {
        setError("Unexpected error. Please try again.");
      }
    } catch (err) {
      // Network or parsing error
      setError("Server error. Please try again later.");
      console.error("Login fetch error:", err);
    }
  }

  return (
    <main className="max-w-sm mx-auto mt-24 p-6 border rounded-lg shadow">
      <h1 className="text-2xl font-bold mb-4">Login</h1>
      <form onSubmit={handleSubmit} className="flex flex-col gap-4">
        <input
          type="text"
          placeholder="Username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
          className="border px-3 py-2 rounded"
          required
        />
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          className="border px-3 py-2 rounded"
          required
        />
        <button
          type="submit"
          className="bg-blue-500 text-white py-2 rounded hover:bg-blue-600 transition-colors"
        >
          Sign In
        </button>
        {error && <p className="text-red-500 text-sm">{error}</p>}
      </form>
    </main>
  );
}