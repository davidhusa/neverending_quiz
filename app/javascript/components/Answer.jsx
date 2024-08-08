import React, { useState, useEffect } from "react";

const Answer = (props) => {
  const activeClass = () => {
    let cssClass = 'answer ';
    if (!props.isActive) return cssClass;

    return props.answer.correct ? cssClass + 'correct' : cssClass + 'wrong';
  }

  return (
    <div className="">
      <div className={activeClass()} onClick={props.selectAnswer}>
        { props.answer.answer }
      </div>
    </div>
  );
}

export default Answer;
