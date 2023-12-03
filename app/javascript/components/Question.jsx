import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const Question = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [question, setQuestion] = useState({ question: "", answers: [] });

  useEffect(() => {
    const url = `/api/v1/questions/${params.id}`;
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

  const answerList = question.answers.map((answer, index) => (
    <div key={index}>
      <div className="card-body">
          { answer.answer }
      </div>
    </div>
  ));

  return (
    <>
    <div>
      { question.question }
    </div>
      <div>
        { answerList }
      </div>
    </>
  );
};

export default Question;
