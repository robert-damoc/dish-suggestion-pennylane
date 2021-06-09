import React from "react";

class Title extends React.Component {
  render() {
    return (
      <>
        <h1 className="display-4 d-flex justify-content-center">{this.props.titleText}</h1>
        <p className="lead">{this.props.subtitleText}</p>
      </>
    );
  }
}

export default Title;
