import React from "react";
import { Link } from "react-router-dom";
import RecipeDetailRow from "./common/RecipeDetailRow";
import PlaceholderImage from "../../assets/images/placeholder_image.jpg"

class Recipe extends React.Component {
  constructor(props) {
    super(props);
    this.state = { recipe: {}, ingredients: [] };

    this.renderDetails = this.renderDetails.bind(this);
  }

  componentDidMount() {
    const { match: { params: { id } } } = this.props;
    const url = `/api/v1/recipes/${id}`;

    fetch(url)
      .then(response => {
        if (response.ok) { return response.json(); }

        throw new Error('Network response was not ok.');
      })
      .then(response => this.setState({ recipe: response.recipe, ingredients: response.ingredients }))
      .catch(() => this.props.history.push('/recipes'));
  }

  friendlyTime(time) {
    if (time >= 60) {
      let hours = Math.floor(time / 60);

      if (time % 60 === 0) {
        return `${hours} hours`;
      }

      return `${hours} hours ${time % 60} minutes`;
    }

    return `${time} minutes`;
  }

  renderDetails() {
    const { recipe } = this.state;

    return (
      <div className="col-sm-12 col-lg-7">
        <h5 className="mb-2">Details</h5>
        <RecipeDetailRow label="Author:" value={recipe.author} />
        <RecipeDetailRow label="Author Tip:" value={recipe.author_tip} />
        <hr/>
        <RecipeDetailRow label="Servings:" value={recipe.people_quantity} />
        <RecipeDetailRow label="Budget:" value={recipe.budget} />
        <RecipeDetailRow label="Difficulty:" value={recipe.difficulty} />
        <hr/>
        <RecipeDetailRow label="Preparation time:" value={this.friendlyTime(recipe.prep_time)} />
        <RecipeDetailRow label="Cook time:" value={this.friendlyTime(recipe.cook_time)} />
        <RecipeDetailRow label="Total time:" value={this.friendlyTime(recipe.total_time)} />
        <hr/>
        <RecipeDetailRow label="Number of comments and rates:" value={recipe.nb_comments || 0} />
        <RecipeDetailRow label="Rate:" value={`${recipe.rate}/5`} />
      </div>
    );
  }

  renderIngredients() {
    const { ingredients } = this.state;

    let ingredientList = 'No ingredients available';

    if (ingredients && ingredients.length > 0) {
      ingredientList = ingredients.map((ingredient, index) => (
        <li key={index} className='list-group-item'>{ingredient.title}</li>
      ));
    }

    return (
      <div className="col-sm-12 col-lg-3">
        <ul className="list-group">
          <h5 className="mb-2">Ingredients</h5>
          {ingredientList}
        </ul>
      </div>
    );
  }

  render() {
    const { recipe } = this.state;

    return (
      <div>
        <div className="hero position-relative d-flex align-items-center justify-content-center">
          <img
            src={recipe.image_url || PlaceholderImage}
            alt={`${recipe.name} image`}
            className="img-fluid position-absolute card-img-top"
          />
          <div className="overlay bg-dark position-absolute" />
          <h1 className="display-4 position-relative text-white recipe-name d-flex justify-content-center">
            {recipe.name}
          </h1>
        </div>
        <div className="container py-5">
          <div className="row">
            {this.renderIngredients()}
            {this.renderDetails()}
          </div>
          <div className="d-flex justify-content-center">
            <Link to="/recipes" className="btn btn-lg custom-button navigatio-button margin-top">
              Back to recipes
            </Link>
          </div>
        </div>
      </div>
    );
  }
}

export default Recipe;
