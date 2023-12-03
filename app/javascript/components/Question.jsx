import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import Answer from "./Answer"

const Question = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [question, setQuestion] = useState({ question: "", answers: [], next_question: { id: 0 } });
  const [selectedIndex, setSelectedIndex] = useState(-1);

  useEffect(() => {
    const url = `/api/v1/questions/${params.id}`;
    fetch(url)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("fetch failed");
      })
      .then((response) => {
        setSelectedIndex(-1)
        setQuestion(response)
      })
      .catch(() => navigate("/questions"));
  }, [params.id]);

  const answerCorrect = () => {
    let answer = question.answers[selectedIndex];

    return answer ? question.answers[selectedIndex].correct : false
  }

  const answerList = question.answers.map((answer, index) => (
    <Answer key={answer.id} answer={answer} isActive={selectedIndex === index} selectAnswer={() => setSelectedIndex(index)} />
  ));

  const nextQuestionLink = <Link to={`/question/${question.next_question.id}`} className="btn custom-button my-1 w-100">Next Question</Link>

  return (
    <div className="m-3">
      <h1>
        { question.question }
      </h1>
      <div className="container">
        { answerList }
      </div>
      { answerCorrect() ? nextQuestionLink : ''}
    </div>
  );
};

export default Question;
