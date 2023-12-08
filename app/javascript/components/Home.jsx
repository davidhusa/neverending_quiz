import React from "react";
import { Link } from "react-router-dom";
import Question from "../components/Question";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4">Quiz Game</h1>
        <div>
          Welcome to the quiz game. Select your answer and you'll be told if you're right or wrong.
          Keep selecting until you find the correct one and you'll move onto the next question.
        </div>

        <Link
          to="/question/first"
          className="btn btn-lg custom-button"
          role="button"
        >
          Begin
        </Link>
      </div>
    </div>
  </div>
);
