import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Questions = () => {
  const navigate = useNavigate();
  const [questions, setQuestions] = useState([]);

  


  useEffect(() => {
    const url = "/api/v1/questions/index";
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("fetch failed");
      })
      .then((res) => setQuestions(res))
      .catch(() => navigate("/"));
  }, []);

  const questionsList = questions.map((question, index) => (
    <div key={index}>
      <div className="card-body">
        <Link to={`/question/${question.id}`} className="btn custom-button my-1 w-100">
          {question.question}
        </Link>
      </div>
    </div>
  ));

  return (
    <>
      <section className="jumbotron jumbotron-fluid text-center">
        <h3 className="container py-5">
          Questions
        </h3>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="row">
            {questionsList}
          </div>
          <Link to="/" className="btn btn-link">
            Reset to beginning
          </Link>
        </main>
      </div>
    </>
  );
};

export default Questions;
