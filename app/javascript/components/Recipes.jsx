import React from "react";
import { Link } from "react-router-dom";
import Title from "./common/Title";
import RecipeCard from "./common/RecipeCard";
import IngredientsFilter from "./IngredientsFilter";

class Recipes extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      recipes: []
    };

    this.fetchRecipesFiltered = this.fetchRecipesFiltered.bind(this);
  }

  componentDidMount() {
      const url = '/api/v1/recipes';

      fetch(url)
        .then(response => {
          if (response.ok) { return response.json(); }

          throw new Error('Network response was not ok.');
        })
        .then(response => this.setState({ recipes: response }))
        .catch(() => this.props.history.push('/'));
  }

  fetchRecipes(ingredients_params) {
    let url = '/api/v1/recipes';

    if (ingredients_params) {
      url += '?';
      ingredients_params.forEach((ingredient, index) => {
        if (index !== 0) { url += '&'; }

        url += `ingredients[]=${encodeURIComponent(ingredient.value)}`;
      });
    }

      fetch(url)
        .then(response => {
          if (response.ok) { return response.json(); }

          throw new Error('Network response was not ok.');
        })
        .then(response => this.setState({ recipes: response }))
        .catch(() => this.props.history.push('/'));
  }

  renderRecipes() {
    const { recipes } = this.state;

    if (recipes.length <= 0) {
      return (
        <div className="row">
          <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
            <h4>No recipes yet.</h4>
          </div>
        </div>
      );
    }

    let recipesList = []

    for (let i = 0; i < recipes.length && i < 6; i += 3) {
      recipesList.push(
        <div className="row" key={"row-" + i / 3}>
          {recipes[i] ? <RecipeCard recipe = {recipes[i]} key = {i} /> : null}
          {recipes[i + 1] ? <RecipeCard recipe = {recipes[i + 1]} key = {i + 1} /> : null}
          {recipes[i + 2] ? <RecipeCard recipe = {recipes[i + 2]} key = {i + 2} /> : null}
        </div>
      );
    }

    return recipesList;
  }

  fetchRecipesFiltered(ingredients) {
    if (ingredients.length === 0) { return; }

    this.fetchRecipes(ingredients);
  }

  render() {
    const subtitleText = "We’ve pulled together our most popular recipes " +
                         "so there’s sure to be something tempting for you."

    return (
      <>
        <section className="jumbotron jumbotron-fluid text-center">
          <div className="container py-5">
            <Title titleText = "List of Recipes" subtitleText = {subtitleText} />
          </div>
        </section>
        <div className="container d-flex justify-content-center filter-container">
          <IngredientsFilter filterCb={this.fetchRecipesFiltered} />
        </div>
        <main className="container recipes-container">
          {this.renderRecipes()}
          <div className="d-flex justify-content-center">
            <Link to="/" className="btn btn-lg custom-button navigatio-button">
              Home
            </Link>
          </div>
        </main>
      </>
    );
  }
}

export default Recipes;
