import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import { shuffleArray } from "../utils.js";
import Answer from "./Answer.jsx"

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
        setSelectedIndex(-1);
        shuffleArray(response.answers);
        setQuestion(response);
      })
      .catch(() => navigate("/questions"));
  }, [params.id]);

  const answerCorrect = () => {
    const answer = question.answers[selectedIndex];

    return answer ? question.answers[selectedIndex].correct : false
  }

  const answerList = question.answers.map((answer, index) => (
    <Answer key={answer.id} answer={answer} isActive={selectedIndex === index} selectAnswer={() => setSelectedIndex(index)} />
  ));

  const nextQuestionLinks = () => {
    const links = [];
    if (question.next_question) {
      links.push(<Link key={question.next_question.id} to={`/question/${question.next_question.id}`} className="btn custom-button my-1 w-100">Next Question</Link>);
    }
    if (question.next_topic_first_question) {
      links.push(<Link key={question.next_topic_first_question.id} to={`/question/${question.next_topic_first_question.id}`} className="btn custom-button my-1 w-100">Next Topic</Link>);
    }
    if (links.length === 0) {
      links.push(<Link key="finish" to={`/questions`} className="btn custom-button my-1 w-100">Finish</Link>);
    }
    return links;
  } 

  const correctAnswerResult = <><div className="correct-answer">Correct!</div>{nextQuestionLinks()}</>

  const wrongAnswerResult = <div className="wrong-answer">Incorrect!</div>

  const answerResult = () => {
    if(selectedIndex === -1) return

    return answerCorrect() ? correctAnswerResult : wrongAnswerResult
  }

  return (
      <div className="container">
        <h1>
          { question.question }
        </h1>
        <div>
          { answerList }
        </div>
        <div>
          { answerResult() }
        </div>
      </div>

  );
};

export default Question;
