import React from 'react';
import MultiSelect from "react-multi-select-component";

class IngredientsFilter extends React.Component {
  constructor(props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);
    this.state = {
      ingredients: [],
      selectedIngredients: [],
      ingredientsNames: []
    };

    this.handleFiltering = this.handleFiltering.bind(this);
  }

  componentDidMount() {
    const url = '/api/v1/ingredients';

    fetch(url)
      .then(response => {
        if (response.ok) { return response.json(); }

        throw new Error('Network response was not ok.');
      })
      .then(response => {
        let ingredientsNames = response.map((ingredient) => {
          return { label: ingredient.title, value: ingredient.title }
        });

        this.setState({ ingredients: response, ingredientsNames: ingredientsNames });
      })
      .catch(() => this.props.history.push('/recipes'));
  }

  handleChange(newSelectedIngredients) {
    this.setState({ selectedIngredients: newSelectedIngredients });
  }

  handleFiltering(e) {
    e.preventDefault();

    const { selectedIngredients } = this.state
    this.props.filterCb(selectedIngredients);
  }

  render() {
    const { ingredientsNames, selectedIngredients } = this.state;

    return (
      <>
        <MultiSelect
          options={ingredientsNames}
          value={selectedIngredients}
          onChange={this.handleChange}
          labelledBy="Ingredients"
          className="multi-select"
        />
        <button className="btn btn-lg custom-button navigation-button"
                onClick={this.handleFiltering} >
          Filter
        </button>
      </>
    );
  }
}

export default IngredientsFilter;
