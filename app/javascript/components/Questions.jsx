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
        <h5 className="card-title"></h5>
        <Link to={`/question/${question.id}`} className="btn custom-button">
          {question.question}
        </Link>
      </div>
    </div>
  ));

  return (
    <>
      <section className="jumbotron jumbotron-fluid text-center">
        <div className="container py-5">
          <h1 className="display-4">List</h1>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="row">
            {questionsList}
          </div>
          <Link to="/" className="btn btn-link">
            Home
          </Link>
        </main>
      </div>
    </>
  );
};



export default Questions;