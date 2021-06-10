import React from "react";

class RecipeDetailRow extends React.Component {
  render() {
    const { label, value } = this.props

    if (value !== undefined) {
      if (typeof(value) === 'string' && value.trim().length <= 0) { return null; }

      return (
        <div className="row">
          <div className="col">{label}</div>
          <div className="col">{value}</div>
        </div>
      );
    }

    return null;
  }
}

export default RecipeDetailRow;
