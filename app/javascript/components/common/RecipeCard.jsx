import React from "react";
import { Link } from "react-router-dom";
import PlaceholderImage from "../../../assets/images/placeholder_image.jpg"

class RecipeCard extends React.Component {
  render() {
    const { recipe } = this.props

    return (
      <div className="col-md-6 col-lg-4">
        <div className="card mb-4">
          <img src={recipe.image_url || PlaceholderImage} className="card-img-top" alt={`${recipe.name} image`} />
          <div className="card-body d-flex justify-content-center">
            <h3 className="card-title d-flex justify-content-center">{recipe.name}</h3>
            <div className="d-flex justify-content-center">
              <Link to={`/recipe/${recipe.id}`} className="btn custom-button">
                View Recipe
              </Link>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default RecipeCard;
