import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const Question = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [question, setQuestion] = useState({ question: "" });

  useEffect(() => {
    const url = `/api/v1/show/${params.id}`;
    fetch(url)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("fetch failed");
      })
      .then((response) => setQuestion(response))
      .catch(() => navigate("/questions"));
  }, [params.id]);

  return (
    <div>
      { question.question }
    </div>
  );
};

export default Question;
