import React, { useState, useEffect } from "react";

const Answer = (props) => {
  const activeClass = () => {
    if (!props.isActive) return 'card-body'

    return props.answer.correct ? 'card-body correct' : 'card-body wrong'
  }

  return (
    <div className="row">
      <div className={activeClass()} onClick={props.selectAnswer}>
        { props.answer.answer }
      </div>
    </div>
  );
}

export default Answer;
