import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Questions from "../components/Questions";
import Question from "../components/Question";

export default (
  <Router>
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/questions" element={<Questions />} />
      <Route path="/question/:id" element={<Question />} />
    </Routes>
  </Router>
);
